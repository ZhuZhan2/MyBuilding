//
//  MyProjectViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/17.
//
//

#import "MyProjectViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProjectTableViewCell.h"
#import "ProgramDetailViewController.h"
#import "MJRefresh.h"
#import "ProjectApi.h"
#import "projectModel.h"
#import "LoginSqlite.h"
@interface MyProjectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic)int startIndex;
@end

@implementation MyProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startIndex = 0;
    [self initNav];
    [self.view addSubview:self.tableView];
    [self loadList];
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)initNav{
    self.title = @"我的项目";
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = AllBackLightGratColor;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(NSMutableArray *)showArr{
    if(!_showArr){
        _showArr = [NSMutableArray array];
    }
    return _showArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    projectModel *model = self.showArr[indexPath.row];
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = NO;
    cell.isHiddenFocusBtn = YES;
    cell.isHiddenApproveImageView = NO;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    CGSize cellSize = [ProjectTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<CellHeightDelegate> cellToSetup) {
        projectModel *model = self.showArr[indexPath.row];
        [((ProjectTableViewCell *)cellToSetup) setModel:model];
        return cellToSetup;
    }];
    return cellSize.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    projectModel *model = self.showArr[indexPath.row];
    vc.projectId = model.a_id;
    vc.isFocused = model.isFocused;
    [self.navigationController pushViewController:vc animated:YES];
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

-(void)loadList{
    self.startIndex = 0;
    [ProjectApi GetMyProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.showArr removeAllObjects];
            self.showArr = posts;
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } userId:[LoginSqlite getdata:@"userId"] startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self loadList];
}

- (void)footerRereshing
{
    [ProjectApi GetMyProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.showArr addObjectsFromArray:posts];
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } userId:[LoginSqlite getdata:@"userId"] startIndex:self.startIndex+1 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}
@end
