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
        
//        tempImageView.layer.cornerRadius = 10;//设置那个圆角的有多圆
//        tempImageView.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
        
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

    [delegate goToDetail];
}

- (void)concernUser:(UIButton *)button
{

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
