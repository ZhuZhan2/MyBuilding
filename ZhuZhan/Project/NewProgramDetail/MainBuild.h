//
//  MainBuild.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIndexPath.h"
#import "ShowPageDelegate.h"

@interface MainBuild : UIView
//地平阶段,桩基基坑,主体施工,消防/景观绿化
@property(nonatomic,strong)UIView* firstView;//主体施工MainBuild第一部分,地平阶段
@property(nonatomic,strong)UIView* secondView;//主体施工MainBuild第二部分,桩基基坑
@property(nonatomic,strong)UIView* thirdView;//主体施工MainBuild第三部分,主体施工
@property(nonatomic,strong)UIView* fourthView;//主体施工MainBuild第四部分,消防/景观绿化
+(MainBuild*)getMainBuildWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part;
@end
