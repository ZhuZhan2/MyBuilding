//
//  LandInfo.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-21.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIndexPath.h"
#import "ShowPageDelegate.h"

@interface LandInfo : UIView
//土地规划/拍卖,项目立项
@property(nonatomic,strong)UIView* firstView;//土地信息landInfo第一部分,土地规划/拍卖
@property(nonatomic,strong)UIView* secondView;//土地信息landInfo第二部分,项目立项
+(LandInfo*)getLandInfoWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part;
@end
