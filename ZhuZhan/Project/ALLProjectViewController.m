//
//  ALLProjectViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/28.
//
//

#import "ALLProjectViewController.h"
#import "ProjectTableViewCell.h"
#import "PorjectCommentTableViewController.h"
#import "ProjectApi.h"
#import "LoadingView.h"
#import "MyTableView.h"
#import "MJRefresh.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "ProgramDetailViewController.h"
#import "ProjectSqlite.h"
#import "ProjectTableViewController.h"
#import "RKStageChooseView.h"
#import "LocalProjectModel.h"
@interface ALLProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectTableViewCellDelegate,LoginViewDelegate,RKStageChooseViewDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)RKStageChooseView *stageChooseView;
@property(nonatomic)NSInteger flag;
@end

@implementation ALLProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 60, 36.5)];
    //[rightButton setBackgroundImage:[GetImagePath getImagePath:@"项目-首页_03a"] forState:UIControlStateNormal];
    [rightButton setTitle:@"项目专题" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 155, 30)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 0, 155, 30)];
    [searchBtn setBackgroundImage:[GetImagePath getImagePath:@"项目-首页_08a"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(serachClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchBtn];
    
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 15, 15)];
    [searchImage setImage:[GetImagePath getImagePath:@"搜索结果_09a"]];
    [bgView addSubview:searchImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 120, 30)];
    label.textColor = [UIColor whiteColor];
    label.text = @"寻找项目，发现机会";
    label.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label];
    self.navigationItem.titleView = bgView;
    
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.stageChooseView];
    
    self.startIndex = 0;
    self.flag = 0;
    //[self loadList];
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClick{
    TopicsTableViewController *topicsview = [[TopicsTableViewController alloc] init];
    [self.navigationController pushViewController:topicsview animated:YES];
}

-(void)serachClick{
    SearchViewController *searchView = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)loadList{
    self.startIndex = 0;
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.showArr removeAllObjects];
            self.showArr = posts[0];
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
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
    } startIndex:0 keywords:self.keywords noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(void)loadLocalAndRecommended{
    self.startIndex = 0;
    NSMutableArray* localDatas=[ProjectSqlite loadList];
    if (!localDatas.count) {
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
        self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view];
        [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
            if(!error){
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
                        self.tableView.scrollEnabled = YES;
                        [self loadLocalAndRecommended];
                    }];
                }
            }
            [LoadingView removeLoadingView:self.loadingView];
            self.loadingView = nil;
        } startIndex:self.startIndex noNetWork:^{
            [LoadingView removeLoadingView:self.loadingView];
            self.loadingView = nil;
            [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                [self loadLocalAndRecommended];
            }];
        }];
    }else{
        [self.tableView removeFooter];
        self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view];
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
                        [self loadLocalAndRecommended];
                    }];
                }
            }
            [LoadingView removeLoadingView:self.loadingView];
            self.loadingView = nil;
        } projectIds:projectIds noNetWork:^{
            [LoadingView removeLoadingView:self.loadingView];
            self.loadingView = nil;
            [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                [self loadLocalAndRecommended];
            }];
        }];
    }
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
    if(self.flag == 0){
        [self reloadList];
    }else{
        [self reloadLocalAndRecommended];
    }
}

- (void)footerRereshing
{
    if(self.flag == 0){
        [self addListData];
    }else{
        [self addRecommendedData];
    }
}

-(void)reloadList{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex = 0;
            [self.showArr removeAllObjects];
            self.showArr = posts[0];
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
    }startIndex:0 keywords:self.keywords noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(void)reloadLocalAndRecommended{
    NSMutableArray* localDatas=[ProjectSqlite loadList];
    if (!localDatas.count) {
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
        [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts, int count,NSError *error) {
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
                        [self loadLocalAndRecommended];
                    }];
                }
            }
            [self.tableView headerEndRefreshing];
        }startIndex:0 noNetWork:^{
            [self.tableView headerEndRefreshing];
            [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                [self loadLocalAndRecommended];
            }];
        }];
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
                            [self loadLocalAndRecommended];
                        }];
                    }
                }
                [self.tableView headerEndRefreshing];
            } projectIds:projectIds noNetWork:^{
                [self.tableView headerEndRefreshing];
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self loadLocalAndRecommended];
                }];
            }];
        }
    }
}

-(void)addListData{
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.showArr addObjectsFromArray:posts[0]];
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
    }startIndex:self.startIndex+1 keywords:self.keywords noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(void)addRecommendedData{
    [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
        if(!error){
            self.startIndex++;
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
                    [self loadLocalAndRecommended];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    }startIndex:self.startIndex+1 noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
            [self loadLocalAndRecommended];
        }];
    }];
}

-(RKStageChooseView *)stageChooseView{
    if(!_stageChooseView){
        _stageChooseView = [RKStageChooseView stageChooseViewWithStages:@[@"全部项目",@"历史记录"] numbers:nil delegate:self];
        CGRect frame=_stageChooseView.frame;
        frame.origin=CGPointMake(0, 64);
        _stageChooseView.frame=frame;
    }
    return _stageChooseView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, kScreenHeight-99)];
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
    cell.model = model;
    cell.delegate = self;
    cell.selectionStyle = NO;
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
    [self.nowViewController.navigationController pushViewController:vc animated:YES];
}


- (NSString *)keywords{
    if (!_keywords) {
        _keywords = @"";
    }
    return _keywords;
}

- (UIViewController *)nowViewController{
    if (!_nowViewController) {
        _nowViewController = self;
    }
    return _nowViewController;
}

-(void)projectBtnClicked{
    ProjectTableViewController *view = [[ProjectTableViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)gotoLoginView{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.needDelayCancel=YES;
    loginVC.delegate = self;
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.nowViewController.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    self.startIndex = 0;
    [self.showArr removeAllObjects];
    [self loadList];
    if (block) {
        block();
    }
}

-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    self.flag = stageNumber;
    switch (stageNumber) {
        case 0:
            [self loadList];
            break;
        case 1:
            [self loadLocalAndRecommended];
            break;
        default:
            break;
    }
}
@end
