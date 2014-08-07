//
//  FaceLoginViewController.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-7-23.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FaceLoginViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"

@interface FaceLoginViewController ()

@end

@implementation FaceLoginViewController

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
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgImgView setImage:[UIImage imageNamed:@"面部识别登录.png"]];
    bgImgView.userInteractionEnabled =YES;
    [self.view addSubview:bgImgView];
    
    self.navigationController.navigationBar.hidden =YES;
    UIImageView *iconBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 190, 190)];
    iconBgImgView.center = CGPointMake(160.5, 200);
    iconBgImgView.image = [UIImage imageNamed:@"面部识别登录_03"];
    [bgImgView addSubview:iconBgImgView];
    
    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 220, 180, 180)];
    faceImageView.image =[UIImage imageNamed:@"面部识别登录1_03"];
        faceImageView.center = CGPointMake(160, 205);
    [bgImgView addSubview:faceImageView];
    
    //添加计时器
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector: @selector(beginFaceRecoginzer)  userInfo:nil repeats:NO];
    
    UIImageView *squareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    squareImageView.center = CGPointMake(159.5, 205);
    squareImageView.image = [UIImage imageNamed:@"面部识别登录_07"];
    [bgImgView addSubview:squareImageView];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 50)];
    detailLabel.center = CGPointMake(160, 330);
    detailLabel.numberOfLines =2;
    detailLabel.font = [UIFont systemFontOfSize:15.0f];
    
   detailLabel.text = @"        请在光线充足的地方进行识别登录，保持正面对准摄像头。";
    detailLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:detailLabel];
    
}


-(void)viewDidAppear:(BOOL)animated{        //添加观察者
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToFormerVC) name:@"face" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToLogin) name:@"Login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recognizeSuccess) name:@"faceLogin" object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated{     //移除观察者
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faceRegister" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Login" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faceLogin" object:nil];

}


#pragma mark  开始进行脸部识别－－－－－－－－－－
-(void)beginFaceRecoginzer     //第一次进行脸部识别
{

    faceVC = [[FaceViewController alloc] init];
    [self.view addSubview:faceVC.view];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event     //第二次第三进行脸部识别
{

    faceVC = [[FaceViewController alloc] init];
    [self.view addSubview:faceVC.view];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToFormerVC{    //返回到上一个界面
    [faceVC.view removeFromSuperview];
    faceVC = nil;
}


-(void)backToLogin{//返回到密码登录界面
    NSLog(@"noninininoilnkkljjk");
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[AppDelegate instance] window].rootViewController = naVC;
    [[[AppDelegate instance] window] makeKeyAndVisible];
    
    
}

-(void)recognizeSuccess      //识别成功进行页面跳转
{

    HomePageViewController *homepage = [[HomePageViewController alloc] init];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[[AppDelegate instance] window] cache:YES];
    NSUInteger tview1 = [[self.view subviews] indexOfObject:[[AppDelegate instance] window]];
    NSUInteger tview2 = [[self.view subviews] indexOfObject:homepage.view];
    [self.view exchangeSubviewAtIndex:tview2 withSubviewAtIndex:tview1];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations]; 
    
    [[AppDelegate instance] window].rootViewController = homepage;
    [[[AppDelegate instance] window] makeKeyAndVisible];
    
}


@end
