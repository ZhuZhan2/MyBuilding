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
#import "LoginModel.h"


@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

@synthesize personalArray,model,proModel;
static int count =0; //用来记录用户第几次进入该页面
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
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 80, 19.5)];
    [rightButton setTitle:@"账号设置" forState:UIControlStateNormal];
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
    [_pathCover setHeadImageUrl:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg"];
       
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -20, 70, 70)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(145, 50, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    _pathCover.userNameLabel.center = CGPointMake(155, 60);
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
    
    __weak PersonalCenterViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    model = [[ContactModel alloc] init];
    model.companyName = @"上海中技桩业有限公司";
    proModel.projectLeader = @"项目负责人";
    model.addFriendArr = @[@"张三",@"李四"];
    model.userMood = @"今天真是一个好天气哦";
    model.updatePicture =[UIImage imageNamed:@"首页_16"];//proModel.a_projectName

        proModel = [[projectModel alloc] init];
    proModel.a_projectName = @"鸟巢";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{//账户按钮触发的事件
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountVC animated:YES];
}

//-(void)pushToNextVC
//{
//    AccountViewController *accountVC = [[AccountViewController alloc] init];
//    [LoginModel GetUserImagesWithBlock:^(NSMutableArray *posts, NSError *error) {
//        
//        NSLog(@"***** %@",posts);
//        NSDictionary *dic = [posts objectAtIndex:0];
//        NSString  *statusCode = [[[dic objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
//        if([[NSString stringWithFormat:@"%@",statusCode]isEqualToString:@"1300"]){
//            NSDictionary *dataDic = [[dic objectForKey:@"d"] objectForKey:@"data"];
//            
//            NSString *imageLocation = [dataDic objectForKey:@"imageLocation"];
//            NSLog(@"imageLocation %@",imageLocation);
//            NSString *host = [NSString stringWithFormat:@"%s",serverAddress];
//            NSString *urlString = [host stringByAppendingString:imageLocation];
//            NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//            NSLog(@"[NSURL URLWithString:urlString] %@",[NSURL URLWithString:urlString]);
//            accountVC.userIcon = [UIImage imageWithData:imageData];
//            
//            
//        }else{
//            
//            accountVC.userIcon = [UIImage imageNamed:@"1"];
//        }
//        
//        [[SDImageCache sharedImageCache] storeImage:accountVC.userIcon forKey:@"userIcon"];
//        [self.navigationController pushViewController:accountVC animated:YES];
//    } userId:@"d2b49305-026c-4ff6-b2fc-5d1401510fd8"];
//}


//设置时间
- (void)setupDatasource
{
    _datasource = [NSMutableArray new];
    
    
    for(int i=0;i<30;i++){
        [_datasource addObject:[NSDate date]];
    }
}

- (void)_refreshing {
    // refresh your data sources
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
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"commonCell";
        CommonCell *commonCell = (CommonCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!commonCell) {
            commonCell = [[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier WithModel:proModel WithIndex:indexPath.row WithContactModel:model];
        }
   
    return commonCell;
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
