//
//  RKShadowView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import <UIKit/UIKit.h>

@interface RKShadowView : UIView
+ (UIView *)seperatorLineShadowViewWithHeight:(CGFloat)height;//阴影

+ (UIView *)seperatorLineWithHeight:(CGFloat)height top:(CGFloat)top;//seperatorLine指定高度

/**
 *  有两根细线的分割线
 *
 *  @param height 整体高度
 *  @param top    第一个sepe离上方的高度
 *
 *  @return 整体分割线
 */
+ (UIView *)seperatorLineDoubleWithHeight:(CGFloat)height top:(CGFloat)top;

+ (UIView *)seperatorLine;//height=1px

+ (UIView *)seperatorLineInThemeView;//上导航阴影

+ (UIView*)seperatorLineInViews:(NSArray*)views;//把阴影加入views之间
@end
