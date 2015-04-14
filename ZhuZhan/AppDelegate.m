//
//  AppDelegate.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FaceppAPI.h"
#import "FaceLoginViewController.h"
#import "HomePageViewController.h"
#import "RecordSqlite.h"
#import "networkConnect.h"
#import "iflyMSC/iflySetting.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "PersonalDetailViewController.h"
#import "LoginSqlite.h"
#import "FirstOpenAppAnimationView.h"
#import "ProjectSqlite.h"
#import "SocketManage.h"
#import "GCDAsyncSocket.h"
#import "JSONKit.h"
#import "GetAddressBook.h"
#import "ImageSqlite.h"
@implementation AppDelegate

+ (AppDelegate *)instance {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        GetAddressBook *addressBook = [[GetAddressBook alloc] init];
//        [addressBook registerAddressBook:^(bool granted, NSError *error) {
//            
//        }];
//    });
    
    self.socket = [SocketManage sharedManager];
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate = self;
        
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。
//        
//        _locationManager.distanceFilter = 100; //控制定位服务更新频率。单位是“米”
//        
        [_locationManager startUpdatingLocation];
        
        //在ios 8.0下要授权
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            
            [_locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
        
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置log等级，此处log为默认在documents目录下的msc.log文件
    [IFlySetting setLogFile:LVL_NONE];
    
    //输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    
    //创建语音配置
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",APPID_VALUE,TIMEOUT_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    NSString *API_KEY = KAPI_KEY;
    NSString *API_SECRET = KAPI_SECRET;
    
    // initialize
    [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
    
    // turn on the debug mode
    [FaceppAPI setDebugMode:TRUE];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
    //9uNmKMAvjHLBdkWD42j21yEp 299
    //57gqKHfcRsYLwlxioZvblI5G 99
	BOOL ret = [_mapManager start:@"9uNmKMAvjHLBdkWD42j21yEp" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
    }else{
        NSLog(@"success");
    }
    [LoginSqlite opensql];
    [RecordSqlite opensql];
    [ProjectSqlite opensql];
    [ImageSqlite opensql];
    
    HomePageViewController *homeVC = [[HomePageViewController alloc] init];
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]){
        NSLog(@"第一次启动程序");
        FirstOpenAppAnimationView* firstAnimationView=[[FirstOpenAppAnimationView alloc]initWithFrame:self.window.frame];
        [self.window addSubview:firstAnimationView];
    }

    return YES;
}

-(void)backgroundHandler{
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{ [self backgroundHandler]; }];
    if (backgroundAccepted)
    {
        NSLog(@"VOIP backgrounding accepted");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
