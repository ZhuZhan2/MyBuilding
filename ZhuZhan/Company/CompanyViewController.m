//
//  CompanyViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "CompanyViewController.h"
#import "CompanyMemberViewController.h"
@interface CompanyViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic)NSInteger memberNumber;
@end

@implementation CompanyViewController
@synthesize hideDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMyScrollViewAndNavi];//scollview和navi初始
    [self initImageView];//第一个大图的初始
    [self initFirstView];//第一个文字view初始
    [self initSecondView];//第二个文字view初始
    [self initMemberView];//员工成员人数view初始
}

-(void)initImageView{
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    imageView.image=[UIImage imageNamed:@"首页_16.png"];
    [self.myScrollView addSubview:imageView];
    
    UIImageView* roundImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"面部识别登录1_03.png"]];
    roundImageView.bounds=CGRectMake(0, 0, 150, 150);
    roundImageView.center=imageView.center;
    [self.myScrollView addSubview:roundImageView];
}

-(void)initMemberView{
    //view的初始,后面为在上添加label button等
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(140, 500, 150, 20)];
    [self.myScrollView addSubview:view];
    
    //公司员工人数label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
    self.memberNumber=14;
    label.text=[NSString stringWithFormat:@"公司员工    %ld",self.memberNumber];
    label.textColor=[UIColor grayColor];
    [view addSubview:label];
    
    //右箭头button
    UIButton* button=[UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame=CGRectMake(120, 0, 30, 20);
    [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

}

-(void)initFirstView{
    //view的初始,后面为在上添加label button等
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(10, 190, 300, 80)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.shadowColor=[[UIColor grayColor]CGColor];
    view.layer.shadowOffset=CGSizeMake(0, .1);
    view.layer.shadowOpacity=.5;
    [self.myScrollView addSubview:view];
    
    //公司名称label
    UILabel* companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 250, 30)];
    NSString* companyName=@"公司名称显示在这里";
    companyLabel.text=companyName;
    companyLabel.font=[UIFont boldSystemFontOfSize:18];
    [view addSubview:companyLabel];
    
    //公司行业label
    UILabel* businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, 300, 20)];
    NSString* businessName=@"建筑";
    businessLabel.text=[NSString stringWithFormat:@"公司行业：%@",businessName];
    businessLabel.textColor=[UIColor grayColor];
    [view addSubview:businessLabel];
    
    //关注button
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(220, 20, 70, 30);
    [button setTitle:@"关注" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    button.layer.cornerRadius=3;
    button.backgroundColor=[UIColor whiteColor];
    button.layer.borderWidth=1;
    button.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    [button addTarget:self action:@selector(notice) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

-(void)initSecondView{
    //label的初始
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(10, 285, 300, 200)];
    label.backgroundColor=[UIColor whiteColor];
    label.layer.shadowColor=[[UIColor grayColor]CGColor];
    label.layer.shadowOffset=CGSizeMake(0, .1);
    label.layer.shadowOpacity=.5;
    label.numberOfLines=0;
    label.text=@"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九";
    [self.myScrollView addSubview:label];

}

-(void)initMyScrollViewAndNavi{
    //myScrollView初始化
    self.myScrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    self.myScrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+30);
    self.myScrollView.backgroundColor=[UIColor whiteColor];
    self.myScrollView.delegate=self;
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myScrollView];
    
    //navi初始化
    self.title = @"我的公司";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, 50, 30);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:17];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)notice{
    NSLog(@"用户选择了关注");
}

-(void)next{
    CompanyMemberViewController* memberVC=[[CompanyMemberViewController alloc]initWithMemberNumber:self.memberNumber];
    [self.navigationController pushViewController:memberVC animated:YES];
    if([hideDelegate respondsToSelector:@selector(homePageTabBarHide)]){
        [hideDelegate homePageTabBarHide];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    if([hideDelegate respondsToSelector:@selector(homePageTabBarRestore)]){
        [hideDelegate homePageTabBarRestore];
    }
}

-(void)more{
    NSLog(@"用户选择了更多");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
