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
@interface CompanyMemberViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>//,UIScrollViewDelegate>
@property(nonatomic)NSInteger memberNumber;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@end

@implementation CompanyMemberViewController
-(id)initWithMemberNumber:(NSInteger)number{
    if ([self init]) {
        self.memberNumber=number;
    }
    return self;
}

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
    self.memberNumber=25;
    [self initSearchView];
    [self initMyTableViewAndNavi];
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

-(void)changeButtonImage:(UIButton*)button{
    [button setImage:[UIImage imageNamed:@"bg-addbutton-highlighted"] forState:UIControlStateNormal];
}

//===========================================================================
//UIScrollViewDelegate
//===========================================================================
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

//===========================================================================
//UITableViewDataSource,UITableViewDelegate
//===========================================================================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memberNumber+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row?60:50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    if (cell.contentView.subviews.count) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    //搜索栏
    if (indexPath.row==0) {
        [cell.contentView addSubview:self.searchBar];
        cell.textLabel.text=nil;
        cell.imageView.image=nil;
        cell.detailTextLabel.text=nil;
        cell.accessoryView=nil;
    }
    //公司认证员工部分
    if (indexPath.row!=0) {
        UIView* separatorLine=[self getSeparatorLine];
        [cell.contentView addSubview:separatorLine];
        cell.textLabel.text=[NSString stringWithFormat:@"用户名显示%d",indexPath.row-1];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
        cell.imageView.image=[UIImage imageNamed:@"公司认证员工_03a.png"];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"部门职位"];
        cell.detailTextLabel.textColor=RGBCOLOR(155, 155, 155);
        cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:13];
        cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:indexPath.row%2?@"公司认证员工_08a.png":@"公司认证员工_18a.png"]];
    }
    return cell;
}

-(UIView*)getSeparatorLine{
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    separatorLine.center=CGPointMake(160, 59.5);
    return separatorLine;
}

//===========================================================================
//===========================================================================
//===========================================================================

-(void)initSearchView{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //self.searchBar.placeholder = @"搜索";
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
    [self.view addSubview:self.tableView];
    self.title = @"公司员工";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)dealloc{
    NSLog(@"member dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
