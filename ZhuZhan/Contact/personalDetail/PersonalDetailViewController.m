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
#import "MJRefresh.h"
#import "ProjectApi.h"
#import "AddressBookApi.h"
#import "ChatViewController.h"
@interface PersonalDetailViewController ()
@property(nonatomic,strong)UIButton *secondBtn;
@property(nonatomic,strong)UIButton *gotoMessageBtn;
@property(nonatomic,strong)UIButton *threeBtnsView;
@property(nonatomic,strong)NSString *name;
@end

@implementation PersonalDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    startIndex = 0;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"人的详情";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 25, 22)];
    [rightButton setBackgroundImage:[GetImagePath getImagePath:@"019"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 215) bannerPlaceholderImageName:@"默认主图01"];
    _pathCover.delegate = self;
    //[_pathCover setBackgroundImage:[GetImagePath getImagePath:@"人脉－人的详情_02a"]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -70, 70, 70)];
    [_pathCover setFootViewFrame:CGRectMake(0, -105, 320, 320)];
    _pathCover.headImage.layer.cornerRadius =35;
    _pathCover.headImage.layer.masksToBounds =YES;
    [_pathCover setNameFrame:CGRectMake(105, 10, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    [self getThreeBtn];

    self.tableView.tableHeaderView = self.pathCover;
    
    //集成刷新控件
    [self setupRefresh];
    
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

-(void)getThreeBtn{
    self.threeBtnsView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.threeBtnsView.frame = CGRectMake(0, 170, kScreenWidth, 50);
    //    threeBtnsView.backgroundColor=[UIColor whiteColor];
    [_pathCover addSubview:self.threeBtnsView];
    
    CGFloat width=kScreenWidth/3;
    
//    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    firstBtn.frame = CGRectMake(8, 12, width-15, 25);
//    [firstBtn setTitle:@"询价列表" forState:UIControlStateNormal];
//    firstBtn.backgroundColor = [UIColor blackColor];
//    firstBtn.titleLabel.font=[UIFont systemFontOfSize:12];
//    firstBtn.tag = 1;
//    [firstBtn addTarget:self action:@selector(gotoAskPrice:) forControlEvents:UIControlEventTouchUpInside];
//    firstBtn.alpha = .8;
//    firstBtn.layer.masksToBounds = YES;
//    firstBtn.layer.cornerRadius = 4.0;
//    [threeBtnsView addSubview:firstBtn];
    
    self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondBtn.frame = CGRectMake(width+8, 12, width-15, 25);
    [self.secondBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    [self.secondBtn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    self.secondBtn.tag = 2;
    self.secondBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.secondBtn.backgroundColor = [UIColor blackColor];
    self.secondBtn.alpha = .8;
    self.secondBtn.layer.masksToBounds = YES;
    self.secondBtn.layer.cornerRadius = 4.0;
    
    self.gotoMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoMessageBtn.frame = CGRectMake(width+8, 12, width-15, 25);
    [self.gotoMessageBtn setTitle:@"发送消息" forState:UIControlStateNormal];
    [self.gotoMessageBtn addTarget:self action:@selector(gotoMessageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.gotoMessageBtn.tag = 2;
    self.gotoMessageBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.gotoMessageBtn.backgroundColor = [UIColor blackColor];
    self.gotoMessageBtn.alpha = .8;
    self.gotoMessageBtn.layer.masksToBounds = YES;
    self.gotoMessageBtn.layer.cornerRadius = 4.0;
    
//    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    thirdBtn.frame = CGRectMake(width*2+8, 12, width-15, 25);
//    [thirdBtn setTitle:@"合同列表" forState:UIControlStateNormal];
//    //[thirdBtn addTarget:self action:@selector(gotoAskPrice:) forControlEvents:UIControlEventTouchUpInside];
//    thirdBtn.tag = 3;
//    thirdBtn.titleLabel.font=[UIFont systemFontOfSize:12];
//    thirdBtn.backgroundColor = [UIColor blackColor];
//    thirdBtn.alpha = .8;
//    thirdBtn.layer.masksToBounds = YES;
//    thirdBtn.layer.cornerRadius = 4.0;
//    [threeBtnsView addSubview:thirdBtn];
}

-(void)pathCoverBtnClicked:(UIButton*)btn{
    NSMutableDictionary* dic=[@{@"userId":self.contactId
                        } mutableCopy];
    [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"已成功申请好友" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
        }
    } dic:dic noNetWork:nil];
    NSLog(@"btntag=%d",(int)btn.tag);
}

- (void)_refreshing {
    // refresh your data sources
    __weak PersonalDetailViewController *wself = self;
    [wself.pathCover stopRefresh];
//    double delayInSeconds = 4.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [wself.pathCover stopRefresh];
//    });
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
    startIndex++;
    [ProjectApi GetMyProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.showArr addObjectsFromArray:posts];
            [self.tableView footerEndRefreshing];
            [self.tableView reloadData];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } userId:self.contactId startIndex:startIndex noNetWork:nil];
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
    loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        [self getNetWorkData];
    }else{
        [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.isFocused=[NSString stringWithFormat:@"%@",posts[0][@"isFocus"]];
                [self getNetWorkData];
            }else{
                [LoginAgain AddLoginView:NO];
            }
        } userId:[LoginSqlite getdata:@"userId"] targetId:self.contactId noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                [self firstNetWork];
            }];
        }];
    }
}

//获取网络数据
-(void)getNetWorkData{
    [ContactModel UserDetailsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                self.contactModel = posts[0];
                self.isFriend = self.contactModel.a_isFriend;
                self.name = self.contactModel.a_userName;
                if([self.isFriend isEqualToString:@"0"]){
                    [self.threeBtnsView addSubview:self.secondBtn];
                }else{
                    [self.threeBtnsView addSubview:self.gotoMessageBtn];
                }
                if([posts[1] isKindOfClass:[ParticularsModel class]]){
                    self.parModel = posts[1];
                    contactbackgroundview = [ContactBackgroundView setFram:self.parModel];
                    [viewArr addObject:contactbackgroundview];
                }
                [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.contactModel.a_userName, XHUserNameKey, nil]];
                [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",self.contactModel.a_userImage]];
                [_pathCover setBackgroundImageUrlString:self.contactModel.a_backgroundImage];
                [ProjectApi GetMyProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        self.showArr = posts;
                        [self.tableView reloadData];
                    }
                } userId:self.contactId startIndex:startIndex noNetWork:nil];
            }
            [LoadingView removeLoadingView:loadingView];
        }else{
            [LoginAgain AddLoginView:NO];
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
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.contactId forKey:@"targetId"];
            [dic setObject:@"01" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                }else{
                    [LoginAgain AddLoginView:NO];
                }
            } dic:dic noNetWork:nil];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.contactId forKey:@"targetId"];
            [dic setObject:@"01" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"0";
                }else{
                    [LoginAgain AddLoginView:NO];
                }
            } dic:dic noNetWork:nil];
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
        //bgCell.backgroundColor = [UIColor yellowColor];
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
            
            UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(123, 8, 64, 34)];
            imgaeView.image = [GetImagePath getImagePath:@"人脉－人的详情_30a"];
            [back addSubview:imgaeView];
        }
        cell.selectionStyle = NO;
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
    
    if(viewArr.count ==0){
        if(indexPath.row == 2){
            return 235;
        }
        
        if(indexPath.row == 3){
            return 0;
        }
    }else{
        contactbackgroundview = viewArr[0];
        if(indexPath.row == 2){
            if(contactbackgroundview.frame.size.height>50){
                return 285;
            }else{
                return 235;
            }
        }
        if(indexPath.row == 3){
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
            return 68;
        }
    }

    
    return 68;
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
    if(![self validateMobile:phone]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不是手机号码" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
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
    if(![self isValidateEmail:email]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"邮箱地址不正确"
                                                       delegate:nil
                                              cancelButtonTitle:@"是"
                                              otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"此设备不支持发送邮件"
                                                       delegate:nil
                                              cancelButtonTitle:@"是"
                                              otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    if (![mailClass canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"用户没有设置邮件账户"
                                                       delegate:nil
                                              cancelButtonTitle:@"是"
                                              otherButtonTitles: nil];
        
        [alert show];
        return;
    }
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
    NSLog(@"asfasdf");
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{

}

-(void)gotoMyCenter{

}

//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)addFriend{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.contactId forKey:@"userId"];
    [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            [self.secondBtn setTitle:@"已发送" forState:UIControlStateNormal];
            self.secondBtn.enabled = NO;
        }
    } dic:dic noNetWork:nil];
}

-(void)gotoMessageBtnAction{
    ChatViewController *view = [[ChatViewController alloc] init];
    view.contactId = self.contactId;
    view.titleStr = self.name;
    view.type = @"01";
    [self.navigationController pushViewController:view animated:YES];
}
@end
