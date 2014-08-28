//
//  PersonalCenterViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "CommonCell.h"
#import "AccountViewController.h"
@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

@synthesize personaltableView,personalArray;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
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

//    [self.navigationController.navigationBar removeFromSuperview];
    self.navigationController.navigationBar.alpha =0;
    UINavigationBar *tabBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64.5)];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:tabBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.center =CGPointMake(160, 40);
    titleLabel.text = @"个人中心";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [tabBar addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFormerVC) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:backBtn];
    
    UIButton *accountBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [accountBtn setTitle:@"帐户" forState:UIControlStateNormal];
    accountBtn.titleLabel.textColor = [UIColor whiteColor];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    accountBtn.frame = CGRectMake(250, 20, 60, 40);
    [accountBtn addTarget:self action:@selector(account) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:accountBtn];
    
    NSArray *array = @[@"项目名称显示在这里",@"用户名添加联系人赵钱孙李 职位",@"我发布的动态",@"我发布的动态"];
    personalArray = [NSMutableArray arrayWithArray:array];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setAvatarImage:[UIImage imageNamed:@"首页侧拉栏_03.png"]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"用户名", XHUserNameKey, @"公司名字显示在这里     职位", XHBirthdayKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
    
    __weak PersonalCenterViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];

}

-(void)backToFormerVC
{
    self.navigationController.navigationBar.alpha =1;
    [self.navigationController popViewControllerAnimated:NO];
}



-(void)account{//账户
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountVC animated:NO];
    
}


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
    __weak PersonalCenterViewController *wself = self;
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



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personalArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier2 = @"commonCell";
        CommonCell *cell2 = (CommonCell*)[tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell2) {
            cell2 = [[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier2];
        }
   
    cell2.userIcon.image = [UIImage imageNamed:@"面部采集_12"];
    cell2.contentLabel.text = [personalArray objectAtIndex:indexPath.row];
    
    return cell2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 50;
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

//点击自己头像去个人中心
-(void)gotoMyCenter{
    NSLog(@"gotoMyCenter");
    PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personalVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
