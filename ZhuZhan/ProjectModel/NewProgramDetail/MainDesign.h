//
//  MainDesign.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIndexPath.h"
#import "ShowPageDelegate.h"

@interface MainDesign : UIView
//地勘阶段,主体设计阶段,出图阶段
@property(nonatomic,strong)UIView* firstView;//主体设计mainDesign第一部分,地勘阶段
@property(nonatomic,strong)UIView* secondView;//主体设计mainDesign第二部分,主体设计阶段
@property(nonatomic,strong)UIView* thirdView;//主体设计mainDesign第三部分,出图阶段
+(MainDesign*)getMainDesignWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part;
@end
