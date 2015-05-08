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
@interface CompanyDetailViewController ()<LoginViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* noticeLabel;
@property(nonatomic)BOOL isFocused;
@property(nonatomic,strong)CompanyModel *model;
@property(nonatomic,strong)UIButton* noticeBtn;
@property(nonatomic,strong)UIButton* memberBtn;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,strong)NSString *hasCompany;
@property(nonatomic,strong)UILabel* memberCountLabel;
@property(nonatomic,strong)UIImageView *focusedImage;
@property(nonatomic,strong)UIImageView *authenticationImageView;
@property (nonatomic)BOOL isCompanySelf;
@end
@implementation CompanyDetailViewController
-(BOOL)isFocused{
    return [self.model.a_focused isEqualToString:@"1"];
}

- (BOOL)isCompanySelf{
    return [self.companyId isEqualToString:[LoginSqlite getdata:@"userId"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initMyScrollViewAndNavi];//scollview和navi初始
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view];
    [self firstNetWork];
}

-(void)firstNetWork{
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        [CompanyApi HasCompanyWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                self.hasCompany = [NSString stringWithFormat:@"%@",posts[0][@"exists"]];
                [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        if(posts.count !=0){
                            self.model = posts[0];
                            [self initFirstView];//第一个文字view初始
                            if (!self.isCompanySelf)[self initSecondView];//第二个文字view初始
                            [self initThirdView];
                        }
                    }else{
                        if([ErrorCode errorCode:error] == 403){
                            [LoginAgain AddLoginView:NO];
                        }else{
                            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                                [self firstNetWork];
                            }];
                        }
                    }
                    [self removeMyLoadingView];
                } companyId:self.companyId noNetWork:^{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                        [self firstNetWork];
                    }];
                }];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                        [self firstNetWork];
                    }];
                }
            }
        } noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64-49) superView:self.view reloadBlock:^{
                [self firstNetWork];
            }];
        }];
    }else{
        [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                if(posts.count !=0){
                    self.model = posts[0];
                    [self initFirstView];//第一个文字view初始
                    if (!self.isCompanySelf)[self initSecondView];//第二个文字view初始
                    [self initThirdView];
                }
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                        [self firstNetWork];
                    }];
                }
            }
            [self removeMyLoadingView];
        } companyId:self.companyId noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                [self firstNetWork];
            }];
        }];
    }
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

//给MyScrollView的contentSize加高度
-(void)scrollViewAddView:(UIView*)view{
    CGSize size=self.myScrollView.contentSize;
    size.height+=view.frame.size.height;
    self.myScrollView.contentSize=size;
    
    [self.myScrollView addSubview:view];
}

-(void)initFirstView{
    //view的初始,后面为在上添加label button等
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 115)];
    [self scrollViewAddView:view];
    
    //公司图标
    UIImageView* companyImageView=[[UIImageView alloc]init];
    companyImageView.frame=CGRectMake(15, 20, 75, 75);
    companyImageView.layer.cornerRadius=37.5;
    companyImageView.layer.masksToBounds=YES;
    [companyImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.a_companyLogo]] placeholderImage:[GetImagePath getImagePath:@"公司－公司组织_05a"]];
    [view addSubview:companyImageView];
    
    //公司名称label
    UILabel* companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 20, 200, 50)];
    //companyLabel.backgroundColor=[UIColor yellowColor];
    companyLabel.numberOfLines=2;
    companyLabel.textColor=RGBCOLOR(62, 127, 226);
    NSString* companyName=self.model.a_companyName;
    companyLabel.text=companyName;
    companyLabel.font=[UIFont boldSystemFontOfSize:19];
    [view addSubview:companyLabel];
    
    //公司行业label
    UILabel* businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 72, 300, 20)];
    NSString* businessName=self.model.a_companyIndustry;
    businessLabel.text=[NSString stringWithFormat:@"公司行业：%@",businessName];
    businessLabel.font=[UIFont boldSystemFontOfSize:15];
    businessLabel.textColor=RGBCOLOR(168, 168, 168);
    [view addSubview:businessLabel];
}

-(void)handleContent{
//    NSString* imageName;
//    if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
//        imageName=self.isFocused?@"公司－公司详情_05d":@"公司－公司详情_05c";
//    }else{
//        imageName=self.isFocused?@"公司－公司详情_05b":@"公司－公司详情_05a";
//    }
    UIImage* image=[GetImagePath getImagePath:@"公司详情图标bg"];
    if (!self.imageView){
        self.imageView=[[UIImageView alloc]initWithImage:image];
    }else{
        self.imageView.image=image;
    }
    self.noticeLabel.text=self.isFocused?@"已关注":@"加关注";
    self.noticeLabel.textColor=self.isFocused?RGBCOLOR(141, 196, 62):RGBCOLOR(226, 97, 97);

    if(!self.focusedImage){
        self.focusedImage = [[UIImageView alloc] initWithFrame:CGRectMake(45, 18, 18, 18)];
        self.focusedImage.image = [GetImagePath getImagePath:self.isFocused?@"公司详情图标04":@"公司详情图标01"];
        [self.imageView addSubview:self.focusedImage];
    }else{
        self.focusedImage.image = [GetImagePath getImagePath:self.isFocused?@"公司详情图标04":@"公司详情图标01"];
    }
}

-(void)initSecondView{
    self.noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 16, 100, 20)];
    [self handleContent];
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, self.myScrollView.contentSize.height, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    [self scrollViewAddView:view];
    [view addSubview:self.imageView];
    
    self.noticeLabel.font=[UIFont boldSystemFontOfSize:16];
    [view addSubview:self.noticeLabel];
    
    self.noticeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 116, 49)];
    [self.noticeBtn addTarget:self action:@selector(gotoNoticeView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.noticeBtn];
    
    self.memberCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(225, 16, 150, 20)];
    self.memberCountLabel.font=[UIFont boldSystemFontOfSize:16];
    [view addSubview:self.memberCountLabel];
    
    self.authenticationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 18, 18, 18)];
    [view addSubview:self.authenticationImageView];
    
    self.memberBtn=[[UIButton alloc]initWithFrame:CGRectMake(116, 0, 204, 49)];
    [self.memberBtn addTarget:self action:@selector(applyForCertification) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"hasCompany===>%@",self.hasCompany);
    NSLog(@"a_reviewStatus===>%@",self.model.a_reviewStatus);
    if([self.hasCompany isEqualToString:@"1"]){
        self.memberCountLabel.textColor=[UIColor lightGrayColor];
        self.memberBtn.enabled = NO;
        [self.authenticationImageView setImage:[GetImagePath getImagePath:@"公司详情图标03"]];
        if([self.model.a_reviewStatus isEqualToString:@"01"]){
            self.memberCountLabel.text=@"已认证";
        }else if ([self.model.a_reviewStatus isEqualToString:@"00"]){
            self.memberCountLabel.text=@"已申请";
        }else{
            self.memberCountLabel.text=@"申请认证";
        }
    }else{
        if ([self.model.a_reviewStatus isEqualToString:@"00"]){
            self.memberCountLabel.text=@"已申请";
            self.memberCountLabel.textColor=[UIColor lightGrayColor];
            self.memberBtn.enabled = NO;
            [self.authenticationImageView setImage:[GetImagePath getImagePath:@"公司详情图标03"]];
        }else{
            self.memberCountLabel.text=@"申请认证";
            [self.authenticationImageView setImage:[[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]?[GetImagePath getImagePath:@"公司详情图标03"]:[GetImagePath getImagePath:@"公司详情图标02"]];
            self.memberCountLabel.textColor=[[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]?RGBCOLOR(170, 170, 170):RGBCOLOR(62, 127, 226);
            self.memberBtn.enabled = ![[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"];
        }
    }
    NSLog(@"%d",self.memberBtn.enabled);
    [view addSubview:self.memberBtn];
}

-(void)initThirdView{
    NSString* str=self.model.a_companyDescription;
    CGRect bounds=[str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 280, bounds.size.height)];
    label.numberOfLines=0;
    label.text=str;
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=GrayColor;
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, self.myScrollView.contentSize.height, 320, label.frame.size.height+30)];
    [view addSubview:label];
    [self scrollViewAddView:view];
    
    if (self.isCompanySelf) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 4)];
        imageView.image=[GetImagePath getImagePath:@"公司－我的公司_11a"];
        [view addSubview:imageView];
    }
}

-(void)initMyScrollViewAndNavi{
    //myScrollView初始化
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)];
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myScrollView];
    
    //navi初始化
    self.title = @"公司详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    //左back button
    UIButton* leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [leftButton setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    if (self.isCompanySelf) return;
    //右按钮 询价 button
    UIButton* rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitle:@"询价" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];

}

- (void)rightBtnClicked{
    NSLog(@"询价");
}

-(void)gotoNoticeView{
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        if (![ConnectionAvailable isConnectionAvailable]) {
            [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
            return;
        }
        self.noticeBtn.enabled=NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (self.isFocused) {
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"02" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                self.noticeBtn.enabled=YES;
                if (!error) {
                    self.model.a_focused=@"0";
                    [self handleContent];
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
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"02" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                self.noticeBtn.enabled=YES;
                if(!error){
                    self.model.a_focused=@"1";
                    [self handleContent];
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
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loginComplete{
    [self.navigationController popViewControllerAnimated:NO];
    if ([self.delegate respondsToSelector:@selector(gotoCompanyDetail:)]) {
        [self.delegate gotoCompanyDetail:NO];
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
//    [self.navigationController popViewControllerAnimated:NO];
//    if ([self.delegate respondsToSelector:@selector(gotoCompanyDetail:)]) {
//        [self.delegate gotoCompanyDetail:NO];
//    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        if (![ConnectionAvailable isConnectionAvailable]) {
            [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
            return;
        }
        self.memberBtn.enabled=NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:self.model.a_id forKey:@"companyId"];
        [CompanyApi AddCompanyEmployeeWithBlock:^(NSMutableArray *posts, NSError *error) {
            self.memberCountLabel.text=@"已申请";
            self.memberCountLabel.textColor = [UIColor lightGrayColor];
            [self.authenticationImageView setImage:[GetImagePath getImagePath:@"公司详情图标03"]];
            if(!error){
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
}
@end
