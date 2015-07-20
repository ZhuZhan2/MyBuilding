//
//  XHPathConver.h
//  XHPathCover
//
//  Created by 曾 宪华 on 14-2-7.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"
// user info key for Dictionary
extern NSString *const XHUserNameKey;
extern NSString *const XHBirthdayKey;
extern NSString *const XHTitkeKey;
@protocol XHPathCoverDelegate <NSObject>

-(void)gotoMyCenter;

@end

@interface XHPathCover : UIView
@property (nonatomic, weak) id<XHPathCoverDelegate>delegate;
// parallax background
@property (nonatomic, strong) UIImageView *bannerImageView;
@property(nonatomic,strong)NSString* bannerPlaceholderImageName;
@property (nonatomic, strong) UIImageView *bannerImageViewWithImageEffects;

// user info
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *birthdayLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) GradientView *footView;


//scrollView call back
@property (nonatomic) BOOL touching;
@property (nonatomic) CGFloat offsetY;

// parallax background origin Y for parallaxHeight
@property (nonatomic, assign) CGFloat parallaxHeight; // default is 170， this height was not self heigth.

@property (nonatomic, assign) BOOL isZoomingEffect; // default is NO， if isZoomingEffect is YES, will be dissmiss parallax effect
@property (nonatomic, assign) BOOL isLightEffect; // default is YES
@property (nonatomic, assign) CGFloat lightEffectPadding; // default is 80
@property (nonatomic, assign) CGFloat lightEffectAlpha; // default is 1.12 (between 1 - 2)

@property (nonatomic, copy) void(^handleRefreshEvent)(void);

// stop Refresh
- (void)stopRefresh;

// background image
//- (void)setBackgroundImage:(UIImage *)backgroundImage;
// custom set url for subClass， There is not work
- (void)setBackgroundImageUrlString:(NSString *)backgroundImageUrlString;

// avatar image
//- (void)setAvatarImage:(UIImage *)avatarImage;
// custom set url for subClass， There is not work
//- (void)setAvatarUrlString:(NSString *)avatarUrlString;

-(void)setHeadImageUrl:(NSString *)imageUrl;
-(void)addImageHead:(UIImage *)img;
-(void)setHeadImageFrame:(CGRect)newFrame;
//删除点
-(void)hidewaterDropRefresh;
//设置头像位置
//-(void)setHeadFrame:(CGRect)newFrame;
//设置头像点击时间
-(void)setHeadTaget;
//设置名字位置
-(void)setNameFrame:(CGRect)newFrame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;
-(void)setBirthdayFrame:(CGRect)newFrame font:(UIFont *)font;
//设置黑色背景位置
-(void)setFootViewFrame:(CGRect)newFrame;

// set info, Example : NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:@"Jack", @"userName", @"1990-10-19", @"birthday", nil];
- (void)setInfo:(NSDictionary *)info;

//设置button的位置
- (void)setButton:(UIButton *)button WithFrame:(CGRect)frame WithBackgroundImage:(UIImage *)image AddTarget:(id)target WithAction:(SEL)selector WithTitle:(NSString *)title;

- (id)initWithFrame:(CGRect)frame bannerPlaceholderImageName:(NSString*)backgroundImageName;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView isMyDynamicList:(BOOL)isMyDynamicList;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@property(nonatomic)BOOL isMyDynamicList;
@end
