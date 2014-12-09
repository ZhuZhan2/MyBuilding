//
//  FirstAnimationView.h
//  AnimationDemo
//
//  Created by 孙元侃 on 14/12/8.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationDelegate.h"
@interface FirstAnimationView : UIView
@property(nonatomic,weak)id<AnimationDelegate>delegate;
@end
