//
//  MoreCompanyViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-4.
//
//

#import "MoreCompanyViewController.h"
#import "MoreCompanyViewCell.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "CompanyDetailViewController.h"
#import "CompanyApi.h"
#import "CompanyModel.h"
#import "MJRefresh.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "EndEditingGesture.h"
#import "LoadingView.h"
#import "MyTableView.h"
#import "LoginSqlite.h"
#import "CompanyViewController.h"
@interface MoreCompanyViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,CompanyDetailDelegate,LoginViewDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic)NSInteger lastIndex;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic)BOOL isHasCompany;
@property(nonatomic,copy)NSString* companyId;
@end

@implementation MoreCompanyViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.isCompanyIdentify) return;
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isCompanyIdentify) return;
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSearchView];
    [self initMyTableViewAndNavi];
    
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        [self hasCompany];
    }else{
        self.isHasCompany = NO;
    }
    
    //集成刷新控件
    [self setupRefresh];
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view];
    [self firstNetWork];
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

-(void)hasCompany{
    [CompanyApi HasCompanyWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.isHasCompany = [posts[0][@"exists"] boolValue];
            self.companyId = posts[0][@"companyId"];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
    } noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64-49) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)firstNetWork{
    startIndex = 0;
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            if(self.showArr.count == 0){
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [self removeMyLoadingView];
    } startIndex:0 keyWords:self.keywords noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            startIndex = 0;
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                if([self.keywords isEqualToString:@""]){
                    [MyTableView hasData:self.tableView];
                }else{
                    [MyTableView noSearchData:self.tableView];
                }
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }

        }
        [self.tableView headerEndRefreshing];
    } startIndex:0 keyWords:self.keywords noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

- (void)footerRereshing
{
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            startIndex++;
            [self.showArr addObjectsFromArray:posts];
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                if([self.keywords isEqualToString:@""]){
                    [MyTableView hasData:self.tableView];
                }else{
                    [MyTableView noSearchData:self.tableView];
                }
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }

        }
        [self.tableView footerEndRefreshing];
    } startIndex:startIndex+1 keyWords:self.keywords noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self footerRereshing];
        }];
    }];
}

-(UIImage*)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)back{
    [self.nowViewController.navigationController popViewControllerAnimated:YES];
}

-(void)changeButtonImage:(UIButton*)button{
    [button setImage:[GetImagePath getImagePath:@"bg-addbutton-highlighted"] forState:UIControlStateNormal];
}
//======================================================================
//UIScrollViewDelegate
//======================================================================
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

//======================================================================
//UITableViewDataSource,UITableViewDelegate
//======================================================================

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastIndex=indexPath.row;
    [self gotoCompanyDetail:YES];
}

-(void)gotoCompanyDetail:(BOOL)needAnimation{
    CompanyModel *model = self.showArr[self.lastIndex];
    CompanyDetailViewController* vc=[[CompanyDetailViewController alloc]init];
    vc.delegate=self;
    vc.companyId = model.a_id;
    [self.nowViewController.navigationController pushViewController:vc animated:needAnimation];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCompanyViewCell* cell=[MoreCompanyViewCell getCellWithTableView:tableView style:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

    //公司内容部分
    CompanyModel *model = self.showArr[indexPath.row];
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_companyLogo]] placeholderImage:[GetImagePath getImagePath:@"公司－公司组织_05a"]];
    cell.companyNameLabel.text=[NSString stringWithFormat:@"%@",model.a_companyName];
    cell.companyBusiness.text=[NSString stringWithFormat:@"企业行业：%@",model.a_companyIndustry];
    cell.companyIntroduce.text=[NSString stringWithFormat:@"%@位关注者",model.a_companyFocusNumber];
    cell.accessoryView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"公司－公司组织_03a"]];
    
    return cell;
}

-(UIView*)getSeparatorLine{
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    return separatorLine;
}

//======================================================================
//======================================================================
//======================================================================

-(void)initSearchView{
    startIndex = 0;
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 43)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
    [self.view addSubview:self.searchBar];
}

-(void)initMyTableViewAndNavi{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y+self.searchBar.frame.size.height, 320, self.isCompanyIdentify?kScreenHeight-43-64:kScreenHeight-49-43-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[MoreCompanyViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundColor = AllBackLightGratColor;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableView];
    
    self.title = @"企业组织";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"我的企业" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myCompanyAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)myCompanyAction{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel = YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
            CompanyDetailViewController *view = [[CompanyDetailViewController alloc] init];
            view.companyId = [LoginSqlite getdata:@"userId"];
            [self.navigationController pushViewController:view animated:YES];
        }else{
            if(self.isHasCompany){
                CompanyDetailViewController *view = [[CompanyDetailViewController alloc] init];
                view.companyId = self.companyId;
                [self.navigationController pushViewController:view animated:YES];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"你还未申请加入公司或申请还没被批准，赶快搜索企业进行申请吧！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
    }
}

-(void)dealloc{
    NSLog(@"more dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (!self.view.gestureRecognizers.count) {
        [EndEditingGesture addGestureToView:self.view];
    }
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    if (self.view.gestureRecognizers.count) {
        [self.view removeGestureRecognizer:self.view.gestureRecognizers[0]];
    }
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if([[searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入搜索条件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    self.keywords = searchBar.text;
    startIndex = 0;
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView noSearchData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
            [self.searchBar setShowsCancelButton:YES animated:YES];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }

        }
    }startIndex:0 keyWords:self.keywords noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self searchBarSearchButtonClicked:searchBar];
        }];
    }];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.keywords = @"";
    self.searchBar.text = nil;
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            startIndex = 0;
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
            [self.searchBar setShowsCancelButton:NO animated:YES];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
    } startIndex:0 keyWords:self.keywords noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self searchBarCancelButtonClicked:searchBar];
        }];
    }];
    [self.searchBar resignFirstResponder];
}

- (NSString *)keywords{
    if (!_keywords) {
        _keywords = @"";
    }
    return _keywords;
}

- (UIViewController *)nowViewController{
    if (!_nowViewController) {
        _nowViewController = self;
    }
    return _nowViewController;
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [self hasCompany];
    if(block){
        block();
    }
}
@end
