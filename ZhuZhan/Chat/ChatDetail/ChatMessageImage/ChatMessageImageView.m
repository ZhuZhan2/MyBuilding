//
//  ChatMessageImageView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/18.
//
//

#import "ChatMessageImageView.h"
@interface ChatMessageImageView()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end

@implementation ChatMessageImageView

- (instancetype)initWithFrame:(CGRect)frame isSelf:(BOOL)isSelf{
    self = [super initWithFrame:frame];
    if (self) {
        self.isSelf = isSelf;
        [self setup];
    }
    return self;
}

- (void)setup
{
    _maskLayer = [CAShapeLayer layer];
    //_maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5].CGPath;
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    if(self.isSelf){
        _maskLayer.contents = (id)[GetImagePath getImagePath:@"自己会话框最小"].CGImage;
    }else{
        _maskLayer.contents = (id)[GetImagePath getImagePath:@"他人会话框最小"].CGImage;
    }
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
    
}

- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}
@end
