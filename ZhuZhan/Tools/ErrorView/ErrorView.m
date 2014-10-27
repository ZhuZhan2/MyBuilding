//
//  ErrorView.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-11.
//
//

#import "ErrorView.h"
@implementation ErrorView

+(ErrorView*)errorViewWithFrame:(CGRect)frame superView:(UIView*)superView target:(id)target action:(SEL)action{
    return [[ErrorView alloc]initWithFrame:frame superView:superView target:target action:action];
}

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView*)superView target:(id)target action:(SEL)action{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(84, 100, 152, 102)];
        [imageView setImage:[GetImagePath getImagePath:@"数据加载失败_03a"]];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 252, 320, 40)];
        label.text = @"网络出错啦";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = RGBCOLOR(33, 33, 33);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 292, 320, 40)];
        label2.text = @"请检查您的手机是否联网，并重新加载";
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = RGBCOLOR(173, 173, 173);
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
        
        UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setFrame:CGRectMake(103, 332, 114, 32)];
        [reloadBtn setBackgroundImage:[GetImagePath getImagePath:@"数据加载失败_07a"] forState:UIControlStateNormal];
        [reloadBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reloadBtn];
        
        [superView addSubview:self];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(84, 100, 152, 102)];
        [imageView setImage:[GetImagePath getImagePath:@"数据加载失败_03a"]];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 252, 320, 40)];
        label.text = @"网络出错啦";
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = RGBCOLOR(33, 33, 33);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 292, 320, 40)];
        label2.text = @"请检查您的手机是否联网，并重新加载";
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = RGBCOLOR(173, 173, 173);
        label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label2];
        
        UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadBtn setFrame:CGRectMake(103, 332, 114, 32)];
        [reloadBtn setBackgroundImage:[GetImagePath getImagePath:@"数据加载失败_07a"] forState:UIControlStateNormal];
        [reloadBtn addTarget:self action:@selector(reloadBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reloadBtn];
    }
    return self;
}

-(void)reloadBtnClick{
    if([self.delegate respondsToSelector:@selector(reloadView)]){
        [self.delegate reloadView];
    }
}
@end
