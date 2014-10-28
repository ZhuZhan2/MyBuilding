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
@interface MoreCompanyViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,strong)NSString *keywords;
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
    startIndex = 0;
    [self initSearchView];
    [self initMyTableViewAndNavi];
    //集成刷新控件
    [self setupRefresh];
    [self firstNetWork];
    [EndEditingGesture addGestureToView:self.view];
}

-(void)addGesture{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
}

-(void)firstNetWork{
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
        }
    } startIndex:0 keyWords:@"" noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
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
            [self.tableView reloadData];
        }
        [self.tableView headerEndRefreshing];
    } startIndex:0 keyWords:self.keywords noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
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
            [self.tableView reloadData];
        }
        [self.tableView footerEndRefreshing];
    } startIndex:startIndex+1 keyWords:self.keywords noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
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
    CompanyModel *model = self.showArr[indexPath.row-1];
    CompanyDetailViewController* vc=[[CompanyDetailViewController alloc]init];
    vc.companyId = model.a_id;
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
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
}

-(void)initMyTableViewAndNavi{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.isCompanyIdentify?568:568-49) style:UITableViewStylePlain];
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
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.keywords = searchBar.text;
    [CompanyApi GetCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            startIndex = 0;
            self.showArr = posts;
            [self.tableView reloadData];
            self.searchBar.showsCancelButton = YES;
        }
    }startIndex:0 keyWords:[NSString stringWithFormat:@"%@",searchBar.text] noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
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
            [self.tableView reloadData];
            self.searchBar.showsCancelButton = NO;
        }
    } startIndex:0 keyWords:@"" noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self searchBarCancelButtonClicked:searchBar];
        }];
    }];
}
@end
