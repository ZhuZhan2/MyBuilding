//
//  toolBarView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-19.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "toolBarView.h"

@implementation toolBarView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addContent];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)addContent{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)];
    [bgView setBackgroundColor:[UIColor colorWithRed:(166/255.0)  green:(166/255.0)  blue:(166/255.0)  alpha:1.0]];
    [self addSubview:bgView];
    
    UIButton *yuingBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    yuingBtn.frame = CGRectMake(40, 6, 28, 28);
    yuingBtn.tag = 0;
    [yuingBtn setBackgroundImage:[UIImage imageNamed:@"搜索_03.png"] forState:UIControlStateNormal];
    [yuingBtn addTarget:self action:@selector(gotoViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:yuingBtn];
    
    UIImageView *lineImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(108, 7, 1, 27.5)];
    [lineImage1 setImage:[UIImage imageNamed:@"搜索_10.png"]];
    [self addSubview:lineImage1];
    
    UIButton *advancedBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    advancedBtn.frame = CGRectMake(148, 6, 28, 28);
    advancedBtn.tag = 1;
    [advancedBtn setBackgroundImage:[UIImage imageNamed:@"搜索_05.png"] forState:UIControlStateNormal];
    [advancedBtn addTarget:self action:@selector(gotoViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:advancedBtn];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(216, 7, 1, 27.5)];
    [lineImage2 setImage:[UIImage imageNamed:@"搜索_10.png"]];
    [self addSubview:lineImage2];
    
    UIButton *mapBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtn.frame = CGRectMake(256, 6, 28, 28);
    mapBtn.tag = 2;
    [mapBtn setBackgroundImage:[UIImage imageNamed:@"搜索_07.png"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(gotoViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mapBtn];
}

-(void)gotoViewClick:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(gotoView:)]){
        [delegate gotoView:button.tag];
    }
}
@end
