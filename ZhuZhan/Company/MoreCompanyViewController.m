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
@interface MoreCompanyViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@end

@implementation MoreCompanyViewController

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
    startIndex = 0;
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
        }
    } startIndex:startIndex];
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
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }else{
        startIndex = 0;
        [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                self.showArr = posts;
                [self.tableView footerEndRefreshing];
                [self.tableView headerEndRefreshing];
                [self.tableView reloadData];
            }
        } startIndex:startIndex];
    }
}

- (void)footerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }else{
        startIndex = startIndex +1;
        [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [self.showArr addObjectsFromArray:posts];
                [self.tableView footerEndRefreshing];
                [self.tableView headerEndRefreshing];
                [self.tableView reloadData];
            }
        } startIndex:startIndex];
    }
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
    CompanyModel *model = self.showArr[indexPath.row-1];
    CompanyDetailViewController* vc=[[CompanyDetailViewController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row?94:43;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCompanyViewCell* cell=[MoreCompanyViewCell getCellWithTableView:tableView style:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (cell.contentView.subviews.count) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    //搜索栏
    if (indexPath.row==0) {
        [cell.contentView addSubview:self.searchBar];
        cell.myImageView.image=nil;
        cell.companyNameLabel.text=nil;
        cell.companyBusiness.text=nil;
        cell.companyIntroduce.text=nil;
        cell.accessoryView=nil;
    
    //公司内容部分
    }else{
        CompanyModel *model = self.showArr[indexPath.row-1];
        UIView* separatorLine=[self getSeparatorLine];
        [cell.contentView addSubview:separatorLine];
        cell.myImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_companyLogo]];
        cell.companyNameLabel.text=[NSString stringWithFormat:@"公司名称:%@",model.a_companyName];
        cell.companyBusiness.text=[NSString stringWithFormat:@"公司行业:%@",model.a_companyIndustry];
        cell.companyIntroduce.text=[NSString stringWithFormat:@"%@位关注者",model.a_companyFocusNumber];
        cell.accessoryView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"公司－公司组织_03a"]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)getSeparatorLine{
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    separatorLine.center=CGPointMake(160, 93.5);
    return separatorLine;
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
    [self.tableView registerClass:[MoreCompanyViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableView];
    
    self.title = @"公司组织";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)dealloc{
    NSLog(@"more dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
