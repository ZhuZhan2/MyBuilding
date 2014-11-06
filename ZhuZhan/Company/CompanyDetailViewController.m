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
#import "EGOImageView.h"
#import "CompanyApi.h"
#import "LoginSqlite.h"
#import "ContactModel.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
@interface CompanyDetailViewController ()<LoginViewDelegate>
@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* noticeLabel;
@property(nonatomic)BOOL isFocused;
@property(nonatomic,strong)CompanyModel *model;
@property(nonatomic,strong)UIButton* noticeBtn;
@property(nonatomic,strong)UIButton* memberBtn;
@end
@implementation CompanyDetailViewController
-(BOOL)isFocused{
    return [self.model.a_focused isEqualToString:@"1"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initMyScrollViewAndNavi];//scollview和navi初始
    [self firstNetWork];
}

-(void)firstNetWork{
    [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                self.model = posts[0];
                [self initFirstView];//第一个文字view初始
                [self initSecondView];//第二个文字view初始
                [self initThirdView];
            }
        }
    } companyId:self.companyId noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
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
    EGOImageView* companyImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"公司－公司组织_05a"]];
    companyImageView.frame=CGRectMake(15, 20, 75, 75);
    companyImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.a_companyLogo]];
    [view addSubview:companyImageView];
    
    //公司名称label
    UILabel* companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 20, 200, 50)];
    //companyLabel.backgroundColor=[UIColor yellowColor];
    companyLabel.numberOfLines=2;
    companyLabel.textColor=RGBCOLOR(62, 127, 226);
    NSString* companyName=self.model.a_companyName;
    companyLabel.text=companyName;
    companyLabel.font=[UIFont boldSystemFontOfSize:17];
    [view addSubview:companyLabel];
    
    //公司行业label
    UILabel* businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 70, 300, 20)];
    NSString* businessName=self.model.a_companyIndustry;
    businessLabel.text=[NSString stringWithFormat:@"公司行业：%@",businessName];
    businessLabel.font=[UIFont boldSystemFontOfSize:15];
    businessLabel.textColor=RGBCOLOR(168, 168, 168);
    [view addSubview:businessLabel];
}

-(void)handleContent{
    UIImage* image=[GetImagePath getImagePath:self.isFocused?@"公司－公司详情_05b":@"公司－公司详情_05a"];
    if (!self.imageView){
        self.imageView=[[UIImageView alloc]initWithImage:image];
    }else{
        self.imageView.image=image;
    }
    self.noticeLabel.text=self.isFocused?@"已关注":@"加关注";
    self.noticeLabel.textColor=self.isFocused?RGBCOLOR(141, 196, 62):RGBCOLOR(226, 97, 97);
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
    
    UILabel* memberCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(225, 16, 150, 20)];
    memberCountLabel.text=@"申请认证";
    memberCountLabel.font=[UIFont boldSystemFontOfSize:16];
    memberCountLabel.textColor=RGBCOLOR(62, 127, 226);
    [view addSubview:memberCountLabel];
    
    self.memberBtn=[[UIButton alloc]initWithFrame:CGRectMake(116, 0, 204, 49)];
    [self.memberBtn addTarget:self action:@selector(applyForCertification) forControlEvents:UIControlEventTouchUpInside];
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
}

-(void)initMyScrollViewAndNavi{
    //myScrollView初始化
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myScrollView];
    
    //navi初始化
    self.title = @"公司详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];

}

-(void)gotoNoticeView{
    if(![[LoginSqlite getdata:@"deviceToken"] isEqualToString:@""]){
        if (![ConnectionAvailable isConnectionAvailable]) {
            [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
            return;
        }
        self.noticeBtn.enabled=NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if (self.isFocused) {
            [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
            [dic setValue:self.model.a_id forKey:@"FocusId"];
            [CompanyApi DeleteFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                self.noticeBtn.enabled=YES;
                if (!error) {
                    self.model.a_focused=@"0";
                    [self handleContent];
                }
            } dic:dic noNetWork:nil];
        }else{
            [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
            [dic setValue:self.model.a_id forKey:@"FocusId"];
            [dic setValue:@"Company" forKey:@"FocusType"];
            [dic setValue:@"Personal" forKey:@"UserType"];
            [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                self.noticeBtn.enabled=YES;
                if(!error){
                    self.model.a_focused=@"1";
                    [self handleContent];
                }
            } dic:dic noNetWork:nil];
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
    NSLog(@"用户选择了 申请关注");
    if(![[LoginSqlite getdata:@"deviceToken"] isEqualToString:@""]){
        if (![ConnectionAvailable isConnectionAvailable]) {
            [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
            return;
        }
        self.memberBtn.enabled=NO;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"employeeId"];
        [dic setValue:self.model.a_id forKey:@"companyId"];
        [CompanyApi AddCompanyEmployeeWithBlock:^(NSMutableArray *posts, NSError *error) {
            self.memberBtn.enabled=YES;
            if(!error){
                NSLog(@"成功");
            }
        } dic:dic noNetWork:nil];
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

}
@end
