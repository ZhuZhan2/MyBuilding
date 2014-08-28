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

@synthesize personalArray;
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
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 19.5)];
    [rightButton setTitle:@"帐户" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"个人中心";

    NSArray *array = @[@"上海中技桩业公司",@"XXX更新了项目名称",@"XXX与XXX成为了好友",@"XXX更新了的头像"];
    
    personalArray = [NSMutableArray arrayWithArray:array];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setAvatarImage:[UIImage imageNamed:@"首页侧拉栏_03.png"]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadFrame:CGRectMake(120, 0, 70, 70)];
    [_pathCover setNameFrame:CGRectMake(145, 70, 100, 20) font:[UIFont systemFontOfSize:14]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
    
    __weak PersonalCenterViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];

}


-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountVC animated:YES];
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

////点击自己头像去个人中心
//-(void)gotoMyCenter{
//    NSLog(@"gotoMyCenter");
//    PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] init];
//    [self.navigationController pushViewController:personalVC animated:YES];
//}


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
