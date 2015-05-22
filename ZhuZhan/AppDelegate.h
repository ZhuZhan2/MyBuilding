//
//  AppDelegate.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "SocketManage.h"
#import "GCDAsyncSocket.h"
#define KAPI_KEY @"25d987b4f4f915bf02aaecde055db243"//face++
#define KAPI_SECRET @"S_rg7gvJpWXO4OJS4m7yaQt_VtTwszC7"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)SocketManage *socket;
@property (nonatomic,strong)CLLocationManager *locationManager;
+ (AppDelegate *)instance;
@end
