//
//  ContactViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "ContactViewController.h"
#import "CompanyMemberViewController.h"
#import "Cell1.h"
#import "CompanyPublishedCell.h"
#import "CommentsCell.h"
#import "PersonalCenterViewController.h"
#import "PersonalDetailViewController.h"
#import "LoginModel.h"
#import "PublishViewController.h"

NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize comments,personalArray,pan,transparent;

static int rowNum =0;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setupDatasource];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"人脉";
    
    //上拉刷新界面
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setAvatarImage:[UIImage imageNamed:@"首页侧拉栏_03.png"]];
    [_pathCover setHeadTaget];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"用户名", XHUserNameKey, @"公司名字显示在这里     职位", XHBirthdayKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
    
    self.tableView.separatorStyle = NO;
    
    __weak ContactViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
}

-(void)publish
{
    NSLog(@"发布产品");

    PublishViewController *publishVC = [[PublishViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
//    if([hideDelegate respondsToSelector:@selector(homePageTabBarRestore)]){
//        [hideDelegate homePageTabBarRestore];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//设置时间
- (void)setupDatasource
{
    _datasource = [NSMutableArray new];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    for (NSInteger i = [todayComponents day]; i >= -15; i--)
    {
        [components setYear:[todayComponents year]];
        [components setMonth:[todayComponents month]];
        [components setDay:i];
        [components setHour:arc4random() % 23];
        [components setMinute:arc4random() % 59];
        
        NSDate *date = [calendar dateFromComponents:components];
        [_datasource addObject:date];
    }
    
    /*for(int i=0;i<30;i++){
        [_datasource addObject:[NSDate date]];
    }*/
}

- (void)_refreshing {
    // refresh your data sources
    NSLog(@"asdfasdfasdf");
    __weak ContactViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
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
/******************************************************************************************************************/

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PSTableViewCellIdentifier];
//    
//    NSDate *date = _datasource[[indexPath row]];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@",localeDate]];
//    
//    return cell;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [_datasource count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    rowNum =(int)[comments count]+3;
    
    return rowNum;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%rowNum==0 ||indexPath.row%rowNum==1) {
        
        
        static  NSString *identifier2 = @"Cell1";
        Cell1 * cell2 = (Cell1 *)[tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell2) {
            cell2 = [[Cell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        
        cell2.cellIcon.image = [UIImage imageNamed:@"面部采集_12"];
        [cell2.userIcon setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [cell2.userIcon addTarget:self action:@selector(ShowUserPanView:) forControlEvents:UIControlEventTouchUpInside];
        cell2.userIcon.tag = indexPath.row;
        cell2.contentLabel.text = [personalArray objectAtIndex:indexPath.row];
        return cell2;
        
        
        
    }
    if (indexPath.row%rowNum==2){
        static  NSString *identifier3 = @"CompanyPublishedCell";
        CompanyPublishedCell * cell3 = (CompanyPublishedCell *)[tableView dequeueReusableCellWithIdentifier:identifier3];
        if (!cell3) {
            cell3 = [[CompanyPublishedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
        }
        cell3.bigImgView.image = [UIImage imageNamed:@"123"];
        NSString *tempStr = @"           ";
        cell3.publishView.text =[tempStr stringByAppendingString:@"实现水平方向滑动的UIPicker。自定义UIPicker。如果你厌倦了iOS自带的UIPicker，那么你可以试试这个不一样的UIPicker。不仅仅可以用作选择器，也可以用作菜单"];
        cell3.userNameLabel.text = @"Jack:";
        cell3.userNameLabel.textColor = [UIColor blueColor];
        return cell3;
    }
    
    static  NSString *identifier4 = @"CommentsCell";
    CommentsCell * cell4 = (CommentsCell *)[tableView dequeueReusableCellWithIdentifier:identifier4];
    if (!cell4) {
        
        cell4 = [[CommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier4];
    }
    [cell4.userIcon setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [cell4.userIcon addTarget:self action:@selector(ShowUserPanView:) forControlEvents:UIControlEventTouchUpInside];
    cell4.userIcon.tag = indexPath.row;
    NSString *tempStr = @"           ";
    cell4.commentsView.text =[tempStr stringByAppendingString:@"实现水平方向滑动的UIPicker。"];
    cell4.userNameLabel.text = @"Lisa:";
    cell4.commentsView.textColor = [UIColor blueColor];
    return cell4;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%rowNum==0 ||indexPath.row%rowNum==1) {
        return 50;
    }
    if(indexPath.row%rowNum == 2){
        return 280;
    }
    return 50;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CompanyMemberViewController* memberVC=[[CompanyMemberViewController alloc]initWithMemberNumber:14];
//    [self.navigationController pushViewController:memberVC animated:YES];
//    if([hideDelegate respondsToSelector:@selector(homePageTabBarHide)]){
//        [hideDelegate homePageTabBarHide];
//    }
//}

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

//点击自己头像去个人中心
-(void)gotoMyCenter{
    NSLog(@"gotoMyCenter");
    PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personalVC animated:YES];
}

-(void)ShowUserPanView:(UIButton *)button{
    transparent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    transparent.backgroundColor = [UIColor blackColor];
    transparent.alpha = 0.4;
    [self.tableView.superview addSubview:transparent];
    
    pan = [[Pan alloc] initWithFrame:CGRectMake(30, 150, 260, 300)];
    pan.backgroundColor = [UIColor whiteColor];
    pan.userInteractionEnabled = YES;
    pan.delegate = self;
    pan.layer.cornerRadius = 0;
    [self.tableView.superview addSubview:pan];
}

- (void)goToDetail
{
    
    transparent = nil;
    pan = nil;
    PersonalDetailViewController *personalVC = [[PersonalDetailViewController alloc] init];
    [self.navigationController pushViewController:personalVC animated:NO];
}

- (void)gotoConcern
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
       NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:userId,@"userId",@"bfc78202-8ac9-447a-a99d-783606d25668",@"focusId", nil];
    [LoginModel PostInformationImprovedWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSDictionary *responseObject = [posts objectAtIndex:0];
        NSString *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加关注成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1308"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经添加关注" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        
    } dic:parameter];
}

@end
