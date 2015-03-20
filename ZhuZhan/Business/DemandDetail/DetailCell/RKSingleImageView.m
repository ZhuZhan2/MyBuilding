//
//  RKSingleImageView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "RKSingleImageView.h"
@implementation RKSingleImageView
+(RKSingleImageView *)singleImageViewWithImageSize:(CGSize)size{
    RKSingleImageView* view=[[RKSingleImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor=[UIColor redColor];
    return view;
}

-(CGPoint)editCenter{
    CGFloat x=CGRectGetWidth(self.frame);
    CGFloat y=0;
    return CGPointMake(x, y);
}
@end
