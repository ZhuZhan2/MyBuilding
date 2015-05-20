//
//  ProjectTableViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectTableViewController.h"
#import "ProjectApi.h"
#import "projectModel.h"
#import "LoginModel.h"
#import "ProjectStage.h"
#import "ProjectTableViewCell.h"
#import "MJRefresh.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "ProgramDetailViewController.h"
#import "ErrorView.h"
#import "ProjectSqlite.h"
#import "LocalProjectModel.h"
#import "MyTableView.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface ProjectTableViewController ()

@end

@implementation ProjectTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.title = @"历史记录";
    startIndex = 0;
    isReload = NO;
    showArr = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    self.tableView.separatorStyle = NO;
    //集成刷新控件
    [self setupRefresh];
    [self firstWork];
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
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)firstWork{
    NSMutableArray* localDatas=[ProjectSqlite loadList];
    if (!localDatas.count) {
        self.tableView.scrollEnabled = NO;
        sectionHeight = 0;
        loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
        [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
            if(!error){
                showArr = posts;
                sectionHeight = 50;
                isReload = NO;
                if(showArr.count == 0){
                    [MyTableView reloadDataWithTableView:self.tableView];
                    [MyTableView hasData:self.tableView];
                }else{
                    [MyTableView removeFootView:self.tableView];
                    [self.tableView reloadData];
                }
                [LoadingView removeLoadingView:loadingView];
                self.tableView.scrollEnabled = YES;
                loadingView = nil;
            }else{
                self.tableView.scrollEnabled = NO;
                [LoadingView removeLoadingView:loadingView];
                loadingView = nil;
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                        self.tableView.scrollEnabled = YES;
                        [self firstWork];
                    }];
                }
            }
        } startIndex:startIndex noNetWork:^{
            self.tableView.scrollEnabled = NO;
            [LoadingView removeLoadingView:loadingView];
            loadingView = nil;
            [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                self.tableView.scrollEnabled = YES;
                [self firstWork];
            }];
        }];
    }else{
        self.tableView.scrollEnabled = NO;
        sectionHeight = 0;
        isReload = YES;
        loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
        [self requestSingleProgram:[ProjectSqlite loadList]];
    }
}

-(void)requestSingleProgram:(NSMutableArray*)datas{
    NSString* projectIds=@"";
    for (int i=0; i<datas.count; i++) {
        projectIds=[[NSString stringWithFormat:i?@"%@,":@"%@",projectIds] stringByAppendingString:[datas[i] a_projectId]];
    }
    if (datas.count) {
        [ProjectApi LocalProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                showArr = posts;
                sectionHeight = 50;
                if(showArr.count == 0){
                    [MyTableView reloadDataWithTableView:self.tableView];
                    [MyTableView hasData:self.tableView];
                }else{
                    [MyTableView removeFootView:self.tableView];
                    [self.tableView reloadData];
                }
                [LoadingView removeLoadingView:loadingView];
                self.tableView.scrollEnabled = YES;
                loadingView = nil;
            }else{
                self.tableView.scrollEnabled = NO;
                [LoadingView removeLoadingView:loadingView];
                loadingView = nil;
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                        self.tableView.scrollEnabled = YES;
                        [self firstWork];
                    }];
                }
            }
        } projectIds:projectIds noNetWork:^{
            self.tableView.scrollEnabled = NO;
            [LoadingView removeLoadingView:loadingView];
            loadingView = nil;
            [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                self.tableView.scrollEnabled = YES;
                [self firstWork];
            }];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    NSMutableArray* localDatas=[ProjectSqlite loadList];
    if(localDatas.count ==0){
        //2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSMutableArray* localDatas=[ProjectSqlite loadList];
    if (!localDatas.count) {
        [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts, int count,NSError *error) {
            if(!error){
                startIndex = 0;
                [showArr removeAllObjects];
                showArr = posts;
                isReload = NO;
                if(showArr.count == 0){
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
        }startIndex:0 noNetWork:^{
            [self.tableView headerEndRefreshing];
            [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                [self headerRereshing];
            }];
        }];
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }else{
        [self.tableView removeFooter];
        NSArray* datas=[ProjectSqlite loadList];
        NSString* projectIds=@"";
        for (int i=0; i<datas.count; i++) {
            projectIds=[[NSString stringWithFormat:i?@"%@,":@"%@",projectIds] stringByAppendingString:[datas[i] a_projectId]];
        }
        if (datas.count) {
            [ProjectApi LocalProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    startIndex = 0;
                    [showArr removeAllObjects];
                    showArr = posts;
                    isReload = YES;
                    if(showArr.count == 0){
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
            } projectIds:projectIds noNetWork:^{
                [self.tableView headerEndRefreshing];
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self headerRereshing];
                }];
            }];
        }
    }
}

- (void)footerRereshing
{
    if(!isReload){
        [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
            if(!error){
                startIndex++;
                [showArr addObjectsFromArray:posts];
                if(showArr.count == 0){
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
        }startIndex:startIndex+1 noNetWork:^{
            [self.tableView footerEndRefreshing];
            [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                [self footerRereshing];
            }];
        }];
    }else{
        NSMutableArray* localDatas=[ProjectSqlite loadList];
        if(localDatas.count ==0){
            [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
                if(!error){
                    startIndex++;
                    [showArr addObjectsFromArray:posts];
                    if(showArr.count == 0){
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
            }startIndex:startIndex+1 noNetWork:^{
                [self.tableView footerEndRefreshing];
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self footerRereshing];
                }];
            }];
        }
    }
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return showArr.count;
}

//push去展示页前将tabbar隐藏
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    projectModel *model = showArr[indexPath.row];
    vc.projectId = model.a_id;
    vc.isFocused = model.isFocused;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    projectModel *model = showArr[indexPath.row];
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.model = model;
    cell.selectionStyle = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 291.5, 50)];
        [bgView setBackgroundColor:RGBCOLOR(239, 237, 237)];
        return bgView;
    }
    return nil;
}


-(void)allProjectBtnClicked{
    //ALLProjectViewController* vc=[[ALLProjectViewController alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
}
@end
