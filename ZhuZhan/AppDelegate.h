//
//  AppDelegate.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#define KAPI_KEY @"cc319a1603439ff53c1a9856a0276a58"
#define KAPI_SECRET @"nqC5mTxBhRkyF0k1Mq2J7YR-0lu0-Bgj"


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)instance;
@end
