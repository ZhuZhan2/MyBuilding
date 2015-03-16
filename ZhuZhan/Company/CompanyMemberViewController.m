//
//  CompanyMemberViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-7.
//
//

#import "CompanyMemberViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "CompanyApi.h"
#import "EmployeesModel.h"
#import "ContactModel.h"
#import "MJRefresh.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "CompanyMemberCell.h"
#import "LoginSqlite.h"
#import "EndEditingGesture.h"
#import "PersonalDetailViewController.h"
#import "LoadingView.h"
#import "MyTableView.h"
@interface CompanyMemberViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,strong)NSString *keyKords;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation CompanyMemberViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, 568) superView:self.view];
    [self firstNetWork];
}

-(void)firstNetWork{
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
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
    } companyId:self.companyId startIndex:self.startIndex keyWords:self.keyKords noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

//集成刷新控件
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
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex = 0;
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
    } companyId:self.companyId startIndex:0 keyWords:self.keyKords noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64-49) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

- (void)footerRereshing
{
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
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
    } companyId:self.companyId startIndex:self.startIndex+1 keyWords:self.keyKords noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64-49) superView:self.view reloadBlock:^{
            [self footerRereshing];
        }];
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color{
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyMemberCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[CompanyMemberCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell" needRightBtn:NO];
        //暂时移除，目前版本不需要右边的符号
        //[cell.rightBtn addTarget:self action:@selector(chooseApprove:) forControlEvents:UIControlEventTouchUpInside];
        UIButton* btn=[[UIButton alloc]initWithFrame:cell.userImageView.bounds];
        [btn addTarget:self action:@selector(chooseUserImage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.userImageView addSubview:btn];
    }
    //cell.rightBtn.hidden=[[self.showArr[indexPath.row] a_id] isEqualToString:[LoginSqlite getdata:@"userId"]]?YES:NO;
    [cell setModel:self.showArr[indexPath.row] indexPathRow:indexPath.row needCompanyName:NO];
    return cell;
}

-(void)chooseUserImage:(UIButton*)btn{
    if([[self.showArr[btn.superview.tag] a_id] isEqualToString:[LoginSqlite getdata:@"userId"]]){
        return;
    }
    PersonalDetailViewController* vc=[[PersonalDetailViewController alloc]init];
    vc.contactId=[self.showArr[btn.superview.tag] a_id];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"createdBy=%@",vc.contactId);
}

//暂时移除，目前版本不需要右边的符号
//-(void)chooseApprove:(UIButton*)btn{
//    if (![ConnectionAvailable isConnectionAvailable]) {
//        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
//        return;
//    }
//    
//    btn.enabled=NO;
//    EmployeesModel *model = self.showArr[btn.tag];
//    BOOL isFocused=[model.a_isFocused isEqualToString:@"1"];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    if (isFocused) {
//        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
//        [dic setValue:model.a_id forKey:@"FocusId"];
//        [CompanyApi DeleteFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
//            if (!error) {
//                model.a_isFocused=@"0";
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//            }
//            btn.enabled=YES;
//        } dic:dic noNetWork:nil];
//    }else{
//        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
//        [dic setValue:model.a_id forKey:@"FocusId"];
//        [dic setValue:@"Personal" forKey:@"FocusType"];
//        [dic setValue:@"Personal" forKey:@"UserType"];
//        [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
//            if(!error){
//                model.a_isFocused=@"1";
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//            }
//            btn.enabled=YES;
//        } dic:dic noNetWork:nil];
//    }
//}

//==================================================================
//==================================================================
//==================================================================

-(void)initSearchView{
    self.startIndex = 0;
    self.keyKords = @"";
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 43)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
    [self.view addSubview:self.searchBar];
}

-(void)initMyTableViewAndNavi{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y+self.searchBar.frame.size.height, 320, 568-43-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    //self.tableView.tableHeaderView=self.searchBar;
    [self.view addSubview:self.tableView];
    self.title = @"公司员工";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)dealloc{
    NSLog(@"member dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [EndEditingGesture addGestureToView:self.view];
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [self.view removeGestureRecognizer:self.view.gestureRecognizers[0]];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.keyKords = searchBar.text;
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex = 0;
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
            self.searchBar.showsCancelButton = YES;
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } companyId:self.companyId startIndex:0 keyWords:self.keyKords noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64-49) superView:self.view reloadBlock:^{
            [self searchBarSearchButtonClicked:searchBar];
        }];
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.keyKords = @"";
    self.searchBar.text = nil;
    [searchBar resignFirstResponder];
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex = 0;
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
            self.searchBar.showsCancelButton = NO;
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } companyId:self.companyId startIndex:0 keyWords:self.keyKords noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64-49) superView:self.view reloadBlock:^{
            [self searchBarSearchButtonClicked:searchBar];
        }];
    }];
}
@end
