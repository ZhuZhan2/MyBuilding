//
//  ContactsActiveTitleView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "ContactsActiveTitleView.h"
@implementation ContactsActiveTitleView
+ (ContactsActiveTitleView *)titleView{
    return [[ContactsActiveTitleView alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor grayColor];
        self.frame = CGRectMake(0, 0, 295, 40);
        [self addSubview:self.userImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.assistBtn];
        [self addSubview:self.actionTimeLabel];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl title:(NSString *)title actionTime:(NSString *)actionTime{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.titleLabel.text = title;
    self.actionTimeLabel.text = actionTime;
    
    CGRect frame = self.titleLabel.frame;
    frame.origin = CGPointMake(60, 18);
    self.titleLabel.frame = frame;
    
    frame = self.actionTimeLabel.frame;
    frame.origin = CGPointMake(60, 38);
    self.actionTimeLabel.frame = frame;
    
    frame = self.assistBtn.frame;
    frame.origin = CGPointMake(225, 15);
    self.assistBtn.frame = frame;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _userImageView.backgroundColor = [UIColor greenColor];
    }
    return _userImageView;
}

- (UIButton *)assistBtn{
    if (!_assistBtn) {
        _assistBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 27)];
        [_assistBtn setImage:[GetImagePath getImagePath:@"人脉_写评论ios"] forState:UIControlStateNormal];
    }
    return _assistBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _titleLabel;
}


- (UILabel *)actionTimeLabel{
    if (!_actionTimeLabel) {
        _actionTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 15)];
        _actionTimeLabel.textColor = AllNoDataColor;
    }
    return _actionTimeLabel;
}
@end
