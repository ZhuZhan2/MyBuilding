//
//  CompanyViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "CompanyViewController.h"
#import "CompanyMemberViewController.h"
#import "MoreCompanyViewController.h"
#import "ProjectApi.h"
#import "CompanyApi.h"
#import "EGOImageView.h"
#import "ContactModel.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface CompanyViewController ()
@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic)NSInteger memberNumber;
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* noticeLabel;
@property(nonatomic)BOOL isFocused;
@end

@implementation CompanyViewController

-(BOOL)isFocused{
    return [self.model.a_focused isEqualToString:@"1"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMyScrollViewAndNavi];//scollview和navi初始
    [self initFirstView];//第一个文字view初始
    if (self.needNoticeView) [self initSecondView];//第二个文字view初始
    [self initThirdView];
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
    
    UIImage *appleImage = [GetImagePath getImagePath:@"公司－我的公司_02a"] ;
    //公司图标
    EGOImageView* companyImageView=[[EGOImageView alloc]initWithPlaceholderImage:appleImage];
    companyImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.a_companyLogo]];
    companyImageView.frame=CGRectMake(15, 20, 75, 75);
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
    businessLabel.text=[NSString stringWithFormat:@"公司行业：%@",self.model.a_companyIndustry];
    businessLabel.font=[UIFont boldSystemFontOfSize:15];
    businessLabel.textColor=RGBCOLOR(168, 168, 168);
    [view addSubview:businessLabel];
}

-(void)handleContent{
    UIImage* image=[GetImagePath getImagePath:self.isFocused?@"公司－我的公司_05b":@"公司－我的公司_05a"];
    if (!self.imageView){
        self.imageView=[[UIImageView alloc]initWithImage:image];
    }else{
        self.imageView.image=image;
    }
    self.noticeLabel.text=self.isFocused?@"已关注":@"加关注";
    self.noticeLabel.textColor=self.isFocused?RGBCOLOR(141, 196, 62):RGBCOLOR(226, 97, 97);
}

-(void)initSecondView{
    self.noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 16, 100, 20)];
    [self handleContent];
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, self.myScrollView.contentSize.height, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    [self scrollViewAddView:view];
    [view addSubview:self.imageView];
    
    self.noticeLabel.font=[UIFont boldSystemFontOfSize:16];
    [view addSubview:self.noticeLabel];
    
    UIButton* noticeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 116, 49)];
    [noticeBtn addTarget:self action:@selector(noticeCompany:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:noticeBtn];
    
    UILabel* memberCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(165, 16, 150, 20)];
    memberCountLabel.text=[NSString stringWithFormat:@"公司员工%@人",self.model.a_companyEmployeeNumber];
    memberCountLabel.font=[UIFont boldSystemFontOfSize:16];
    memberCountLabel.textColor=RGBCOLOR(62, 127, 226);
    [view addSubview:memberCountLabel];
    
    UIButton* memberBtn=[[UIButton alloc]initWithFrame:CGRectMake(116, 0, 204, 49)];
    [memberBtn addTarget:self action:@selector(gotoMemberView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:memberBtn];
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
    
    if (!self.needNoticeView) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1.5)];
        imageView.image=[GetImagePath getImagePath:@"Shadow-top"];
        [view addSubview:imageView];
    }
}

-(void)initMyScrollViewAndNavi{
    //myScrollView初始化
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-49)];
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myScrollView];
    
    //navi初始化
    self.title = @"我的公司";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, 50, 30);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:14];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)noticeCompany:(UIButton*)btn{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    btn.userInteractionEnabled=NO;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (self.isFocused) {
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
        [dic setValue:self.model.a_id forKey:@"FocusId"];
        [CompanyApi DeleteFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.model.a_focused=@"0";
                [self handleContent];
            }
            btn.userInteractionEnabled=YES;
        } dic:dic noNetWork:nil];
    }else{
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
        [dic setValue:self.model.a_id forKey:@"FocusId"];
        [dic setValue:@"Company" forKey:@"FocusType"];
        [dic setValue:@"Personal" forKey:@"UserType"];
        [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                self.model.a_focused=@"1";
                [self handleContent];
            }
            btn.userInteractionEnabled=YES;
        } dic:dic noNetWork:nil];
    }

    NSLog(@"用户选择了关注");
}

-(void)gotoMemberView{
    CompanyMemberViewController* memberVC=[[CompanyMemberViewController alloc]init];
    memberVC.companyId = self.model.a_id;
    [self.navigationController pushViewController:memberVC animated:YES];
}

-(void)more{
    MoreCompanyViewController* moreVC=[[MoreCompanyViewController alloc]init];
    moreVC.isCompanyIdentify=YES;
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
