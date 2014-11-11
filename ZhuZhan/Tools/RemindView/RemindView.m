//
//  RemindView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/11/11.
//
//

#import "RemindView.h"

@implementation RemindView
+(void)remindViewWithContent:(NSString*)content superView:(UIView*)superView center:(CGPoint)center{
    RemindView* remindView=[[RemindView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    remindView.text=content;
    remindView.font=[UIFont systemFontOfSize:15];
    remindView.textColor=RGBCOLOR(248, 154, 28);
    remindView.center=center;
    remindView.textAlignment=NSTextAlignmentCenter;
    [superView addSubview:remindView];
    remindView.backgroundColor=RGBCOLOR(255, 255, 203);
    remindView.alpha=0.2;
    [UIView animateWithDuration:3 animations:^{
        remindView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}
@end
