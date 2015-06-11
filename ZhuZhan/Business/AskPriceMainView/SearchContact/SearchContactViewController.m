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
#import "AskPriceApi.h"
#import "SearchContactDefaultView.h"
#import "MyTableView.h"

@interface SearchContactViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,SearchContactDefaultViewDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)NSString *keyWorks;
@property(nonatomic,strong)SearchContactDefaultView *searchContactDefaultView;
@property(nonatomic)BOOL isShowDefaultView;
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
    
    self.showArr = [[NSMutableArray alloc] init];
    self.keyWorks = @"";
    self.isShowDefaultView = YES;
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchContactDefaultView];
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

-(void)loadList{
    [AskPriceApi GetUserOrCompanyListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView noSearchData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
    } keyWorks:self.keyWorks noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 43)];
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];;
        _searchBar.delegate=self;
        _searchBar.returnKeyType = UIReturnKeySearch;
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

-(SearchContactDefaultView *)searchContactDefaultView{
    if(!_searchContactDefaultView){
        _searchContactDefaultView = [[SearchContactDefaultView alloc] initWithFrame:CGRectMake(0, 107, 320, kScreenHeight-107)];
        _searchContactDefaultView.delegate = self;
    }
    return _searchContactDefaultView;
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.isShowDefaultView = NO;
    [self showOrCloseDefaultView];
    self.keyWorks = searchBar.text;
    [self loadList];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.isShowDefaultView = YES;
    [self showOrCloseDefaultView];
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self.showArr removeAllObjects];
    [self.tableView reloadData];
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
    return self.showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"SearchContactTableViewCell"];
    SearchContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[SearchContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UserOrCompanyModel *model = self.showArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(selectContact:)]){
        [self.delegate selectContact:self.showArr[indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)selectContact:(UserOrCompanyModel *)model{
    if([self.delegate respondsToSelector:@selector(selectContact:)]){
        [self.delegate selectContact:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)showOrCloseDefaultView{
    if(self.isShowDefaultView){
        [self.view addSubview:self.searchContactDefaultView];
    }else{
        [self.searchContactDefaultView removeFromSuperview];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}
@end
