//
//  FirstAnimationView.m
//  AnimationDemo
//
//  Created by 孙元侃 on 14/12/8.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "FirstAnimationView.h"
#import "GetImagePath.h"
@interface FirstAnimationView ()
@property(nonatomic,strong)UIImageView *image;
@end

@implementation FirstAnimationView
static int j ;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.image = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:self.image];
        j=1;
        [self addImage:j];
    }
    return self;
}

-(void)addImage:(int)index{
    if(index <=64){
        if(index<10){
            self.image.image = [GetImagePath getImagePath:[NSString stringWithFormat:@"01000%d",index]];
        }else{
            self.image.image = [GetImagePath getImagePath:[NSString stringWithFormat:@"0100%d",index]];
        }
        j++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addImage:j];
        });
    }else{
        [self.delegate endAnimation];
    }
}
@end
