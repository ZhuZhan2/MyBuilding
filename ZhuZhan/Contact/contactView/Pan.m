//
//  Pan.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "Pan.h"

@implementation Pan

@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView  *tempImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 240)];
        tempImageView.image = [UIImage imageNamed:@"首页_16.png"];
        tempImageView.userInteractionEnabled = YES;
        [self addSubview:tempImageView];
        
        UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        visitBtn.frame = CGRectMake(40, 200, 70, 25);
        [visitBtn setBackgroundImage:[UIImage imageNamed:@"visit"] forState:UIControlStateNormal];
        [visitBtn addTarget:self action:@selector(visitUserDetail:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageView addSubview:visitBtn];
        
        UIButton *concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        concernBtn.frame = CGRectMake(150, 200, 70, 25);
        [concernBtn setBackgroundImage:[UIImage imageNamed:@"concern"] forState:UIControlStateNormal];
        [concernBtn addTarget:self action:@selector(concernUser:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageView addSubview:concernBtn];

    }
    return self;
}


-(void)visitUserDetail:(UIButton *)buton
{
    NSLog(@"访问个人详情");
    [delegate goToDetail];
}

- (void)concernUser:(UIButton *)button
{
    NSLog(@"关注好友");
    [delegate gotoConcern];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
