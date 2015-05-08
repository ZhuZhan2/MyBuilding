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
#import "MarketSearchSqlite.h"
#import "RKShadowView.h"
#import "RKViewFactory.h"
@interface MarketSearchViewController ()<SearchMenuViewDelegate>
@property(nonatomic,strong)NSMutableArray* models;
@property (nonatomic, strong)NSArray* menuTitles;
@property (nonatomic, strong)id vc;
@property (nonatomic, strong)id vc1;

@property (nonatomic, copy)NSString* searchCategory;
@end

@implementation MarketSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    [self setUpSearchBarExtra];
    self.searchBarTableView.backgroundColor = [UIColor whiteColor];
    [self setTableViewFooterView];
    
    NSLog(@"path=%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    [self.searchBar becomeFirstResponder];
}

- (void)setTableViewFooterView{
    UIView* back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    
    UIButton* imageViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 35)];
    imageViewBtn.center = back.center;
    [imageViewBtn setImage:[GetImagePath getImagePath:@"search_cleanios"] forState:UIControlStateNormal];
    [imageViewBtn addTarget:self action:@selector(deleteAllRecord) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:imageViewBtn];
    
    self.searchBarTableView.tableFooterView = back;
}

- (void)deleteAllRecord{
    NSInteger type = [self.menuTitles indexOfObject:self.searchCategory];
    [MarketSearchSqlite delAllRecordWithType:type];
    [self reloadSearchModelWithCategory:self.searchCategory type:type];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.searchBarTableViewController.view.superview) {
        [self searchBarTableViewAppear];
    }
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
    CGPoint originPoint = CGPointMake(!self.searchBar.text.length&&!self.searchBar.isFirstResponder?68:16, 52);
    SearchMenuView* menuView = [SearchMenuView searchMenuViewWithTitles:self.menuTitles originPoint:originPoint];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    NSLog(@"menuBtnClicked");
}

-(NSString *)searchCategory{
    if (!_searchCategory) {
        _searchCategory = @"用户";
    }
    return _searchCategory;
}

- (NSArray *)menuTitles{
    if (!_menuTitles) {
        _menuTitles = @[@"用户",@"公司",@"项目",@"产品"];
    }
    return _menuTitles;
}

- (void)searchMenuViewClickedWithTitle:(NSString *)title index:(NSInteger)index{
    UIView* leftView=[self.searchBar valueForKeyPath:@"_searchField.leftView"];
    [leftView.subviews[0] setText:title];
    NSLog(@"搜索条件变更");
    

    [self reloadSearchModelWithCategory:title type:index];
    [self searchNewDataWithRecord:self.searchBar.text];
}

- (void)reloadSearchModelWithCategory:(NSString*)category type:(NSInteger)type{
    //搜索条件变更
    self.searchCategory = category;
    //搜索历史记录模型变更
    self.models = [MarketSearchSqlite loadList:type];
    //搜索历史记录表更新
    [self.searchBarTableView reloadData];
}

- (void)searchNewDataWithRecord:(NSString*)record{
    UITableView* oldTableView = [self.vc tableView];
    [oldTableView removeFromSuperview];
    self.vc = nil;
    
    if (record.length == 0) return;
    
    NSInteger index = [self.menuTitles indexOfObject:self.searchCategory];
    [MarketSearchSqlite insertRecord:record type:index];
    
    [self.searchBar resignFirstResponder];
    UITableView* tableView;
    switch (index) {
        case 0:{
            RecommendFriendSearchController* vc = [[RecommendFriendSearchController alloc] initWithTableViewBounds:self.view.bounds];
            [vc view];
            tableView = vc.tableView;
            vc.nowViewController = self;
            [vc loadListWithKeyWords:record];
            self.vc = vc;
            break;
        }
        case 1:{
            MoreCompanyViewController* vc = [[MoreCompanyViewController alloc] init];
            vc.keywords = record;
            [vc view];
            tableView = vc.tableView;
            vc.nowViewController = self;
            self.vc = vc;
            break;
        }
        case 2:{
            ALLProjectViewController* vc = [[ALLProjectViewController alloc] init];
            vc.keywords = record;
            [vc view];
            tableView = vc.tableView;
            vc.nowViewController = self;
            self.vc = vc;
            break;
            
        }
        case 3:{
            MarketSearchProductController* vc = [[MarketSearchProductController alloc] init];
            vc.keyWords = record;
            vc.superViewController = self;
            [vc view];
            tableView = vc.tableView;
            vc.nowViewController = self;
            self.vc = vc;
            break;
        }
    }
    CGRect frame = tableView.frame;
    frame.origin.y = CGRectGetMaxY(self.searchBar.frame);
    frame.size.height = kScreenHeight-CGRectGetMaxY(self.searchBar.frame);
    tableView.frame = frame;
    [self.view addSubview:tableView];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchNewDataWithRecord:searchBar.text];
}

-(void)searchBarTableViewWillBeginDragging:(UITableView *)tableView{
    [self.view endEditing:YES];
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView* seperatorLine = [RKShadowView seperatorLine];
    CGRect frame = seperatorLine.frame;
    frame.origin.y = 45;
    seperatorLine.frame = frame;
    [cell.contentView addSubview:seperatorLine];
    
    NSString* record = self.models[indexPath.row];
    cell.textLabel.text = record;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* record = self.models[indexPath.row];
    self.searchBar.text = record;
    [self searchNewDataWithRecord:record];
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
        NSInteger index = [self.menuTitles indexOfObject:self.searchCategory];
        _models = [MarketSearchSqlite loadList:index];
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
    self.navigationController.navigationBarHidden = YES;
}

- (UIView *)searchBarTableViewNoDataView{
    return [RKViewFactory noHistorySearchResultsViewWithTop:70];
}
@end
