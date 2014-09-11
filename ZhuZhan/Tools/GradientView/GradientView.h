//
//  GradientView.h
//  GradientView
//
//  Created by xun yanan on 14-6-14.
//  Copyright (c) 2014年 xun yanan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GradientView : UIView
//输入需要渐变的颜色
- (id)initWithFrame:(CGRect)frame colorArr:(NSArray *)colorArr;
@end
