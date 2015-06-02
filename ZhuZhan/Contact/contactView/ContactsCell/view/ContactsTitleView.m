//
//  ContactsTitleView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/2.
//
//

#import "ContactsTitleView.h"
#import "RKViewFactory.h"
@implementation ContactsTitleView
+ (CGFloat)titleViewHeight{
    return 40;
}

+ (ContactsTitleView *)titleView{
    return [[ContactsTitleView alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, [ContactsTitleView titleViewHeight]);
        [self addSubview:self.userImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.actionNameLabel];
        [self addSubview:self.actionTimeLabel];
    }
    return self;
}

- (void)setImageUrl:(NSString*)imageUrl title:(NSString*)title actionName:(NSString*)actionName actionTime:(NSString*)actionTime{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[GetImagePath getImagePath:@"默认图_人脉_卡片头像"]];
    self.titleLabel.text = title;
    self.actionNameLabel.text = actionName;
    self.actionTimeLabel.text = actionTime;
    
    [RKViewFactory autoLabel:self.actionNameLabel];
    
    
    CGRect frame = self.userImageView.frame;
    frame.origin = CGPointMake(10, 0);
    self.userImageView.frame = frame;
    
    frame = self.titleLabel.frame;
    frame.origin = CGPointMake(60, 2);
    self.titleLabel.frame = frame;
    
    frame = self.actionNameLabel.frame;
    frame.origin = CGPointMake(60, 22);
    self.actionNameLabel.frame = frame;
    
    frame = self.actionTimeLabel.frame;
    frame.origin = CGPointMake(CGRectGetMaxX(self.actionNameLabel.frame)+5, 22);
    self.actionTimeLabel.frame = frame;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _userImageView.layer.cornerRadius = 20;
        _userImageView.layer.masksToBounds = YES;
        
        _userImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userImageClicked)];
        [_userImageView addGestureRecognizer:tap];
    }
    return _userImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)actionNameLabel{
    if (!_actionNameLabel) {
        _actionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        _actionNameLabel.textColor = BlueColor;
        _actionNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _actionNameLabel;
}

- (UILabel *)actionTimeLabel{
    if (!_actionTimeLabel) {
        _actionTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 15)];
        _actionTimeLabel.textColor = AllNoDataColor;
        _actionTimeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _actionTimeLabel;
}

- (void)userImageClicked{
    if ([self.delegate respondsToSelector:@selector(titleViewUserImageClicked)]) {
        [self.delegate titleViewUserImageClicked];
    }
}
@end
