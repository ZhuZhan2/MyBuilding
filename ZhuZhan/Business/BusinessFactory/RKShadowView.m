//
//  RKShadowView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "RKShadowView.h"

@implementation RKShadowView
+(UIView *)seperatorLineShadowViewWithHeight:(CGFloat)height{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor=AllBackDeepGrayColor;
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 3)];
    imageView.image=[GetImagePath getImagePath:AllBottomShadowImageName];
    
    [view addSubview:imageView];
    return view;
}

+(UIView *)seperatorLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    view.backgroundColor=AllSeperatorLineColor;
    return view;
}

+ (UIView *)seperatorLineWithHeight:(CGFloat)height top:(CGFloat)top{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor = AllBackLightGratColor;
    
    UIView* seperatorLine = [self seperatorLine];
    CGRect frame = seperatorLine.frame;
    frame.origin.y = top;
    seperatorLine.frame = frame;
    [view addSubview:seperatorLine];
    
    return view;
}

+ (UIView *)seperatorLineDoubleWithHeight:(CGFloat)height top:(CGFloat)top{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor = AllBackLightGratColor;
    
    UIView* seperatorLine = [self seperatorLine];
    CGRect frame = seperatorLine.frame;
    frame.origin.y = top;
    seperatorLine.frame = frame;
    [view addSubview:seperatorLine];
    
    UIView* seperatorLine1 = [self seperatorLine];
    frame = seperatorLine1.frame;
    frame.origin.y = CGRectGetHeight(view.frame)-1;
    seperatorLine1.frame = frame;
    [view addSubview:seperatorLine1];
    return view;
}

+(UIView *)seperatorLineInThemeView{
    UIImageView* view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    view.image=[GetImagePath getImagePath:AllThemeViewShadowImageName];
    return view;
}

+ (UIView*)seperatorLineInViews:(NSArray *)views{
    UIView* backView = [[UIView alloc] init];
    __block CGFloat height = 0;
    [views enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
        UIView* seperatorLine = [self seperatorLine];
        CGRect frame = seperatorLine.frame;
        frame.origin.y = height;
        seperatorLine.frame = frame;
        
        [backView addSubview:seperatorLine];
        height += CGRectGetHeight(seperatorLine.frame);
        
        frame  = view.frame;
        frame.origin.y = height;
        view.frame = frame;
        
        [backView addSubview:view];
        height += CGRectGetHeight(view.frame);
    }];
    UIView* seperatorLine = [self seperatorLine];
    CGRect frame = seperatorLine.frame;
    frame.origin.y = height;
    seperatorLine.frame = frame;
    
    [backView addSubview:seperatorLine];
    height += CGRectGetHeight(seperatorLine.frame);
    
    backView.frame = CGRectMake(0, 0, kScreenWidth, height);
    return backView;
}
@end
