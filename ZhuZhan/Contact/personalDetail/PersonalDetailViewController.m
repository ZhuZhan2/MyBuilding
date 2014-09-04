//
//  PersonalDetailViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PersonalDetailViewController.h"
#import "SectionCell.h"
#import "CompanyCell.h"
#import "ContactCell.h"
#import "ProgramDetailViewController.h"

@interface PersonalDetailViewController ()

@end

@implementation PersonalDetailViewController

@synthesize model;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
static NSString *textStr=nil;
static float textHeight =0;

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    

    

    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setHeadImageUrl:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg"];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -50, 70, 70)];
    _pathCover.headImage.layer.cornerRadius =35;
    _pathCover.headImage.layer.masksToBounds =YES;
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    _pathCover.userNameLabel.center = CGPointMake(155, 30);
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    
    
    self.tableView.tableHeaderView = self.pathCover;

    
    __weak PersonalDetailViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
       [self.tableView setSeparatorInset:UIEdgeInsetsZero];//设置tableViewcell下划线的位置没有偏移


    textStr =@"oifdjbfddgk;lkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhivvvvvvvvljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhivvvvvvvvljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhivvvvvvvvljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhivvvvvvvvljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhivvvvvvvvljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhivvvvvvvv";
    model = [[ContactModel alloc] init];
    model.companyName = @"上海深集网络";
    model.projectLeader = @"项目负责人";
    model.email = @"929097264@11.com";
    model.cellPhone =@"13938439096";
    model.contactImageIconArr =@[@"人脉－人的详情_21a",@"人脉－人的详情_23a"];
    model.projectBeginTime =@"2012年9月";
    model.projectEndTime = @"目前";
    model.personalBackground = textStr;
    model.projectName = @"项目名称显示在这里";
    model.projectDistrict = @"华南区－上海";
    textHeight =[self heightForString:textStr fontSize:14 andWidth:280];
    
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)_refreshing {
    // refresh your data sources
    __weak PersonalDetailViewController *wself = self;
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
    
    return 1;//决定tableview的section
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 10;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
     
            static NSString *identifier = @"companyCell";
            CompanyCell *companyCell =[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!companyCell) {
                companyCell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier WithModel:model];
            }
        return companyCell;
    }
    if (indexPath.row ==1 || indexPath.row ==4 ||indexPath.row ==6) {
        static NSString *identifier = @"sectionCell";
        SectionCell *sectionCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!sectionCell) {
            sectionCell = [[SectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier WithIndex:indexPath.row];
        }

        return sectionCell;

    }
    if (indexPath.row ==2 ||indexPath.row==3) {
        static NSString *identifier = @"contactCell";
        ContactCell *contactCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contactCell) {
            contactCell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier WithModel:model WithIndex:indexPath.row];
        }
        return contactCell;

    }
        if (indexPath.row ==5) {
        static NSString *identifier = @"backGroundCell";
        BgCell *backGroundCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!backGroundCell) {
            backGroundCell = [[BgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier WithTextHeight:textHeight WithModel:model];
        }
            return backGroundCell;
        
    }
    

    static NSString *identifier = @"correlateCell";
    CorrelateCell *correlateCell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!correlateCell) {
        correlateCell = [[CorrelateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier WithModel:model];
    }
    return correlateCell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==2) {
        [self onClickAttention:indexPath.row];
        return;
    }
    if (indexPath.row==3) {
        [self onClickToCall:indexPath.row];
        return;
        
    }
    if (indexPath.row==0 ||indexPath.row==1 ||indexPath.row==4 ||indexPath.row==5 ||indexPath.row==6) {
        
        NSLog(@"不做任何操作");
        
        return;
    }
    
    ProgramDetailViewController *programDetailVC = [[ProgramDetailViewController alloc] init];
//    programDetailVC.model 
    [self.navigationController pushViewController:programDetailVC animated:YES];
    

    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==1 || indexPath.row==4 || indexPath.row==6 ||indexPath.row==2 ||indexPath.row==3) {
        
        return 50;
    }
    if (indexPath.row==5) {

        return textHeight+60;
    }
    
    return 60;
    
}


//**************************************************************************************************************
-(void)onClickToCall:(int)indexPathRow//打电话
{
    NSLog(@"***********");
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPhone"]) {
        UILabel *label = (UILabel *)[self.view viewWithTag:indexPathRow];
        NSString *telephone = [NSString stringWithFormat:@"tel://%@",label.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephone]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不能打电话" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

}

//**************************************************************************************************************
-(void)onClickAttention:(int)indexPathRow
{
    if ([MFMailComposeViewController canSendMail]){
        // Email Subject
        NSString *emailTitle = nil;
        // Email Content
        NSString *messageBody = nil;
        // To address
        UILabel *label = (UILabel *)[self.view viewWithTag:indexPathRow];
        NSArray *toRecipents = [NSArray arrayWithObject:label.text];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"此设备不支持发送邮件"
                                                       delegate:nil
                                              cancelButtonTitle:@"是"
                                              otherButtonTitles: nil];
        
        [alert show];
        

    }
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}




- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width//根据 字符串的的 长度来计算UITextView的高度
{
    
    float textViewHeight = [[NSString stringWithFormat:@"%@\n ",value] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size.height;
    
    
    return textViewHeight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
