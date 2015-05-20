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
@interface ALLProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectTableViewCellDelegate,LoginViewDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic)int startIndex;
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
    self.startIndex = 0;
    [self loadList];
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
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
    } startIndex:0 keywords:self.keywords noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    }startIndex:0 keywords:self.keywords noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)footerRereshing
{
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    }startIndex:self.startIndex+1 keywords:self.keywords noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-49)];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 50;
    }
    return 5;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 291.5, 50)];
        [bgView setBackgroundColor:AllBackLightGratColor];
        
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 25, 160, 20)];
        tempLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:13];
        tempLabel.textColor = GrayColor;
        tempLabel.text = [NSString stringWithFormat:@"全部项目"];
        
        UIButton* projectBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [projectBtn setTitle:@"查看历史记录" forState:UIControlStateNormal];
        projectBtn.frame=CGRectMake(227, 15, 79, 40);
        [projectBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        projectBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:13];
        [projectBtn addTarget:self action:@selector(projectBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:projectBtn];
        
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(228, 42, 76, 1)];
        view.backgroundColor=BlueColor;
        [bgView addSubview:view];
        [bgView addSubview:tempLabel];
        
        
        return bgView;
    }
    return nil;
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
    [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    self.startIndex = 0;
    [self.showArr removeAllObjects];
    [self loadList];
    if (block) {
        block();
    }
}
@end
