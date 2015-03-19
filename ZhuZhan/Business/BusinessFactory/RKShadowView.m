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

+(UIView *)seperatorLineWithHeight:(CGFloat)height{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    view.backgroundColor=AllSeperatorLineColor;
    return view;
}

+(UIView *)seperatorLineInThemeView{
    UIImageView* view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    view.image=[GetImagePath getImagePath:AllThemeViewShadowImageName];
    return view;
}
@end
