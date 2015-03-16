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
#import "CompanyCenterViewController.h"
#import "MyTableView.h"
#import "PersonalCenterCompanyTableViewCell.h"
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
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 70, 19.5)];
    [rightButton setTitle:@"账号设置" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"个人中心";

    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 154) bannerPlaceholderImageName:@"默认主图"];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImageUrlString:[LoginSqlite getdata:@"backgroundImage"]];
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(125, -30, 70, 70)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(0, 50, 320, 20) font:[UIFont systemFontOfSize:14]];
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, nil]];
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeHeadImage) name:@"changHead" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeUserName) name:@"changName" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeBackgroundImage) name:@"changBackground" object:nil];
    
}

-(void)downLoad:(void(^)())block{
    [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [_datasource removeAllObjects];
            [contentViews removeAllObjects];
            [showArr removeAllObjects];
            startIndex=0;
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
            [MyTableView reloadDataWithTableView:self.tableView];
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
            _timeScroller.hidden=NO;
            if (block) {
                block();
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } userId:[LoginSqlite getdata:@"userId"] startIndex:0 noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self downLoad:block];
        }];
    }];
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
    [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            startIndex ++;
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
            [MyTableView reloadDataWithTableView:self.tableView];
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
            _timeScroller.hidden=NO;
        }else{
            [LoginAgain AddLoginView:NO];
        }
        [self.tableView footerEndRefreshing];
    } userId:[LoginSqlite getdata:@"userId"] startIndex:startIndex+1 noNetWork:^{
        [self.tableView footerEndRefreshing];
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self footerRereshing];
        }];
    }];
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
    if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
        CompanyCenterViewController *companyVC = [[CompanyCenterViewController alloc] init];
        [self.navigationController pushViewController:companyVC animated:YES];
    }else{
        AccountViewController *accountVC = [[AccountViewController alloc] init];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
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
            UIView* separatorLine=[self getSeparatorLine];
            separatorLine.center=CGPointMake(160, 49.5);
            [cell.contentView addSubview:separatorLine];
        }
        cell.model = model;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        return cell;
    }else if([model.a_category isEqualToString:@"CompanyAgree"]){
        NSString *CellIdentifier = [NSString stringWithFormat:@"PersonalCenterCompanyTableViewCell"];
        PersonalCenterCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[PersonalCenterCompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            UIView* separatorLine=[self getSeparatorLine];
            separatorLine.center=CGPointMake(160, 49.5);
            [cell.contentView addSubview:separatorLine];
        }
        cell.imageUrl = model.a_avatarUrl;
        cell.companyName = model.a_userName;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:contentViews[indexPath.row]];
        cell.selectionStyle = NO;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        
        UIView* separatorLine=[self getSeparatorLine];
        separatorLine.center=CGPointMake(160, [contentViews[indexPath.row] frame].size.height-0.5);
        [cell.contentView addSubview:separatorLine];
        return cell;
    }
}

-(UIView*)getSeparatorLine{
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    separatorLine.backgroundColor=[UIColor blackColor];
    separatorLine.alpha=.1f;
    return separatorLine;
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
    }else if([model.a_category isEqualToString:@"Personal"]||[model.a_category isEqualToString:@"Product"]||[model.a_category isEqualToString:@"Company"]){
        ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithPersonalCenterModel:model];
        NSLog(@"===>%@",model.a_category);
        vc.type = model.a_category;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if([model.a_category isEqualToString:@"Project"]||[model.a_category isEqualToString:@"CompanyAgree"]){
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

-(void)changeHeadImage{
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
}

-(void)changeUserName{
    NSLog(@"==>%@",[LoginSqlite getdata:@"userName"]);
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, nil]];
}

-(void)changeBackgroundImage{
    [_pathCover setBackgroundImageUrlString:[LoginSqlite getdata:@"backgroundImage"]];
}
@end
