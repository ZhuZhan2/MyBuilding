//
//  AppDelegate.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KAPI_KEY @"7057bbc57c1f842fa8f8355cab2941c3"
#define KAPI_SECRET @"R-6gNM2XsmWENxtDQjm87jm_JzWNH74X"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)instance;
@end
