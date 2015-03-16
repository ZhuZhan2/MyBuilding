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
@interface MoreCompanyViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,CompanyDetailDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic)NSInteger lastIndex;
@property(nonatomic,strong)LoadingView *loadingView;
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
    //集成刷新控件
    [self setupRefresh];
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view];
    [self firstNetWork];
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

-(void)firstNetWork{
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
            [LoginAgain AddLoginView:NO];
        }
        [self removeMyLoadingView];
    } startIndex:0 keyWords:@"" noNetWork:^{
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
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            [LoginAgain AddLoginView:NO];
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
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            [LoginAgain AddLoginView:NO];
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
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationController pushViewController:vc animated:needAnimation];
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
    cell.myImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_companyLogo]];
    cell.companyNameLabel.text=[NSString stringWithFormat:@"%@",model.a_companyName];
    cell.companyBusiness.text=[NSString stringWithFormat:@"公司行业：%@",model.a_companyIndustry];
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
    self.keywords = @"";
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
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableView];
    
    self.title = @"公司组织";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    
    //左back button
    if (!self.isCompanyIdentify) return;
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
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
    self.keywords = searchBar.text;
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
            [self.searchBar setShowsCancelButton:YES animated:YES];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    }startIndex:0 keyWords:[NSString stringWithFormat:@"%@",searchBar.text] noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self searchBarSearchButtonClicked:searchBar];
        }];
    }];
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
            [LoginAgain AddLoginView:NO];
        }
    } startIndex:0 keyWords:@"" noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self searchBarCancelButtonClicked:searchBar];
        }];
    }];
}
@end
