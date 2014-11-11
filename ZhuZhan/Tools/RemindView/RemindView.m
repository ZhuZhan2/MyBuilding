//
//  RemindView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/11/11.
//
//

#import "RemindView.h"

@implementation RemindView
+(void)remindViewWithContent:(NSString*)content superView:(UIView*)superView centerY:(CGFloat)centerY{
    RemindView* remindView=[[RemindView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    remindView.text=content;
    remindView.font=[UIFont systemFontOfSize:14];
    remindView.textColor=RGBCOLOR(248, 154, 28);
    remindView.center=CGPointMake(160, centerY);
    remindView.textAlignment=NSTextAlignmentCenter;
    [superView addSubview:remindView];
    remindView.backgroundColor=RGBCOLOR(255, 255, 203);
    remindView.alpha=0;
    [UIView animateWithDuration:1 animations:^{
        remindView.alpha=1;
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:5 target:remindView selector:@selector(endAnimation) userInfo:nil repeats:NO];
    }];
}

-(void)endAnimation{
    [UIView animateWithDuration:1.5 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
