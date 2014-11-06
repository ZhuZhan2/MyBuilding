//
//  LoadingView.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/6.
//
//

#import <UIKit/UIKit.h>
#import "SvGifView.h"
@interface LoadingView : UIView
@property(nonatomic,strong)SvGifView *gifView;
+(LoadingView*)loadingViewWithFrame:(CGRect)frame superView:(UIView*)superView;
+(void)removeLoadingView:(LoadingView *)view;
@end
