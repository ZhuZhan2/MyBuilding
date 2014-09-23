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
@interface CompanyViewController ()
@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic)NSInteger memberNumber;
@end

@implementation CompanyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMyScrollViewAndNavi];//scollview和navi初始
    [self initFirstView];//第一个文字view初始
    [self initSecondView];//第二个文字view初始
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
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"公司－我的公司_02a" ofType:@"png"];
    UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    //公司图标
    UIImageView* companyImageView=[[UIImageView alloc]initWithImage:appleImage];
    [view addSubview:companyImageView];

    //公司名称label
    UILabel* companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 20, 200, 50)];
    //companyLabel.backgroundColor=[UIColor yellowColor];
    companyLabel.numberOfLines=2;
    companyLabel.textColor=RGBCOLOR(62, 127, 226);
    NSString* companyName=@"公司名称显示在这里显示在这里里显示在这里里里";
    companyLabel.text=companyName;
    companyLabel.font=[UIFont boldSystemFontOfSize:17];
    [view addSubview:companyLabel];
    
    //公司行业label
    UILabel* businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 70, 300, 20)];
    NSString* businessName=@"建筑";
    businessLabel.text=[NSString stringWithFormat:@"公司行业：%@",businessName];
    businessLabel.font=[UIFont boldSystemFontOfSize:15];
    businessLabel.textColor=RGBCOLOR(168, 168, 168);
    [view addSubview:businessLabel];
}

-(void)initSecondView{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"公司－我的公司_05a" ofType:@"png"];
    UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    UIImageView* imageView=[[UIImageView alloc]initWithImage:appleImage];
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, self.myScrollView.contentSize.height, imageView.frame.size.width, imageView.frame.size.height)];
    [self scrollViewAddView:view];
    [view addSubview:imageView];
    
    UILabel* noticeLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 16, 100, 20)];
    noticeLabel.text=@"加关注";
    noticeLabel.font=[UIFont boldSystemFontOfSize:16];
    noticeLabel.textColor=RGBCOLOR(226, 97, 97);
    [view addSubview:noticeLabel];
    
    UIButton* noticeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 116, 49)];
    [noticeBtn addTarget:self action:@selector(gotoNoticeView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:noticeBtn];
    
    UILabel* memberCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(165, 16, 150, 20)];
    memberCountLabel.text=@"公司员工10110人";
    memberCountLabel.font=[UIFont boldSystemFontOfSize:16];
    memberCountLabel.textColor=RGBCOLOR(62, 127, 226);
    [view addSubview:memberCountLabel];
    
    UIButton* memberBtn=[[UIButton alloc]initWithFrame:CGRectMake(116, 0, 204, 49)];
    [memberBtn addTarget:self action:@selector(gotoMemberView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:memberBtn];
}

-(void)initThirdView{
    NSString* str=@"asdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmfla=====smdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasn=====fmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflasmdlasmdalsdmasldasl;daasdasnfmalsmflas=====mdlasmdalsdmasldasl;da";
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

-(void)gotoNoticeView{
//    [ProjectApi AddUserFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
//        NSLog(@"notice sucess");
//    } dic:[@{@"UserId":@"f483bcfc-3726-445a-97ff-ac7f207dd888",@"ProjectId":self.model.a_id,@"CreateTime":[NSDate date],@"IsDelted":@"true"} mutableCopy]];
    NSLog(@"用户选择了关注");
}

-(void)gotoMemberView{
    CompanyMemberViewController* memberVC=[[CompanyMemberViewController alloc]initWithMemberNumber:self.memberNumber];
    [self.navigationController pushViewController:memberVC animated:YES];
}

-(void)more{
    MoreCompanyViewController* moreVC=[[MoreCompanyViewController alloc]initWithMemberNumber:0];
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
