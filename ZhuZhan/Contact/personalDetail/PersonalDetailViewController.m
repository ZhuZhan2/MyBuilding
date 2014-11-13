//
//  PersonalDetailViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PersonalDetailViewController.h"
#import "ProgramDetailViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginSqlite.h"
#import "IsFocusedApi.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "LoginSqlite.h"
#import "ContactModel.h"
#import "CompanyApi.h"
@interface PersonalDetailViewController ()

@end

@implementation PersonalDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"人的详情";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 25, 22)];
    [rightButton setBackgroundImage:[GetImagePath getImagePath:@"019"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 215)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[GetImagePath getImagePath:@"人脉－人的详情_02a"]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -50, 70, 70)];
    _pathCover.headImage.layer.cornerRadius =35;
    _pathCover.headImage.layer.masksToBounds =YES;
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    _pathCover.userNameLabel.center = CGPointMake(155, 30);
    
    
    self.tableView.tableHeaderView = self.pathCover;

    
    __weak PersonalDetailViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    viewArr = [[NSMutableArray alloc] init];
    self.showArr = [[NSMutableArray alloc] init];
    [self firstNetWork];
    
    self.tableView.separatorStyle = NO;
    [self.tableView setBackgroundColor:RGBCOLOR(242, 242, 242)];
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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)rightBtnClick{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        NSString *string = nil;
        if([self.isFocused isEqualToString:@"0"]){
            string = @"添加关注";
        }else{
            string = @"取消关注";
        }
        UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:string, nil];
        [actionSheet showInView:self.view];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=NO;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)firstNetWork{
    [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.isFocused=[NSString stringWithFormat:@"%@",posts[0][@"isFocused"]];
            [self getNetWorkData];
        }
    } userId:[LoginSqlite getdata:@"userId"] targetId:self.contactId EntityCategory:@"Personal" noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

//获取网络数据
-(void)getNetWorkData{
    NSLog(@"%@",self.contactId);
    [ContactModel UserDetailsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                self.contactModel = posts[0];
                self.parModel = posts[1];
                if([self.parModel.a_id isEqualToString:@""]&&[self.parModel.a_company isEqualToString:@""]&&[self.parModel.a_information isEqualToString:@""]&&[self.parModel.a_inDate isEqualToString:@""]&&[self.parModel.a_outDate isEqualToString:@""]){
                    
                }else{
                    contactbackgroundview = [ContactBackgroundView setFram:self.parModel];
                    [viewArr addObject:contactbackgroundview];
                }
                self.showArr = posts[2];
                [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.contactModel.a_userName, XHUserNameKey, nil]];
                [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",self.contactModel.a_userImage]];
                [self.tableView reloadData];
            }
        }
    } userId:self.contactId noNetWork:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if (buttonIndex==0) {
        if([self.isFocused isEqualToString:@"0"]){
            NSLog(@"关注");
            [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                }
            } dic:[@{@"userId":[LoginSqlite getdata:@"userId"],@"FocusId":self.contactId} mutableCopy] noNetWork:nil];
        }else{
            [CompanyApi DeleteFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"0";
                }
            } dic:[@{@"userId":[LoginSqlite getdata:@"userId"],@"FocusId":self.contactId} mutableCopy] noNetWork:nil];
        }
    }else{
        NSLog(@"取消");
    }
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

    return 5+self.showArr.count;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifier = @"companyCell";
        CompanyCell *companyCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!companyCell) {
            companyCell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        companyCell.companyStr = self.contactModel.a_company;
        companyCell.positionStr = self.contactModel.a_duties;
        companyCell.selectionStyle = NO;
        return companyCell;
    }else if (indexPath.row ==1) {
        static NSString *identifier = @"contactCell";
        ContactCell *contactCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contactCell) {
            contactCell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        contactCell.delegate = self;
        contactCell.model = self.contactModel;
        contactCell.selectionStyle = NO;
        return contactCell;
        
    }else if (indexPath.row == 2) {
        static NSString *identifier = @"contactBackgroundCell";
        ContactBackgroundTableViewCell *contactBackgroundCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contactBackgroundCell) {
            contactBackgroundCell = [[ContactBackgroundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        contactBackgroundCell.model = self.contactModel;
        contactBackgroundCell.selectionStyle = NO;
        return contactBackgroundCell;
    }else if(indexPath.row == 3){
        static NSString *identifier = @"bgCell";
        UITableViewCell *bgCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!bgCell) {
            bgCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [bgCell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if(viewArr.count !=0){
            contactbackgroundview = viewArr[0];
            [bgCell.contentView addSubview:contactbackgroundview];
        }
        bgCell.selectionStyle = NO;
        return bgCell;
    }else if (indexPath.row == 4){
        static NSString *identifier = @"Cell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if(self.showArr.count !=0){
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
            back.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
            [cell.contentView addSubview:back];
            
            UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
            [topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
            [back addSubview:topLineImage];
            
            UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
            imgaeView.image = [GetImagePath getImagePath:@"人脉－人的详情_30a"];
            [back addSubview:imgaeView];
        }
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }else{
        static NSString *identifier = @"CorrelateCell";
        CorrelateCell *correlateCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!correlateCell) {
            correlateCell = [[CorrelateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if(self.showArr.count !=0){
            correlateCell.model = self.showArr[indexPath.row-5];
        }
        correlateCell.selectionStyle = NO;
        return correlateCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.contactModel.a_company isEqualToString:@""] && [self.contactModel.a_duties isEqualToString:@""]){
        if(indexPath.row == 0){
            return 0;
        }
    }else{
        if(indexPath.row == 0){
            return 50;
        }
    }
    
    if([self.contactModel.a_cellPhone isEqualToString:@""] && [self.contactModel.a_email isEqualToString:@""]){
        if(indexPath.row == 1){
            return 0;
        }
    }else{
        if([self.contactModel.a_cellPhone isEqualToString:@""]||[self.contactModel.a_email isEqualToString:@""]){
            if(indexPath.row == 1){
                return 100;
            }
        }else{
            if(indexPath.row == 1){
                return 150;
            }
        }
    }
    
    if(indexPath.row == 2){
        return 285;
    }
    
    if(viewArr.count ==0){
        if(indexPath.row == 3){
            return 0;
        }
    }else{
        if(indexPath.row == 3){
            contactbackgroundview = viewArr[0];
            return contactbackgroundview.frame.size.height;
        }
    }
    
    if(self.showArr.count == 0){
        if(indexPath.row == 4){
            return 0;
        }else if (indexPath.row >4){
            return 0;
        }
    }else{
        if(indexPath.row == 4){
            return 50;
        }else if(indexPath.row>4){
            return 50;
        }
    }

    
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >4){
        ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
        projectModel *model = self.showArr[indexPath.row-5];
        vc.projectId = model.a_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//**************************************************************************************************************
-(void)gotoCallPhone:(NSString *)phone//打电话
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPhone"]) {
        NSString *telephone = [NSString stringWithFormat:@"tel://%@",phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephone]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不能打电话" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

}

//**************************************************************************************************************
-(void)gotoCallEmail:(NSString *)email
{
    
    if ([MFMailComposeViewController canSendMail]){
        // Email Subject
        NSString *emailTitle = nil;
        // Email Content
        NSString *messageBody = nil;
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:email];

        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
       [self.view.window.rootViewController presentViewController:mc animated:YES completion:NULL];


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
    [controller dismissViewControllerAnimated:YES completion:nil];
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

-(void)loginComplete{

}

-(void)loginCompleteWithDelayBlock:(void (^)())block{

}

-(void)gotoMyCenter{

}
    
@end
