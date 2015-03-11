//
//  BlackView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "BlackView.h"

@implementation BlackView
+(BlackView*)blackView{
    BlackView* blackView=[[BlackView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    blackView.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:.5];
    [blackView addTarget:blackView action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    return blackView;
}

-(void)finish{
    [self removeFromSuperview];
}
@end
