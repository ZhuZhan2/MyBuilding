//
//  CompanyViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "CompanyViewController.h"
#import "CompanyMemberViewController.h"
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
    //[self initSecondView];//第二个文字view初始
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
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [self scrollViewAddView:view];
    
    //公司图标
    UIImageView* companyImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"公司－我的公司_02a.png"]];
    [view addSubview:companyImageView];

    //公司名称label
    UILabel* companyLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 20, 200, 50)];
    //companyLabel.backgroundColor=[UIColor yellowColor];
    companyLabel.numberOfLines=2;
    companyLabel.textColor=BlueColor;
    NSString* companyName=@"公司名称显示在这里显示";//在这里里显示在这里里里";
    companyLabel.text=companyName;
    companyLabel.font=[UIFont boldSystemFontOfSize:17];
    [view addSubview:companyLabel];
    
    
    //公司行业label
    UILabel* businessLabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 70, 300, 20)];
    NSString* businessName=@"建筑";
    businessLabel.text=[NSString stringWithFormat:@"公司行业：%@",businessName];
    businessLabel.font=[UIFont systemFontOfSize:15];
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
    //[view addSubview:button];
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
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64-49)];
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myScrollView];
    
    //navi初始化
    self.title = @"我的公司";
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
