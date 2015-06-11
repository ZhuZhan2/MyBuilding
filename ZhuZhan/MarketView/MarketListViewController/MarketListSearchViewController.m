//
//  MarketListSearchViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import "MarketListSearchViewController.h"
#import "MJRefresh.h"
#import "MyTableView.h"
#import "MarketApi.h"
#import "MarketModel.h"
#import "MarkListTableViewCell.h"
#import "LoginViewController.h"
#import "LoginSqlite.h"
#import "RequirementDetailViewController.h"
@interface MarketListSearchViewController ()<MarkListTableViewCellDelegate,LoginViewDelegate>
@property(nonatomic)int startIndex;
@property(nonatomic,strong)NSMutableArray *modelsArr;
@property(nonatomic,strong)NSString *keyWords;
@property(nonatomic,strong)NSString *isOpenStr;
@end

@implementation MarketListSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    [self.searchBar becomeFirstResponder];
    
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewAppearOrDisappear:YES];
}

-(void)viewAppearOrDisappear:(BOOL)isAppear{
    self.navigationController.navigationBarHidden=isAppear;
    [[UIApplication sharedApplication] setStatusBarStyle:isAppear?UIStatusBarStyleDefault:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self viewAppearOrDisappear:NO];
}

-(NSMutableArray *)modelsArr{
    if(!_modelsArr){
        _modelsArr = [NSMutableArray array];
    }
    return _modelsArr;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.searchBarTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.searchBarTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void)getSearchBarBackBtn{
    UIView* button=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.searchBar.frame)+64+CGRectGetHeight(self.stageChooseView.frame), kScreenWidth, CGRectGetHeight(self.view.frame))];
    button.backgroundColor=[UIColor whiteColor];
    self.searchBarBackBtn=button;
    [self.view addSubview:self.searchBarBackBtn];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [super searchBarSearchButtonClicked:searchBar];
    [self searchListWithKeyword:searchBar.text];
}

-(void)searchListWithKeyword:(NSString*)keyword{
    self.keyWords = keyword;
    if(self.isPublic){
        [self getPublicData];
    }else{
        if(self.isOpen){
            self.isOpenStr = @"00";
        }else{
            self.isOpenStr = @"01";
        }
        [self getMyData];
    }
}

- (NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArr.count;
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MarkListTableViewCell carculateCellHeightWithModel:self.modelsArr[indexPath.row]];
}

- (UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"Cell"];
    MarkListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[MarkListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.marketModel = self.modelsArr[indexPath.row];
    cell.contentView.backgroundColor = AllBackLightGratColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        MarketModel *model = self.modelsArr[indexPath.row];
        RequirementDetailViewController* vc = [[RequirementDetailViewController alloc] initWithTargetId:model.a_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [self headerRereshing];
    if(block){
        block();
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if(self.isPublic){
        [self getPublicData];
    }else{
        if(self.isOpen){
            self.isOpenStr = @"00";
        }else{
            self.isOpenStr = @"01";
        }
        [self getMyData];
    }
}

- (void)footerRereshing
{
    if(self.isPublic){
        [self getPublicDataMore];
    }else{
        if(self.isOpen){
            self.isOpenStr = @"00";
        }else{
            self.isOpenStr = @"01";
        }
        [self getMyDataMore];
    }
}

-(void)getPublicData{
    self.startIndex = 0;
    [MarketApi GetAllPublicListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.modelsArr removeAllObjects];
            self.modelsArr = posts;
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.searchBarTableView];
                [MyTableView noSearchData:self.searchBarTableView];
            }else{
                [MyTableView removeFootView:self.searchBarTableView];
                [self.searchBarTableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self searchListWithKeyword:self.keyWords];
                }];
            }
        }
        [self.searchBarTableView headerEndRefreshing];
    } startIndex:0 requireType:@"" keywords:self.keyWords noNetWork:^{
        [self.searchBarTableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self searchListWithKeyword:self.keyWords];
        }];
    }];
}

-(void)getPublicDataMore{
    [MarketApi GetAllPublicListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.modelsArr addObjectsFromArray:posts];
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.searchBarTableView];
                [MyTableView noSearchData:self.searchBarTableView];
            }else{
                [MyTableView removeFootView:self.searchBarTableView];
                [self.searchBarTableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self searchListWithKeyword:self.keyWords];
                }];
            }
        }
        [self.searchBarTableView footerEndRefreshing];
    } startIndex:self.startIndex+1 requireType:@"" keywords:self.keyWords noNetWork:^{
        [self.searchBarTableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self searchListWithKeyword:self.keyWords];
        }];
    }];
}


-(void)getMyData{
    self.startIndex = 0;
    [MarketApi GetAllMyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.modelsArr removeAllObjects];
            self.modelsArr = posts;
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self searchListWithKeyword:self.keyWords];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } startIndex:0 requireType:@"" keywords:self.keyWords isOpen:self.isOpenStr noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self searchListWithKeyword:self.keyWords];
        }];
    }];
}

-(void)getMyDataMore{
    [MarketApi GetAllMyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.modelsArr addObjectsFromArray:posts];
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self searchListWithKeyword:self.keyWords];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } startIndex:self.startIndex+1 requireType:@"" keywords:self.keyWords isOpen:self.isOpenStr noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self searchListWithKeyword:self.keyWords];
        }];
    }];
}
@end
