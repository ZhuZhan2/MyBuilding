//
//  CompanyDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-9.
//
//

#import "CompanyDetailViewController.h"
#import "MoreCompanyViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "CompanyApi.h"
#import "LoginSqlite.h"
#import "ContactModel.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "LoadingView.h"
#import "IsFocusedApi.h"
#import "AskPriceMainViewController.h"
#import "RKViewFactory.h"
#import "RKShadowView.h"
#import "CompanyMemberViewController.h"
@interface CompanyDetailViewController ()<LoginViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)CompanyModel* model;

@property(nonatomic,strong)UIView* mainView;
@property(nonatomic,strong)UIView* assistView;
@property(nonatomic,strong)UIView* activeView;
@property(nonatomic,strong)UIView* authorizationView;
@property(nonatomic,strong)UIView* memberView;
@property(nonatomic,strong)UIView* contactsView;
@property(nonatomic,strong)UIView* describeView;

@property(nonatomic,strong)NSMutableArray* views;
@end

@implementation CompanyDetailViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    self.tableView.backgroundColor = AllBackDeepGrayColor;
    [self firstNetWork];
}

-(void)initNavi{
    self.title = @"公司详情";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.views.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView* view = self.views[indexPath.row];
    return CGRectGetHeight(view.frame);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:self.views[indexPath.row]];
    return cell;
}

/**********************************************************
 函数描述：包括界面各元素
 **********************************************************/
- (NSMutableArray *)views{
    if (!_views) {
        _views = [NSMutableArray array];
        [_views addObject:self.mainView];
        
        if (![self.companyId isEqualToString:[LoginSqlite getdata:@"userId"]]) {
            [_views addObject:self.assistView];
        }
        
        [_views addObject:self.activeView];
        
        if (![[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]&&![self.model.a_reviewStatus isEqualToString:@"01"]){
            [_views addObject:self.authorizationView];
        }
        
        if ([self.companyId isEqualToString:[LoginSqlite getdata:@"userId"]]||[self.model.a_reviewStatus isEqualToString:@"01"]) {
            [_views addObject:self.memberView];
        }
        
        [_views addObject:self.contactsView];
        
        [_views addObject:self.describeView];
    }
    return _views;
}

/**********************************************************
 函数描述：包含logo，名字，行业
 **********************************************************/
- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 113)];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 103, 103)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.a_companyLogo] placeholderImage:[GetImagePath getImagePath:@"默认图_公司详情"]];
        [_mainView addSubview:imageView];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 14, 200, 40)];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = BlueColor;
        titleLabel.text = self.model.a_companyName;
        [RKViewFactory autoLabel:titleLabel maxWidth:200];
        [_mainView addSubview:titleLabel];
        
        UILabel* industryLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, CGRectGetMaxY(titleLabel.frame)+5, 200, 40)];
        industryLabel.font = [UIFont systemFontOfSize:16];
        industryLabel.textColor = AllDeepGrayColor;
        industryLabel.text = self.model.a_companyIndustry;
        [self noDataLabel:industryLabel];
        [RKViewFactory autoLabel:industryLabel maxWidth:200];
        [_mainView addSubview:industryLabel];
        
        UIView* line = [self seperatorLine];
        CGRect frame = line.frame;
        frame.origin.y = CGRectGetMaxY(imageView.frame);
        line.frame = frame;
        [_mainView addSubview:line];
    }
    return _mainView;
}

/**********************************************************
 函数描述：包含询价和关注
 **********************************************************/
- (UIView *)assistView{
    if (!_assistView) {
        _assistView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
        
        UIButton* askPriceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 44)];
        [askPriceBtn setTitleColor:AllRedColor forState:UIControlStateNormal];
        askPriceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [askPriceBtn setTitle:@"发起询价" forState:UIControlStateNormal];
        [askPriceBtn addTarget:self action:@selector(gotoAskPrice) forControlEvents:UIControlEventTouchUpInside];
        [_assistView addSubview:askPriceBtn];
        
        BOOL isFocused = [self.model.a_focused isEqualToString:@"1"];
        UIButton* noticeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44)];
        [noticeBtn setTitleColor:isFocused?RGBCOLOR(187, 187, 187):AllGreenColor forState:UIControlStateNormal];
        noticeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [noticeBtn setTitle:isFocused?@"取消关注":@"加关注" forState:UIControlStateNormal];
        [noticeBtn addTarget:self action:@selector(gotoNoticeView:) forControlEvents:UIControlEventTouchUpInside];
        [_assistView addSubview:noticeBtn];
        
        UIView* line1 = [RKShadowView seperatorLine];
        [_assistView addSubview:line1];
        
        UIView* line2 = [self seperatorLine];
        CGRect frame = line2.frame;
        frame.origin.y = CGRectGetMaxY(askPriceBtn.frame);
        line2.frame = frame;
        [_assistView addSubview:line2];
        
        UIView* line3 = [RKShadowView seperatorLine];
        frame = line3.frame;
        frame.size = CGSizeMake(1, 30);
        line3.frame = frame;
        line3.center = CGPointMake(kScreenWidth/2, 22);
        [_assistView addSubview:line3];
    }
    return _assistView;
}

/**********************************************************
 函数描述：公司动态
 **********************************************************/
- (UIView *)activeView{
    if (!_activeView) {
        _activeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 250, 44)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"公司动态";
        [_activeView addSubview:label];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 8, 13)];
        imageView.image = [GetImagePath getImagePath:@"箭头001"];
        [_activeView addSubview:imageView];
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [_activeView addSubview:btn];
        
        UIView* line1 = [RKShadowView seperatorLine];
        [_activeView addSubview:line1];
        
        UIView* line2 = [self seperatorLine];
        CGRect frame = line2.frame;
        frame.origin.y = CGRectGetMaxY(label.frame);
        line2.frame = frame;
        [_activeView addSubview:line2];
    }
    return _activeView;
}

/**********************************************************
 函数描述：公司认证
 **********************************************************/
- (UIView *)authorizationView{
    if (!_authorizationView) {
        _authorizationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
        
        BOOL notApply = [self.model.a_reviewStatus isEqualToString:@""];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 250, 44)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = notApply?@"认证成为该公司员工":@"认证中...";
        label.textColor = notApply?[UIColor blackColor]:AllLightGrayColor;
        [_authorizationView addSubview:label];
        
        if (notApply) {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 8, 13)];
            imageView.image = [GetImagePath getImagePath:@"箭头001"];
            [_authorizationView addSubview:imageView];
            
            UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
            if (notApply) [btn addTarget:self action:@selector(applyForCertification) forControlEvents:UIControlEventTouchUpInside];
            [_authorizationView addSubview:btn];
        }
        
        UIView* line1 = [RKShadowView seperatorLine];
        [_authorizationView addSubview:line1];
        
        UIView* line2 = [self seperatorLine];
        CGRect frame = line2.frame;
        frame.origin.y = CGRectGetMaxY(label.frame);
        line2.frame = frame;
        [_authorizationView addSubview:line2];
    }
    return _authorizationView;
}

/**********************************************************
 函数描述：公司员工
 **********************************************************/
- (UIView *)memberView{
    if (!_memberView) {
        _memberView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 250, 44)];
        label.font = [UIFont systemFontOfSize:16];
        label.text = [NSString stringWithFormat:@"公司员工%@人",self.model.a_companyEmployeeNumber];
        [_memberView addSubview:label];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 8, 13)];
        imageView.image = [GetImagePath getImagePath:@"箭头001"];
        [_memberView addSubview:imageView];
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [btn addTarget:self action:@selector(gotoMemberView) forControlEvents:UIControlEventTouchUpInside];
        [_memberView addSubview:btn];
        
        UIView* line1 = [RKShadowView seperatorLine];
        [_memberView addSubview:line1];
        
        UIView* line2 = [self seperatorLine];
        CGRect frame = line2.frame;
        frame.origin.y = CGRectGetMaxY(label.frame);
        line2.frame = frame;
        [_memberView addSubview:line2];
    }
    return _memberView;
}

/**********************************************************
 函数描述：联系人和邮箱
 **********************************************************/
- (UIView *)contactsView{
    if (!_contactsView) {
        _contactsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 98)];
        
        UILabel* contactsLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 53, 44)];
        contactsLabel1.font = [UIFont systemFontOfSize:16];
        contactsLabel1.text = @"联系人 ";
        [_contactsView addSubview:contactsLabel1];
        
        UILabel* contactsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contactsLabel1.frame), 0, kScreenWidth, 44)];
        contactsLabel2.font = [UIFont systemFontOfSize:16];
        contactsLabel2.text = self.model.a_companyContactCellphone;
        [self noDataLabel:contactsLabel2];
        [_contactsView addSubview:contactsLabel2];
        
        UILabel* emailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(17, 44, 42, 44)];
        emailLabel1.font = [UIFont systemFontOfSize:16];
        emailLabel1.text = @"邮箱 ";
        [_contactsView addSubview:emailLabel1];
        
        UILabel* emailLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(emailLabel1.frame), 44, kScreenWidth, 44)];
        emailLabel2.font = [UIFont systemFontOfSize:16];
        emailLabel2.text = self.model.a_companyContactEmail;
        [self noDataLabel:emailLabel2];
        [_contactsView addSubview:emailLabel2];
        
        UIView* line1 = [RKShadowView seperatorLine];
        [_contactsView addSubview:line1];
        
        UIView* line2 = [self seperatorLine];
        CGRect frame = line2.frame;
        frame.origin.y = CGRectGetMaxY(emailLabel1.frame);
        line2.frame = frame;
        [_contactsView addSubview:line2];
        
        UIView* line3 = [RKShadowView seperatorLine];
        frame = line3.frame;
        frame.size = CGSizeMake(kScreenWidth-2*17, 1);
        line3.frame = frame;
        line3.center = CGPointMake(kScreenWidth/2, 44);
        [_contactsView addSubview:line3];
    }
    return _contactsView;
}

/**********************************************************
 函数描述：公司介绍
 **********************************************************/
- (UIView *)describeView{
    if (!_describeView) {
        _describeView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel* describeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 200, 44)];
        describeTitleLabel.font = [UIFont systemFontOfSize:16];
        describeTitleLabel.text = @"公司介绍";
        [_describeView addSubview:describeTitleLabel];
        
        UILabel* describeContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 54, 0, 0)];
        describeContentLabel.font = [UIFont systemFontOfSize:16];
        describeContentLabel.text = self.model.a_companyDescription;
        [RKViewFactory autoLabel:describeContentLabel maxWidth:286];
        [self noDataLabel:describeContentLabel];
        [_describeView addSubview:describeContentLabel];
        
        UIView* line1 = [RKShadowView seperatorLine];
        [_describeView addSubview:line1];
        
        UIView* line2 = [self seperatorLine];
        CGRect frame = line2.frame;
        frame.origin.y = CGRectGetMaxY(describeContentLabel.frame)+10;
        line2.frame = frame;
        [_describeView addSubview:line2];
        
        UIView* line3 = [RKShadowView seperatorLine];
        frame = line3.frame;
        frame.size = CGSizeMake(kScreenWidth-2*17, 1);
        line3.frame = frame;
        line3.center = CGPointMake(kScreenWidth/2, 44);
        [_describeView addSubview:line3];
        
        _describeView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(line2.frame));
    }
    return _describeView;
}

-(void)firstNetWork{
    [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.model = posts[0];
            [self reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
    } companyId:self.companyId noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

/**********************************************************
 函数描述：刷新数据
 **********************************************************/
- (void)reloadData{
    self.mainView = nil;
    self.assistView = nil;
    self.activeView = nil;
    self.authorizationView = nil;
    self.contactsView = nil;
    self.describeView = nil;
    self.views = nil;
    [self.tableView reloadData];
}

/**********************************************************
 函数描述：分割线
 **********************************************************/
- (UIView*)seperatorLine{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = AllBackDeepGrayColor;
    
    UIView* seperatorLine = [RKShadowView seperatorLine];
    [view addSubview:seperatorLine];
    
    return view;
}

/**********************************************************
 函数描述：无数据的label处理
 输入参数：需要操作的label
 **********************************************************/
- (void)noDataLabel:(UILabel*)label{
    if ([label.text isEqualToString:@""]) {
        label.text = @"－";
        label.textColor = AllNoDataColor;
    }
}

- (void)gotoAskPrice{
    NSLog(@"询价");
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        AskPriceMainViewController *view = [[AskPriceMainViewController alloc] init];
        view.userId = self.companyId;
        view.userName = self.model.a_loginName;
        view.closeAnimation = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        loginVC.needDelayCancel = YES;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)gotoNoticeView:(UIButton*)btn{
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        if (![ConnectionAvailable isConnectionAvailable]) {
            [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
            return;
        }
        btn.enabled=NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        BOOL isFocused = [self.model.a_focused isEqualToString:@"1"];
        [dic setObject:self.model.a_id forKey:@"targetId"];
        [dic setObject:@"02" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            btn.enabled=YES;
            if (!error) {
                self.model.a_focused=isFocused?@"0":@"1";
                [self reloadData];
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
        loginVC.needDelayCancel = YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
    NSLog(@"用户选择了关注");
}

-(void)applyForCertification{
    NSLog(@"用户选择了 申请认证");
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"是否申请公司认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel = YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)gotoMemberView{
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        CompanyMemberViewController* memberVC=[[CompanyMemberViewController alloc]init];
        memberVC.companyId = self.model.a_id;
        [self.navigationController pushViewController:memberVC animated:YES];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel = YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [self firstNetWork];
    if (block) {
        block();
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0) return;
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.model.a_id forKey:@"companyId"];
    [CompanyApi AddCompanyEmployeeWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.model.a_reviewStatus = @"00";
            [self reloadData];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"已申请认证" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
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
@end
