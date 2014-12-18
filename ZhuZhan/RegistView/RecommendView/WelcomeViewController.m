//
//  WelcomeViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBar];
    self.view.backgroundColor=RGBCOLOR(235, 235, 235);
    [self initWelcomeLabel];
    [self initEnterIntoBtn];
}

-(void)initWelcomeLabel{
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    label.text=@"欢迎加入布丁网";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:25];
    label.center=CGPointMake(160, 264);
    [self.view addSubview:label];
}

-(void)initEnterIntoBtn{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20, 410, 280, 45);
    [btn setBackgroundImage:[GetImagePath getImagePath:@"推荐页面05a"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(postRegistCompleteNoti) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)postRegistCompleteNoti{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"registComplete" object:nil];
}

-(void)initNaviBar{
    self.title = @"欢迎";
    //返还按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
