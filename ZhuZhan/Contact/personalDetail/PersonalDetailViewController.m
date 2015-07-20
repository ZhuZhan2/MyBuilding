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
#import "ProjectApi.h"
#import "AddressBookApi.h"
#import "ChatViewController.h"
#import "PersonalActivesViewController.h"
@interface PersonalDetailViewController ()
@property(nonatomic,strong)UIButton *secondBtn;
@property(nonatomic,strong)UIButton *thirdBtn;
@property(nonatomic,strong)UIButton *gotoMessageBtn;
@property(nonatomic,strong)UIButton *threeBtnsView;
@property(nonatomic,strong)NSString *name;
@end

@implementation PersonalDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    startIndex = 0;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"人的详情";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 215) bannerPlaceholderImageName:@"默认主图01"];
    _pathCover.delegate = self;
    //[_pathCover setBackgroundImage:[GetImagePath getImagePath:@"人脉－人的详情_02a"]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -70, 70, 70)];
    [_pathCover setFootViewFrame:CGRectMake(0, -105, 320, 320)];
    _pathCover.headImage.layer.cornerRadius =35;
    _pathCover.headImage.layer.masksToBounds =YES;
    [_pathCover setNameFrame:CGRectMake(105, 10, 100, 20) font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter];
    [self getThreeBtn];

    self.tableView.tableHeaderView = self.pathCover;
    
    __weak PersonalDetailViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
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
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(8, 12, width-15, 25);
    [firstBtn setTitle:@"TA的动态" forState:UIControlStateNormal];
    firstBtn.backgroundColor = [UIColor blackColor];
    firstBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    firstBtn.tag = 1;
    [firstBtn addTarget:self action:@selector(gotoTaActive) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.alpha = .8;
    firstBtn.layer.masksToBounds = YES;
    firstBtn.layer.cornerRadius = 4.0;
    [self.threeBtnsView addSubview:firstBtn];
    
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
    
    self.thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirdBtn.frame = CGRectMake(width*2+8, 12, width-15, 25);
    [self.thirdBtn setTitle:@"加关注" forState:UIControlStateNormal];
    [self.thirdBtn addTarget:self action:@selector(addFocus) forControlEvents:UIControlEventTouchUpInside];
    self.thirdBtn.tag = 3;
    self.thirdBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.thirdBtn.backgroundColor = [UIColor blackColor];
    self.thirdBtn.alpha = .8;
    self.thirdBtn.layer.masksToBounds = YES;
    self.thirdBtn.layer.cornerRadius = 4.0;
    [self.threeBtnsView addSubview:self.thirdBtn];
}

- (void)_refreshing {
    // refresh your data sources
    __weak PersonalDetailViewController *wself = self;
    [wself.pathCover stopRefresh];
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

-(void)firstNetWork{
    loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        [self getNetWorkData];
    }else{
        [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.isFocused=[NSString stringWithFormat:@"%@",posts[0][@"isFocus"]];
                if([self.isFocused isEqualToString:@"0"]){
                    [self.thirdBtn setTitle:@"加关注" forState:UIControlStateNormal];
                }else{
                    [self.thirdBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                }
                [self getNetWorkData];
            }else{
                if([ErrorCode errorCode:error] ==403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                        [self firstNetWork];
                    }];
                }
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
                if(![[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
                    if([self.isFriend isEqualToString:@"0"]){
                        [self.threeBtnsView addSubview:self.secondBtn];
                    }else{
                        [self.threeBtnsView addSubview:self.gotoMessageBtn];
                    }
                }
                [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.contactModel.a_userName, XHUserNameKey, nil]];
                [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",self.contactModel.a_userImage]];
                [_pathCover setBackgroundImageUrlString:self.contactModel.a_backgroundImage];
            }
            [self.tableView reloadData];
            [LoadingView removeLoadingView:loadingView];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } userId:self.contactId noNetWork:^{
        [ErrorCode alert];
    }];
}
/******************************************************************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView isMyDynamicList:NO];
    
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
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifier = @"companyCell";
        CompanyCell *companyCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!companyCell) {
            companyCell = [[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if(![self.contactModel.a_company isEqualToString:@""]){
            companyCell.nameLabel.text = self.contactModel.a_company;
            companyCell.statusLabel.text = @"已认证";
        }else{
            companyCell.nameLabel.text = @"";
            companyCell.statusLabel.text = @"";
        }
        companyCell.selectionStyle = NO;
        return companyCell;
    }else if (indexPath.row ==1) {
        static NSString *identifier = @"contactCell";
        ContactCell *contactCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contactCell) {
            contactCell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
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
    }else{
        static NSString *identifier = @"bgCell";
        UITableViewCell *bgCell =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!bgCell) {
            bgCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        bgCell.selectionStyle = NO;
        return bgCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.contactModel.a_company isEqualToString:@""]){
        if(indexPath.row == 0){
            return 0;
        }
    }else{
        if(indexPath.row == 0){
            return 50;
        }
    }
    
    if(indexPath.row == 1){
        return 150;
    }
    
    return 285;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginComplete{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:self.contactId]){
        self.navigationItem.rightBarButtonItem = nil;
        self.secondBtn.hidden = YES;
    }else{
        [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.isFocused=[NSString stringWithFormat:@"%@",posts[0][@"isFocus"]];
                [self getNetWorkData];
            }else{
                if([ErrorCode errorCode:error] ==403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                        [self firstNetWork];
                    }];
                }
            }
        } userId:[LoginSqlite getdata:@"userId"] targetId:self.contactId noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                [self firstNetWork];
            }];
        }];
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    NSLog(@"loginCompleteWithDelayBlock");
}

-(void)gotoMyCenter{

}

-(void)addFriend{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([[LoginSqlite getdata:@"userId"] isEqualToString:self.contactId]){
            return;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:self.contactId forKey:@"userId"];
        [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [self.secondBtn setTitle:@"已发送" forState:UIControlStateNormal];
                self.secondBtn.enabled = NO;
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=NO;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)gotoMessageBtnAction{
    if([self.fromViewName isEqualToString:@"chatView"]){
        if([self.chatType isEqualToString:@"02"]){
            ChatViewController *view = [[ChatViewController alloc] init];
            view.contactId = self.contactId;
            view.titleStr = self.name;
            view.type = @"01";
            [self.navigationController pushViewController:view animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        ChatViewController *view = [[ChatViewController alloc] init];
        view.contactId = self.contactId;
        view.titleStr = self.name;
        view.type = @"01";
        [self.navigationController pushViewController:view animated:YES];
    }
    
//    ChatViewController *view = [[ChatViewController alloc] init];
//    view.contactId = self.contactId;
//    view.titleStr = self.name;
//    view.type = @"01";
//    [self.navigationController pushViewController:view animated:YES];
}

-(void)gotoTaActive{
    PersonalActivesViewController* vc = [[PersonalActivesViewController alloc] init];
    vc.targetId = self.contactId;
    NSLog(@"targetId=%@",vc.targetId);
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addFocus{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([[LoginSqlite getdata:@"userId"] isEqualToString:self.contactId]){
            return;
        }
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
                    [self.thirdBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:^{
                [ErrorCode alert];
            }];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.contactId forKey:@"targetId"];
            [dic setObject:@"01" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"0";
                    [self.thirdBtn setTitle:@"加关注" forState:UIControlStateNormal];
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:^{
                [ErrorCode alert];
            }];
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=NO;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}
@end
