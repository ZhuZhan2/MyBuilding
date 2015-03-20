//
//  SearchContactViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import "SearchContactViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "EndEditingGesture.h"
#import "SearchContactTableViewCell.h"
@interface SearchContactViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@end

@implementation SearchContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=@"参与用户";
    
    self.showArr = [[NSMutableArray alloc] initWithObjects:@"参与用户一",@"参与用户二",@"参与用户三",@"参与用户四",@"参与用户五", nil];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 43)];
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];;
        _searchBar.delegate=self;
    }
    return _searchBar;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 107, 320, kScreenHeight-107)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    if (!self.view.gestureRecognizers.count) {
        [EndEditingGesture addGestureToView:self.view];
    }
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    if (self.view.gestureRecognizers.count) {
        [self.view removeGestureRecognizer:self.view.gestureRecognizers[0]];
    }
    return YES;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"SearchContactTableViewCell"];
    SearchContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[SearchContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.companyNameStr = self.showArr[indexPath.row];
    cell.selectionStyle = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(selectContact:)]){
        [self.delegate selectContact:self.showArr[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
