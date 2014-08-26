//
//  DecorationProject.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIndexPath.h"
#import "ShowPageDelegate.h"

@interface DecorationProject : UIView
//装修阶段
@property(nonatomic,strong)UIView* firstView;//装修DecorationProject第一部分,装修阶段
+(DecorationProject*)getDecorationProjectWithDelegate:(id<ShowPageDelegate>)delegate part:(NSInteger)part;
@end
