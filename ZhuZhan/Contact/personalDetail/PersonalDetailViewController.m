//
//  PersonalDetailViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PersonalDetailViewController.h"
#import "PImgCell.h"
@interface PersonalDetailViewController ()

@end

@implementation PersonalDetailViewController

@synthesize KindIndex,kImgArr;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"帐户";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    

    
    KindIndex = @[@"联系方式",@"个人背景",@"关联项目"];
    kImgArr = @[@"message",@"telephone"];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setAvatarImage:[UIImage imageNamed:@"首页侧拉栏_03.png"]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadFrame:CGRectMake(120, -50, 70, 70)];
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    UIButton *interviewBtn =nil;
    UIButton *addFriendBtn =nil;
    UIButton *ShowProjectNumBtn =nil;
    [_pathCover setButton:interviewBtn WithFrame:CGRectMake(30, 160, 60, 30) WithBackgroundImage:[UIImage imageNamed:@"interview"] AddTarget:self WithAction:@selector(beginToInterview)];
    [_pathCover setButton:addFriendBtn WithFrame:CGRectMake(130, 160, 60, 30) WithBackgroundImage:[UIImage imageNamed:@"addFriend"] AddTarget:self WithAction:@selector(beginToAddFriend)];
    [_pathCover setButton:ShowProjectNumBtn WithFrame:CGRectMake(230, 160, 60, 30) WithBackgroundImage:[UIImage imageNamed:@"project"] AddTarget:self WithAction:@selector(beginToShowProjectNum)];
    
    self.tableView.tableHeaderView = self.pathCover;

    
    __weak PersonalDetailViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
}

- (void)_refreshing {
    // refresh your data sources
    NSLog(@"asdfasdfasdf");
    __weak PersonalDetailViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

//**************************************************************************************************************

-(void)beginToInterview//开始会话
{
    NSLog(@"开始进行会话");
}

-(void)beginToAddFriend//开始添加好友
{
    NSLog(@"开始添加好友");
}

-(void)beginToShowProjectNum//开始显示项目数量
{
    NSLog(@"开始显示项目数量");
}

/******************************************************************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
    
}
/******************************************************************************************************************/

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;//决定tableview的section
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==2) {
        return 1;
    }
    if (section ==1) {
        return 2;
    }
    return 3;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    if (indexPath.section==0) {
     
            static NSString *identifier = @"Cell";
            UITableViewCell *cell2 =[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell2) {
                cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 30)];
            companyLabel.textAlignment = NSTextAlignmentLeft;
            companyLabel.text = @"上海深即网络";
            companyLabel.font = [UIFont systemFontOfSize:14];
            [cell2 addSubview:companyLabel];
            
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 80, 30)];
            positionLabel.textAlignment = NSTextAlignmentLeft;
            positionLabel.textColor = [UIColor grayColor];
            positionLabel.text = @"lisis";
            positionLabel.font = [UIFont systemFontOfSize:14];
            [cell2 addSubview:positionLabel];
            return cell2;

    }
    if (indexPath.section ==1) {
        static NSString *identifier = @"Cell1";
        UITableViewCell *cell3 =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell3) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 30)];
        commonLabel.textAlignment = NSTextAlignmentCenter;
        commonLabel.text = [kImgArr objectAtIndex:indexPath.row];
        commonLabel.font = [UIFont systemFontOfSize:14];
        [cell3 addSubview:commonLabel];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(250, 10, 30, 30);
        [rightBtn setBackgroundImage:[UIImage imageNamed:[kImgArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        rightBtn.tag = indexPath.row;
        [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell3 addSubview:rightBtn];
        return cell3;

    }
    if (indexPath.section ==2) {
        static NSString *identifier = @"Cell2";
        UITableViewCell *cell4 =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell4) {
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UITextView *background = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 280, 150)];
        background.editable =NO;
        background.textAlignment = NSTextAlignmentLeft;
        background.text = @"oifdjbfddgk;lkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhi";
        background.font = [UIFont systemFontOfSize:14];
        [cell4 addSubview:background];
        return cell4;
        
    }

    static NSString *identifier = @"Cell3";
    UITableViewCell *cell5 =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell5) {
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UIImageView  *icon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 30, 30)];
    icon.image = [UIImage imageNamed:@"read"];
    [cell5 addSubview:icon];
    
    
    UILabel *ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 30)];
    ProjectLabel.textAlignment = NSTextAlignmentLeft;
    ProjectLabel.text = @"项目名称";
    ProjectLabel.font = [UIFont systemFontOfSize:14];
    [cell5 addSubview:ProjectLabel];
    
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 80, 30)];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.text = @"项目地址";
    addressLabel.font = [UIFont systemFontOfSize:14];
    [cell5 addSubview:addressLabel];
    return cell5;

    
}

-(void)rightBtnClicked:(UIButton *)button
{

    
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
         UIView *view = [[UILabel alloc]initWithFrame:CGRectZero];
        return view;
    }
    UIView *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
    label.center = CGPointMake(160, 20);
    label.backgroundColor = [UIColor clearColor];
    label.text = [KindIndex objectAtIndex:section-1];
    label.textColor = BlueColor;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==2) {
        return 150;
    }
    return 50;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
