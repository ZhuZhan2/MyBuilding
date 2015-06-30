//
//  ChatSendImageView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/29.
//
//

#import "ChatSendImageView.h"
#import "RKShadowView.h"
@interface ChatSendImageView ()
@property (nonatomic, strong)UIView* backView;
@property (nonatomic, strong)UIButton* cancelBtn;
@property (nonatomic, strong)UIButton* sureBtn;
@end

@implementation ChatSendImageView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:.5];
        [self addSubview:self.backView];
        [self.backView addSubview:self.mainImageView];
        [self.backView addSubview:self.cancelBtn];
        [self.backView addSubview:self.sureBtn];
        
        self.backView.center = CGPointMake(CGRectGetWidth(self.frame)*.5, CGRectGetHeight(self.frame)*.5);

        CGFloat width = CGRectGetWidth(self.backView.frame);
        CGFloat height = CGRectGetHeight(self.backView.frame);
        self.mainImageView.center = CGPointMake(width*.5, CGRectGetHeight(self.mainImageView.frame)*.5+15);
        self.cancelBtn.frame = CGRectMake(0, height-44, width*.5, 44);
        self.sureBtn.frame = CGRectMake(width*.5, height-44, width*.5, 44);
        
        UIView* sepe1 = [RKShadowView seperatorLine];
        CGRect frame = sepe1.frame;
        frame.origin.y = height-45;
        sepe1.frame = frame;
        [self.backView addSubview:sepe1];
        
        UIView* sepe2 = [RKShadowView seperatorLine];
        frame = sepe2.frame;
        frame.size = CGSizeMake(1, 44);
        frame.origin = CGPointMake(width*.5-.5, height-44);
        sepe2.frame = frame;
        [self.backView addSubview:sepe2];
    }
    return self;
}

- (void)cancelBtnClicked{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)sureBtnCilcked{
    if ([self.delegate respondsToSelector:@selector(chatSendImage:)]) {
        [self.delegate chatSendImage:self.mainImageView.image];
    }
    [self cancelBtnClicked];
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 265, 245)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 4;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 230, 170)];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mainImageView.layer.borderWidth = 1;
        _mainImageView.layer.borderColor = AllSeperatorLineColor.CGColor;
    }
    return _mainImageView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelBtn setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sureBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_sureBtn setTitleColor:AllGreenColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnCilcked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
@end
