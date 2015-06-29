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
#import "PostAddressBook.h"
#import "ImageSqlite.h"
#import "MarketSearchSqlite.h"
#import "ForcedUpdateApi.h"
#import "ForcedUpdateModel.h"
@implementation AppDelegate

+ (AppDelegate *)instance {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"firstLaunch==>%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"serverAddress"]);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults objectForKey:@"serverAddress"]){
        //正式
            [userDefaults setObject:@"http://apis.mybuilding.cn:15427/WebService" forKey:@"serverAddress"];
            [userDefaults setObject:@"apis.mybuilding.cn" forKey:@"socketServer"];
            [userDefaults setInteger:1428 forKey:@"socketPort"];
            [userDefaults setObject:@"http://apis.mybuilding.cn:15428/ImService" forKey:@"socketHttp"];
            [userDefaults synchronize];
        //开发
//        [userDefaults setObject:@"http://10.1.5.104:8080/server" forKey:@"serverAddress"];
//        [userDefaults setObject:@"10.1.5.104" forKey:@"socketServer"];
//        [userDefaults setInteger:44455 forKey:@"socketPort"];
//        [userDefaults setObject:@"http://10.1.5.104:8080/im" forKey:@"socketHttp"];
//        [userDefaults synchronize];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PostAddressBook *postAddressBook = [[PostAddressBook alloc] init];
        [postAddressBook registerAddressBook:^(bool granted, NSError *error) {
            
        }];
    });
    
    self.socket = [SocketManage sharedManager];
    application.applicationIconBadgeNumber = 0;
    [ForcedUpdateApi GetLastestReleaseWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            ForcedUpdateModel* model = posts[0];
            self.updateUrl = model.a_downloadUrl;
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:model.a_releaseLog delegate:self cancelButtonTitle:nil otherButtonTitles:@"稍后更新",@"立即更新", nil];
            [alertView show];
        }
    } userVersion:UserClientVersion deviceType:@"05" downloadType:UpdateDownloadType noNetWork:nil];
    
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
    //BOOL ret = [_mapManager start:@"57gqKHfcRsYLwlxioZvblI5G" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"success");
    }
    [ImageSqlite delAll];
    [LoginSqlite opensql];
    [RecordSqlite opensql];
    [ProjectSqlite opensql];
    [ImageSqlite opensql];
    [MarketSearchSqlite opensql];
    
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    if (IS_OS_8_OR_LATER) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    
    HomePageViewController *homeVC = [[HomePageViewController alloc] init];
    self.window.rootViewController = homeVC;
    [self.window makeKeyAndVisible];
    NSLog(@"firstLaunch==>%@",[userDefaults objectForKey:@"firstLaunch"]);
    if(![userDefaults objectForKey:@"firstLaunch"]){
        NSLog(@"第一次启动程序");
        FirstOpenAppAnimationView* firstAnimationView=[[FirstOpenAppAnimationView alloc]initWithFrame:self.window.frame];
        [self.window addSubview:firstAnimationView];
    }
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"launchOptions===>%@",launchOptions);
    if(userInfo) {
        [self handleRemoteNotification:application userInfo:userInfo];
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
    }
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
//    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{ [self backgroundHandler]; }];
//    if (backgroundAccepted)
//    {
//        NSLog(@"VOIP backgrounding accepted");
//    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    //将device token转换为字符串
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",newDeviceToken];
    //modify the token, remove the  "<, >"
    NSLog(@"    deviceTokenStr  lentgh:  %d  ->%@", (int)[deviceTokenStr length], [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)]);
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceTokenStr = %@",deviceTokenStr);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     [userDefaults setObject:deviceTokenStr forKey:@"deviceTokenStr"];
    [userDefaults synchronize];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error === >%@",error);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"notification ======>%@",notification.alertBody);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"userInfo ====>%@",userInfo);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    //application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber;
}

- (void)handleRemoteNotification:(UIApplication *)application userInfo:(NSDictionary *)userInfo {
    NSLog(@"=====>%@",userInfo);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    application.applicationIconBadgeNumber = 0;
}
@end
