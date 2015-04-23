//
//  DemandListSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "DemandListSearchController.h"
#import "AskPriceApi.h"
#import "AskPriceViewCell.h"
#import "AskPriceDetailViewController.h"
#import "QuotesDetailViewController.h"
#import "MJRefresh.h"
@interface DemandListSearchController ()
@property(nonatomic,strong)NSString *statusStr;
@property(nonatomic,strong)NSString *otherStr;
@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic,strong)NSString *keyWords;
@property (nonatomic)NSInteger startIndex;
@end

@implementation DemandListSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusStr = @"";
    self.otherStr = @"-1";
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    [self.searchBar becomeFirstResponder];
    
    //集成刷新控件
    [self setupRefresh];
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [super searchBarSearchButtonClicked:searchBar];
    [self searchListWithKeyword:searchBar.text];
}

-(void)searchListWithKeyword:(NSString*)keyword{
    self.keyWords = keyword;
    [AskPriceApi GetAskPriceWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.models = posts[0];
            [self.searchBarTableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } status:self.statusStr startIndex:0 other:self.otherStr keyWorks:keyword noNetWork:^{
        [ErrorCode alert];
    }];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
    [AskPriceApi GetAskPriceWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.models removeAllObjects];
            self.models = posts[0];
            [self.stageChooseView changeNumbers:@[posts[1][@"totalCount"],posts[1][@"processingCount"],posts[1][@"completeCount"],posts[1][@"offCount"]]];
            [self.searchBarTableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self.searchBarTableView headerEndRefreshing];
    } status:self.statusStr startIndex:0 other:self.otherStr keyWorks:self.keyWords noNetWork:^{
        [ErrorCode alert];
    }];
}

- (void)footerRereshing
{
    [AskPriceApi GetAskPriceWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.models addObjectsFromArray:posts[0]];
            [self.stageChooseView changeNumbers:@[posts[1][@"totalCount"],posts[1][@"processingCount"],posts[1][@"completeCount"],posts[1][@"offCount"]]];
            [self.searchBarTableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self.searchBarTableView footerEndRefreshing];
    } status:self.statusStr startIndex:(int)self.startIndex+1 other:self.otherStr keyWorks:self.keyWords noNetWork:^{
        [ErrorCode alert];
    }];
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceModel *model = self.models[indexPath.row];
    if([model.a_category isEqualToString:@"0"]){
        return [AskPriceViewCell carculateTotalHeightWithContents:@[model.a_invitedUser,model.a_productBigCategory,model.a_productCategory,model.a_remark]];
    }else{
        return [AskPriceViewCell carculateTotalHeightWithContents:@[model.a_requestName,model.a_productBigCategory,model.a_productCategory,model.a_remark]];
    }
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AskPriceViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    AskPriceModel *model = self.models[indexPath.row];
    if([model.a_category isEqualToString:@"0"]){
        cell.contents=@[model.a_invitedUser,model.a_productBigCategory,model.a_productCategory,model.a_remark,model.a_category,model.a_tradeStatus,model.a_tradeCode];
    }else{
        cell.contents=@[model.a_requestName,model.a_productBigCategory,model.a_productCategory,model.a_remark,model.a_category,model.a_tradeStatus,model.a_tradeCode];
    }
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceModel *model = self.models[indexPath.row];
    if([model.a_category isEqualToString:@"0"]){
        NSLog(@"自己发");
        AskPriceDetailViewController *view = [[AskPriceDetailViewController alloc] init];
        view.tradId = model.a_id;
        [self.navigationController pushViewController:view animated:YES];
    }else{
        NSLog(@"别人发");
        QuotesDetailViewController *view = [[QuotesDetailViewController alloc] init];
        view.tradId = model.a_id;
        [self.navigationController pushViewController:view animated:YES];
    }
    self.searchBarAnimationBackView.hidden=YES;
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

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
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
@end
