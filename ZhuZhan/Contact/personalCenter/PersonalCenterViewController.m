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
#import "PersonalCenterModel.h"
#import "PersonalCenterCellView.h"
#import "ConnectionAvailable.h"
#import "PersonalProjectTableViewCell.h"
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
    
    showArr = [[NSMutableArray alloc] init];
    contentViews=[[NSMutableArray alloc]init];
    _datasource = [[NSMutableArray alloc] init];
    
    [self downLoad:nil];
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
}

-(void)downLoad:(void(^)())block{
    startIndex=0;
    [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            for(int i=0;i<showArr.count;i++){
                PersonalCenterModel *model = showArr[i];
                [_datasource addObject:model.a_time];
                
                if (![model.a_category isEqualToString:@"Project"]) {
                    UIView* view=[PersonalCenterCellView getPersonalCenterCellViewWithImageUrl:model.a_imageUrl content:model.a_content category:model.a_category];
                    [contentViews addObject:view];
                }else{
                    [contentViews addObject:@""];
                }
            }
            _timeScroller.hidden=YES;
            [self.tableView reloadData];
            _timeScroller.hidden=NO;
            if (block) {
                block();
            }
        }
    } userId:@"13756154-7db5-4516-bcc6-6b7842504c81" startIndex:startIndex];
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
                _timeScroller.hidden=YES;
                [self.tableView footerEndRefreshing];
                [self.tableView reloadData];
                _timeScroller.hidden=NO;
            }
        } userId:@"13756154-7db5-4516-bcc6-6b7842504c81" startIndex:startIndex];

    }
}

//****************************************************************
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
    [self downLoad:^{
        __weak PersonalCenterViewController *wself = self;
        [wself.pathCover stopRefresh];
    }];
}

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
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if([model.a_category isEqualToString:@"Project"]){
        NSString *CellIdentifier = [NSString stringWithFormat:@"PersonalProjectTableViewCell"];
        PersonalProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[PersonalProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.model = model;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"ContactProjectTableViewCell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:contentViews[indexPath.row]];
        cell.selectionStyle = NO;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        return cell;
    }
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
        ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithPersonalCenterModel:model];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if([model.a_category isEqualToString:@"Project"]){
        return 50;
    }else{
        return [contentViews[indexPath.row] frame].size.height;
    }
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
