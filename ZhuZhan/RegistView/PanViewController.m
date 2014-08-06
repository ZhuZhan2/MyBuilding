//
//  PanViewController.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-8-1.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "PanViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginViewController.h"

@interface PanViewController ()

@end

@implementation PanViewController

static int j =0;
static int count =5;

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
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    nowIMageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 426)];
    nowIMageView.center = self.view.center;
    [self.view addSubview:nowIMageView];
    
UIImage *defaultImg = [UIImage imageNamed:@"扫描页面_03"];
    defaultImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, defaultImg.size.width/3, defaultImg.size.height/3)];
    NSLog(@"宽度%f   高度%f",defaultImg.size.width,defaultImg.size.height);
    defaultImageView.center = self.view.center;
    defaultImageView.image = defaultImg;
    [self.view addSubview:defaultImageView];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(20, self.view.frame.size.height-50, 60, 40);
    [leftBtn setTitle:@"照片采集" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(addmMoreImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake(240, self.view.frame.size.height-50, 60, 40);
    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(jumpToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    event = [[LoginEvent alloc] init];
    event.faceIDArray = [[NSMutableArray alloc] init];
    imgArr = [[NSMutableArray alloc] init];
    textlabel = [[UILabel alloc] initWithFrame:CGRectMake(80,35, 160, 30)];
    textlabel.text = @"还需要采集5张照片";
    textlabel.textColor =BlueColor;
    [self.view addSubview:textlabel];

}

#pragma mark 采集照片－－－－－－－－－－
-(void)addmMoreImage//采集照片
{
        j= 0;
    [defaultImageView removeFromSuperview];
        if(imgArr.count < 5){
            faceVC = [[FaceViewController alloc] init];
            faceVC.delegate = self;
            [self.view addSubview:faceVC.view];
            
        }
    
}


#pragma mark 跳过－－－－－－－－－－
-(void)jumpToLogin      // 返回到登录的界面
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



-(void)addImage:(UIImage *)image{//采集照片时想获取到的带有人脸的照片添加到数组中
    NSLog(@"%d",j);
    [faceVC.view removeFromSuperview];
    faceVC = nil;
    if(j == 1){
        [imgArr addObject:image];
        nowIMageView.image = image;
        NSLog(@"%@",imgArr);
        textlabel.text =[NSString stringWithFormat:@"还需要采集%d张照片",(count-imgArr.count)];
        count=5;
        if(imgArr.count == 5){
            NSLog(@"%@",textlabel);
            indicator = [[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
            [indicator startAnimating];
            [self.view addSubview:indicator];
            [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector: @selector(startLunch)  userInfo:nil repeats:NO];
        }
    }
    j++;
}

-(void)startLunch{
    [event detectWithImageArray:imgArr];
}

-(void)recognizeSuccess   //开始跳转到主页
{
    NSLog(@"asdfasdfasdfasdf");
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
    j=0;

    [imgArr removeAllObjects];
    UIButton *button =(UIButton *)[self.view viewWithTag:2014072401];
    [button setTitle:@"注   册" forState:UIControlStateNormal];
}

- (void)failToRegister  //注册失败
{
    NSLog(@"failToRegister");
        [indicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"注册失败"
                          delegate:nil
                          cancelButtonTitle:@"确定!"
                          otherButtonTitles:nil];
    [alert show];
    
    j=0;
    [imgArr removeAllObjects];
    [faceVC.view removeFromSuperview];
    faceVC = nil;
    

    textlabel.text =[NSString stringWithFormat:@"还需要采集%d张照片",(5-imgArr.count)];
}


-(void)viewDidAppear:(BOOL)animated{   //添加观察者
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToFormerVC) name:@"registerFace" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recognizeSuccess) name:@"faceLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failToRegister) name:@"failRegister" object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated{    //移除观察者
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registerFace" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faceLogin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"failRegister" object:nil];
    
}

-(void)backToFormerVC{         //返回到PanViewController
    [indicator stopAnimating];
    [faceVC.view removeFromSuperview];
    [imgArr removeAllObjects];
    faceVC = nil;
    textlabel.text =[NSString stringWithFormat:@"还需要采集%d张照片",(5-imgArr.count)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
