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
@interface CompanyMemberViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,strong)NSString *keyKords;
@property(nonatomic)int startIndex;
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
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startIndex = 0;
    self.keyKords = @"";
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
        }
    } companyId:self.companyId startIndex:self.startIndex keyWords:self.keyKords];
    [self initSearchView];
    [self initMyTableViewAndNavi];
    
    //集成刷新控件
    [self setupRefresh];
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
    if (![ConnectionAvailable isConnectionAvailable]) {
        [self judgeConnect];
    }else{
        self.startIndex = 0;
        [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                self.showArr = posts;
                [self.tableView footerEndRefreshing];
                [self.tableView headerEndRefreshing];
                [self.tableView reloadData];
            }
        } companyId:self.companyId startIndex:self.startIndex keyWords:self.keyKords];
    }
}

-(void)judgeConnect{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide =YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"当前网络不可用，请检查网络连接！";
    hud.labelFont = [UIFont fontWithName:nil size:14];
    hud.minSize = CGSizeMake(132.f, 108.0f);
    [hud hide:YES afterDelay:3];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshing];
}

- (void)footerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [self judgeConnect];
    }else{
        self.startIndex = self.startIndex +1;
        [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [self.showArr addObjectsFromArray:posts];
                [self.tableView footerEndRefreshing];
                [self.tableView headerEndRefreshing];
                [self.tableView reloadData];
            }
        } companyId:self.companyId startIndex:self.startIndex keyWords:self.keyKords];
    }
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
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyMemberCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[CompanyMemberCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        [cell.rightBtn addTarget:self action:@selector(chooseApprove:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell setModel:self.showArr[indexPath.row] indexPathRow:indexPath.row];
    return cell;
}

-(void)chooseApprove:(UIButton*)btn{
    if (btn.tag>=0) {
        EmployeesModel *model = self.showArr[btn.tag];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[LoginSqlite getdata:@"userId" defaultdata:@""] forKey:@"UserId"];
        [dic setValue:model.a_id forKey:@"FocusId"];
        [dic setValue:@"Personal" forKey:@"FocusType"];
        [dic setValue:@"Personal" forKey:@"UserType"];
        [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                model.a_isFocused=@"1";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:NO];
            }
        } dic:dic];
    }
}

//======================================================================
//======================================================================
//======================================================================

-(void)initSearchView{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 43)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.backgroundColor=[UIColor redColor];
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
}

-(void)initMyTableViewAndNavi{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.tableHeaderView=self.searchBar;
    [self.view addSubview:self.tableView];
    self.title = @"公司员工";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.startIndex = 0;
    self.keyKords = searchBar.text;
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
            self.searchBar.showsCancelButton = YES;
        }
    } companyId:self.companyId startIndex:self.startIndex keyWords:self.keyKords];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.startIndex = 0;
    self.keyKords = @"";
    self.searchBar.text = nil;
    [CompanyApi GetCompanyEmployeesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
            self.searchBar.showsCancelButton = NO;
        }
    } companyId:self.companyId startIndex:self.startIndex keyWords:self.keyKords];
}
@end
