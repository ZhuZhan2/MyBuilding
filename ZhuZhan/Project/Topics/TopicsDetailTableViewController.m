//
//  TopicsDetailTableViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "TopicsDetailTableViewController.h"
#import "TopicsDetailTableViewCell.h"
#import "ProjectTableViewCell.h"
#import "ProjectApi.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProgramDetailViewController.h"
#import "MJRefresh.h"
@interface TopicsDetailTableViewController ()

@end

@implementation TopicsDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.title = @"专题详情";
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    self.tableView.separatorStyle = NO;
    startIndex = 0;
    //集成刷新控件
    [self setupRefresh];
    [self firstNetWork];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    //2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [showArr removeAllObjects];
    startIndex = 0;
    [ProjectApi GetSeminarProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }else{
            [LoginAgain AddLoginView];
        }
    } Id:self.model.a_id startIndex:startIndex noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

- (void)footerRereshing
{
    startIndex ++;
    [ProjectApi GetSeminarProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [showArr addObjectsFromArray:posts];
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }else{
            [LoginAgain AddLoginView];
        }
    } Id:self.model.a_id startIndex:startIndex noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)firstNetWork{
    [ProjectApi GetSeminarProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            [self.tableView reloadData];
        }else{
            [LoginAgain AddLoginView];
        }
    } Id:self.model.a_id startIndex:startIndex noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
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
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        CGRect bounds=[self.model.a_content boundingRectWithSize:CGSizeMake(288, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        
        CGRect bounds2=[self.model.a_title boundingRectWithSize:CGSizeMake(288, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil];
        return 278+bounds.size.height+5-10+bounds2.size.height;//5像素为原始版本遗留下来的高度
    }else if(indexPath.row == 1){
        return 45;
    }
    return 290;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"TopicsDetailTableViewCell"];
        TopicsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[TopicsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:self.model];
        }
        cell.selectionStyle = NO;
        
        return cell;
    }else if(indexPath.row == 1){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.contentView setBackgroundColor:RGBCOLOR(247, 247, 247)];
        cell.selectionStyle = NO;
        UILabel *projectCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 320, 20)];
        projectCount.text = self.model.a_projectCount;
        projectCount.textColor = BlueColor;
        projectCount.font = [UIFont systemFontOfSize:17];
        projectCount.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:projectCount];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
        label.text = @"关联项目";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
        ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        projectModel *model = showArr[indexPath.row-2];
        if(!cell){
            cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model fromView:@"topics"];
        }
        cell.indexRow=indexPath.row;
        cell.delegate = self;
        cell.model = model;
        cell.selectionStyle = NO;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0||indexPath.row==1) {
        return;
    }
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    projectModel *model = showArr[indexPath.row-2];
    vc.projectId=model.a_id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addProjectCommentView:(int)index{
    projectModel *model = showArr[index-2];
    PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
    projectCommentView.projectId = model.a_id;
    projectCommentView.projectName = model.a_projectName;
    [self.navigationController pushViewController:projectCommentView animated:YES];
}
@end
