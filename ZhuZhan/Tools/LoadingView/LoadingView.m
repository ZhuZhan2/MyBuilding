//
//  LoadingView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/6.
//
//

#import "LoadingView.h"

@implementation LoadingView

+(LoadingView *)loadingViewWithFrame:(CGRect)frame superView:(UIView *)superView{
    return [[LoadingView alloc] initWithFrame:frame superView:superView];
}


-(instancetype)initWithFrame:(CGRect)frame superView:(UIView*)superView{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"加载中" withExtension:@"gif"];
        self.gifView = [[SvGifView alloc] initWithCenter:CGPointMake(self.bounds.size.width / 2, ((superView.frame.size.height-21)/2)-50) fileURL:fileUrl];
        self.gifView.backgroundColor = [UIColor clearColor];
        self.gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:self.gifView];
        [self.gifView startGif];
        [superView addSubview:self];
    }
    return self;
}

+(void)removeLoadingView:(LoadingView *)view{
    [view.gifView stopGif];
    [view removeFromSuperview];
    view = nil;
}
@end
