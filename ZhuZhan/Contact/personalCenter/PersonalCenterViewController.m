//
//  PersonalCenterViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "AccountViewController.h"
#import "LoginModel.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "CommentApi.h"
#import "ActivesModel.h"
#import "MJRefresh.h"
@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
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
    // Do any additional setup after loading the view.
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 70, 19.5)];
    [rightButton setTitle:@"账号设置" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"个人中心";

    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 154)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[GetImagePath getImagePath:@"首页_16"]];
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%s%@",serverAddress,[LoginSqlite getdata:@"userImageUrl" defaultdata:@"userImageUrl"]]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(125, -20, 70, 70)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(145, 50, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    _pathCover.userNameLabel.center = CGPointMake(157.5, 60);
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
    
    __weak PersonalCenterViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    //集成刷新控件
    [self setupRefresh];
    
    startIndex=0;
    showArr = [[NSMutableArray alloc] init];
    _datasource = [[NSMutableArray alloc] init];
    [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            for(int i=0;i<showArr.count;i++){
                ActivesModel *model = showArr[i];
                NSLog(@"%@",model.a_content);
                [_datasource addObject:model.a_time];
                [self.tableView reloadData];
            }
        }
    } userId:@"13756154-7db5-4516-bcc6-6b7842504c81" startIndex:startIndex];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)footerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        
    }else{
        startIndex ++;
        [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [showArr addObjectsFromArray:posts];
                for(int i=0;i<posts.count;i++){
                    PersonalCenterModel *model = posts[i];
                    [_datasource addObject:model.a_time];
                    
                    if (![model.a_category isEqualToString:@"Project"]) {
                        UIView* view=[PersonalCenterCellView getPersonalCenterCellViewWithImageUrl:model.a_imageUrl content:model.a_content category:model.a_category];
                        [contentViews addObject:view];
                    }else{
                        [contentViews addObject:@""];
                    }
                }
                [self.tableView footerEndRefreshing];
                _timeScroller.hidden=YES;
                [self.tableView reloadData];
                _timeScroller.hidden=NO;
            }
        } userId:@"13756154-7db5-4516-bcc6-6b7842504c81" startIndex:startIndex];

    }
}

/******************************************************************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
    [_timeScroller scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
    [_timeScroller scrollViewWillBeginDragging];
}


-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{//账户按钮触发的事件
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountVC animated:YES];
}

- (void)_refreshing {
    // refresh your data sources
    
    NSLog(@"asdfasdfasdfasf");
    __weak PersonalCenterViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

/******************************************************************************************************************/
////滚动是触发的事件
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [_pathCover scrollViewDidScroll:scrollView];
//    [_timeScroller scrollViewDidScroll];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [_pathCover scrollViewDidEndDecelerating:scrollView];
//    [_timeScroller scrollViewDidEndDecelerating];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [_pathCover scrollViewWillBeginDragging:scrollView];
//    [_timeScroller scrollViewWillBeginDragging];
//}
/******************************************************************************************************************/



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return showArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellIdentifier = [NSString stringWithFormat:@"ContactProjectTableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if([model.a_category isEqualToString:@"Project"]){
        PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
        projectCommentView.projectId = model.a_entityId;
        projectCommentView.projectName = model.a_entityName;
        [self.navigationController pushViewController:projectCommentView animated:YES];
    }else{
        NSLog(@"%@",model.a_entityUrl);
        NSLog(@"%@",model.a_entityId);
        [CommentApi CommentUrlWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                
            }
        } url:model.a_entityUrl];
        
        ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithActivesModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 60;
    }
    if (indexPath.row ==1 ||indexPath.row==2 ||indexPath.row==3) {
        return 50;
    }
    
    if (indexPath.row==4) {
        return 80;
    }
    return 200;
}

//时间标签
- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return [self tableView];
}
//传入时间标签的date
- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    return _datasource[[indexPath row]];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotoMyCenter{

}

@end
