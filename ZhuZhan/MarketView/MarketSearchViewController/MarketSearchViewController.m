//
//  MarketSearchViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/5.
//
//

#import "MarketSearchViewController.h"
#import "SearchMenuView.h"
#import "RecommendFriendSearchController.h"
#import "ALLProjectViewController.h"
#import "MoreCompanyViewController.h"
#import "MarketSearchProductController.h"
@interface MarketSearchViewController ()<SearchMenuViewDelegate>
@property(nonatomic,strong)NSMutableArray* models;
@property (nonatomic, strong)NSArray* menuTitles;
@property (nonatomic, strong)UIViewController* vc;
@property (nonatomic, copy)NSString* searchCategory;
@end

@implementation MarketSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    [self setUpSearchBarExtra];
    
    [self.searchBar becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"ConstractListControllerReloadDataNotification" object:nil];
}

- (void)setUpSearchBarExtra{
    UITextField* searchField = [self.searchBar valueForKey:@"_searchField"];
    UILabel* placeholderLabel = [searchField valueForKey:@"_placeholderLabel"];
    
    UIButton* leftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 20)];
    {
        [leftView addTarget:self action:@selector(menuBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        searchField.leftView = leftView;
        
        UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 30, 20)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.text = @"用户";
        textLabel.textColor = AllDeepGrayColor;
        [leftView addSubview:textLabel];
        textLabel.userInteractionEnabled = NO;
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(39, 7.5, 10, 5)];
        imageView.image = [GetImagePath getImagePath:@"searcharrow"];
        [leftView addSubview:imageView];
    }
    
    
    placeholderLabel.text = @"请输入搜索词";
}

- (void)menuBtnClicked{
    CGPoint originPoint = CGPointMake(50, 40);
    SearchMenuView* menuView = [SearchMenuView searchMenuViewWithTitles:@[@"用户",@"公司",@"项目",@"产品"] originPoint:originPoint];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    NSLog(@"menuBtnClicked");
}

- (void)searchMenuViewClickedWithTitle:(NSString *)title index:(NSInteger)index{
    UIView* leftView=[self.searchBar valueForKeyPath:@"_searchField.leftView"];
    [leftView.subviews[0] setText:title];
    NSLog(@"搜索条件变更");
    self.searchCategory = title;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    NSInteger index = [self.menuTitles indexOfObject:self.searchCategory];
//    switch (<#expression#>) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
//        RecommendFriendSearchController* vc = [[RecommendFriendSearchController alloc] initWithTableViewBounds:self.view.bounds];
//        [vc view];
//    
//        CGRect frame = vc.tableView.frame;
//        frame.origin.y += CGRectGetMaxY(self.searchBar.frame);
//        frame.size.height -= CGRectGetMaxY(self.searchBar.frame);
//        vc.tableView.frame = frame;
//        [self.view addSubview:vc.tableView];
//    
//        [vc loadListWithKeyWords:searchBar.text];
    
    
//        ALLProjectViewController* vc = [[ALLProjectViewController alloc] init];
//        [vc view];
//            CGRect frame = vc.tableView.frame;
//            frame.origin.y += CGRectGetMaxY(self.searchBar.frame);
//            frame.size.height -= CGRectGetMaxY(self.searchBar.frame);
//            vc.tableView.frame = frame;
//            [self.view addSubview:vc.tableView];
    
//    MoreCompanyViewController* vc = [[MoreCompanyViewController alloc] init];
//    [vc view];
//    CGRect frame = vc.tableView.frame;
//    frame.origin.y = CGRectGetMaxY(self.searchBar.frame);
//    frame.size.height = kScreenHeight-CGRectGetMaxY(self.searchBar.frame);
//    vc.tableView.frame = frame;
//    [self.view addSubview:vc.tableView];
    
    MarketSearchProductController* vc = [[MarketSearchProductController alloc] init];
    vc.keyWords = searchBar.text;
    vc.superViewController = self;
    [vc view];
    CGRect frame = vc.tableView.frame;
    frame.origin.y = CGRectGetMaxY(self.searchBar.frame);
    frame.size.height = kScreenHeight-CGRectGetMaxY(self.searchBar.frame);
    vc.tableView.frame = frame;
    [self.view addSubview:vc.tableView];
    
    self.vc = vc;
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%d",(int)indexPath.row];
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexpath=%d",indexPath.row);
}

-(void)error{
    [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请测试记下当前的合同各个状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
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
        for (int i=0;i<10;i++) {
            [_models addObject:@""];
        }
    }
    return _models;
}

-(void)getSearchBarBackBtn{
    UIView* button=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.searchBar.frame)+64, kScreenWidth, CGRectGetHeight(self.view.frame))];
    button.backgroundColor=[UIColor whiteColor];
    self.searchBarBackBtn=button;
    [self.view addSubview:self.searchBarBackBtn];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ConstractListControllerReloadDataNotification" object:nil];
}
@end
