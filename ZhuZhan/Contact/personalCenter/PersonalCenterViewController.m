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
#import "SDImageCache.h"

@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

@synthesize personalArray;
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
    [_pathCover setHeadImageUrl:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg"];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadFrame:CGRectMake(120, -20, 70, 70)];
    [_pathCover.avatarButton.layer setMasksToBounds:YES];
    [_pathCover.avatarButton.layer setCornerRadius:35];
    
    [_pathCover setNameFrame:CGRectMake(145, 50, 100, 20) font:[UIFont systemFontOfSize:14]];
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

-(void)rightBtnClick{//账户按钮触发的事件
    count++;
    if (count==1) {
        [self pushToNextVC];
    }
    else{
        AccountViewController *accountVC = [[AccountViewController alloc] init];
        accountVC.userIcon =[[SDImageCache sharedImageCache] imageFromKey:@"userIcon"];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    
}

-(void)pushToNextVC
{
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [LoginModel GetUserImagesWithBlock:^(NSMutableArray *posts, NSError *error) {
        
        NSLog(@"***** %@",posts);
        NSDictionary *dic = [posts objectAtIndex:0];
        NSString  *statusCode = [[[dic objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode]isEqualToString:@"1300"]){
            NSDictionary *dataDic = [[dic objectForKey:@"d"] objectForKey:@"data"];
            
            NSString *imageLocation = [dataDic objectForKey:@"imageLocation"];
            NSLog(@"imageLocation %@",imageLocation);
            NSString *host = [NSString stringWithFormat:@"%s",serverAddress];
            NSString *urlString = [host stringByAppendingString:imageLocation];
            NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            NSLog(@"[NSURL URLWithString:urlString] %@",[NSURL URLWithString:urlString]);
            accountVC.userIcon = [UIImage imageWithData:imageData];
            
            
        }else{
            
            accountVC.userIcon = [UIImage imageNamed:@"1"];
        }
        
        [[SDImageCache sharedImageCache] storeImage:accountVC.userIcon forKey:@"userIcon"];
        [self.navigationController pushViewController:accountVC animated:YES];
    } userId:@"d2b49305-026c-4ff6-b2fc-5d1401510fd8"];
}


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
    return [_datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier2 = @"commonCell";
        CommonCell *cell2 = (CommonCell*)[tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell2) {
            cell2 = [[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier2];
        }
   
    cell2.userIcon.image = [UIImage imageNamed:@"面部采集_12"];
    cell2.contentLabel.text = [NSString stringWithFormat:@"%@",[_datasource objectAtIndex:indexPath.row]];
    
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
