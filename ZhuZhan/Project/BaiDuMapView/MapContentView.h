//
//  MapContentView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "projectModel.h"
@interface MapContentView : UIView
- (id)initWithFrame:(CGRect)frame model:(projectModel *)model number:(NSString *)number;
@end
