//
//  HomePageViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//
#import "HomePageViewController.h"
#import "LoginModel.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface HomePageViewController ()<LoginViewDelegate>

@end

@implementation HomePageViewController

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
    NSLog(@"image ==> %@",image(@"111", @"222", @"333", @"444", @"555"));
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [GetImagePath getImagePath:@"loading"];
    [self.view addSubview:imageView];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 519)];
    contactview = [[ContactViewController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:contactview];
    [nav.view setFrame:CGRectMake(0, 0, 320, 519)];
    nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
    [contentView addSubview:nav.view];

    toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 519, 320, 49)];
   [toolView setBackgroundColor:RGBCOLOR(229, 229, 229)];
    
    contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactBtn setFrame:CGRectMake(25, 8, 30, 40)];
    [contactBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单01b"] forState:UIControlStateNormal];
    contactBtn.tag = 0;
    [contactBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:contactBtn];
    
    projectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [projectBtn setFrame:CGRectMake(105, 8, 30, 40)];
    [projectBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单02a"] forState:UIControlStateNormal];
    projectBtn.tag = 1;
    [projectBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:projectBtn];
    
    companyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [companyBtn setFrame:CGRectMake(185, 8, 30, 40)];
    [companyBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单03a"] forState:UIControlStateNormal];
    companyBtn.tag = 3;
    [companyBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:companyBtn];
    
    tradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tradeBtn setFrame:CGRectMake(265, 8, 30, 40)];
    [tradeBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单04a"] forState:UIControlStateNormal];
    tradeBtn.tag = 4;
    [tradeBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:tradeBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotoLogin:) name:@"LoginAgain" object:nil];
    
    
    //更多按钮的实现
    UIImage *storyMenuItemImage = [GetImagePath getImagePath:@"bg-menuitem"];
    UIImage *storyMenuItemImagePressed = [GetImagePath getImagePath:@"bg-menuitem-highlighted"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[GetImagePath getImagePath:@"icon-star"]
                                                         highlightedContentImage:nil flag:0];
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[GetImagePath getImagePath:@"icon-star"]
                                                         highlightedContentImage:nil flag:0];
    // Place MenuItem.
    QuadCurveMenuItem *placeMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[GetImagePath getImagePath:@"icon-star"]
                                                        highlightedContentImage:nil flag:0];
    // Music MenuItem.
    QuadCurveMenuItem *musicMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[GetImagePath getImagePath:@"icon-star"]
                                                        highlightedContentImage:nil flag:0];
    // Thought MenuItem.
    QuadCurveMenuItem *thoughtMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                 highlightedImage:storyMenuItemImagePressed
                                                                     ContentImage:[GetImagePath getImagePath:@"icon-star"]
                                                          highlightedContentImage:nil flag:0];
    
    NSArray *menus = [NSArray arrayWithObjects:cameraMenuItem, peopleMenuItem, placeMenuItem, musicMenuItem, thoughtMenuItem, nil];
    
    menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds menus:menus];
    //menu.backgroundColor=[UIColor greenColor];
    menu.delegate = self;
    
     
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            imageView.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            [self.view addSubview:contentView];
            [self.view addSubview:toolView];
            //[self.view addSubview:menu];
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)homePageTabBarHide{
    contentView.frame=CGRectMake(0, 0, 320, 568);
    [nav.view setFrame:CGRectMake(0, 0, 320, 568)];
    menu.hidden=YES;
    toolView.hidden=YES;
}

-(void)homePageTabBarRestore{
    contentView.frame=CGRectMake(0, 0, 320, 519);
    [nav.view setFrame:CGRectMake(0, 0, 320, 519)];
    menu.hidden=NO;
    toolView.hidden=NO;

}

-(void)BtnClick:(UIButton *)button{
    for(int i=0;i<contentView.subviews.count;i++) {
        [((UIView*)[contentView.subviews objectAtIndex:i]) removeFromSuperview];
    }
    switch (button.tag) {
        case 0:
            NSLog(@"人脉");
            contactview = [[ContactViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:contactview];
            [nav.view setFrame:CGRectMake(0, 0, 320, 519)];
            nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
            [contentView addSubview:nav.view];
            [contactBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单01b"] forState:UIControlStateNormal];
            [projectBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单02a"] forState:UIControlStateNormal];
            [companyBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单03a"] forState:UIControlStateNormal];
            [tradeBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单04a"] forState:UIControlStateNormal];
            contactview = nil;
            break;
        case 1:
            NSLog(@"项目");
            projectview = [[ProjectTableViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:projectview];
            [nav.view setFrame:CGRectMake(0, 0, 320, 519)];
            nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
            [contentView addSubview:nav.view];
            [contactBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单01a"] forState:UIControlStateNormal];
            [projectBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单02b"] forState:UIControlStateNormal];
            [companyBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单03a"] forState:UIControlStateNormal];
            [tradeBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单04a"] forState:UIControlStateNormal];
            projectview = nil;
            break;
        case 2:
            NSLog(@"更多");
            break;
        case 3:
            NSLog(@"公司");
            companyview = [[CompanyTotalViewController alloc] init];
            nav = [[UINavigationController alloc] initWithRootViewController:companyview];
            [nav.view setFrame:CGRectMake(0, 0, 320, 519)];
            nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
            [contentView addSubview:nav.view];
            [contactBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单01a"] forState:UIControlStateNormal];
            [projectBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单02a"] forState:UIControlStateNormal];
            [companyBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单03b"] forState:UIControlStateNormal];
            [tradeBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单04a"] forState:UIControlStateNormal];
            companyview = nil;
            break;
        case 4:
            NSLog(@"交易");
            productView = [[ProductViewController alloc] init];
            //tradeView=[[TradeViewController alloc]init];
            //testVC=[[ViewController alloc]init];
            
            nav = [[UINavigationController alloc] initWithRootViewController:productView];
            //nav = [[UINavigationController alloc] initWithRootViewController:tradeView];
            //nav=[[UINavigationController alloc]initWithRootViewController:testVC];
            [nav.view setFrame:CGRectMake(0, 0, 320, 519)];
            nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
            [contentView addSubview:nav.view];
            [contactBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单01a"] forState:UIControlStateNormal];
            [projectBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单02a"] forState:UIControlStateNormal];
            [companyBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单03a"] forState:UIControlStateNormal];
            [tradeBtn setBackgroundImage:[GetImagePath getImagePath:@"主菜单04b"] forState:UIControlStateNormal];
            productView = nil;
            testVC=nil;
            break;
        default:
            break;
    }
}

-(void)gotoLogin:(NSNotification*)notification{
    NSDictionary *nameDictionary = [notification userInfo];
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    [LoginSqlite deleteAll];
    
    UIButton* btn=[UIButton new];
    btn.tag=0;
    [self BtnClick:btn];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    HomePageViewController* homeVC=(HomePageViewController*)[AppDelegate instance].window.rootViewController;
    UIButton* btn=[[UIButton alloc]init];
    btn.tag=0;
    [homeVC BtnClick:btn];
    if (block) {
        block();
    }
}
//
////更多按钮的委托方法
//- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
//{
//    if(idx == 0){
//        NSLog(@"推荐信");
//    }else if(idx == 1){
//        NSLog(@"添加好友");
//    }else if(idx == 2){
//        NSLog(@"拓展人脉");
//    }else if (idx == 3){
//        NSLog(@"聊天");
//    }else{
//        NSLog(@"通讯录");
//    }
//}
@end
