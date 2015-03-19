//
//  TopView.h
//  交易辅助流程demo
//
//  Created by 汪洋 on 15/3/16.
//  Copyright (c) 2015年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView
@property(nonatomic,strong)UILabel *firstLabel;
@property(nonatomic,strong)UILabel *secondLabel;
@property(nonatomic,strong)UIView *shadowView;
-(id)initWithFrame:(CGRect)frame firstStr:(NSString *)firstStr secondStr:(NSString *)secondStr colorArr:(NSArray *)colorArr;
@end
