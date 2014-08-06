//
//  BaseViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController{
    UIButton*  rightButton;
}
@property(nonatomic,assign)UIView *contentView;
@property(nonatomic,assign)UIView *topView;
//返回按钮
-(void)addBackButton;
//中间title
-(void)addtittle:(NSString *)title;
//右边按钮，定义大小，可以是文字或者图片，没有就传nil
- (void)addRightButton:(CGRect)frame title:(NSString*)title iamge:(UIImage*)image;
//设置背景颜色
-(void)setBgColor:(UIColor *)color;
//移除右按钮
-(void)removeRightBtn;
@end
