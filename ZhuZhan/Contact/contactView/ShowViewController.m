//
//  PanViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

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

//    self.view.frame = CGRectMake(30, 80, 260, 300);
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    self.view.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果

   
    
    
    UIImageView  *tempImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 240)];
    tempImageView.image = [GetImagePath getImagePath:@"首页_16"];
    tempImageView.userInteractionEnabled = YES;
    [self.view addSubview:tempImageView];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    icon.image = [GetImagePath getImagePath:@"面部识别登录1_03"];
    icon.center = CGPointMake(110, 80);
    icon.userInteractionEnabled = YES;
    [tempImageView addSubview:icon];
    
    UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    visitBtn.frame =CGRectMake(0, 0, 70, 70);
    visitBtn.center = CGPointMake(110, 80);
    
    [visitBtn addTarget:self action:@selector(beginToVisitDetail:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageView addSubview:visitBtn];
    
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    userName.center = CGPointMake(110, 130);
    userName.text = @"用户名显示";
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:18];
    userName.textColor = [UIColor whiteColor];
    [tempImageView addSubview:userName];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    message.center = CGPointMake(110, 150);
    message.text = @"512个项目，7条动态";
    message.textAlignment = NSTextAlignmentCenter;
    message.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    message.textColor = [UIColor whiteColor];
    [tempImageView addSubview:message];
    

    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(150, 200, 100, 25)];
    bgView.center = CGPointMake(110, 200);
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    bgView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    bgView.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    [tempImageView addSubview:bgView];
    
    UIButton *concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    concernBtn.frame = CGRectMake(150, 200, 100, 25);
    concernBtn.center = CGPointMake(110, 200);
    [concernBtn setTitle:@"添加关注" forState:UIControlStateNormal];
    concernBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [concernBtn addTarget:self action:@selector(gotoConcern:) forControlEvents:UIControlEventTouchUpInside];
    [tempImageView addSubview:concernBtn];
    
}




-(void)viewWillDisappear:(BOOL)animated{
//    conFriendTableView =nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beginToVisitDetail:(UIButton *)button
{
    [_delegate jumpToGoToDetail:button];
}
- (void)gotoConcern:(UIButton *)button
{
    [_delegate jumpToGotoConcern:button];
}

@end
