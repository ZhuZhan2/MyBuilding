//
//  RequirementDetailTitleView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementDetailTitleView.h"
#import "RKViewFactory.h"
@interface RequirementDetailTitleView ()
@property (nonatomic, strong)UIImageView* userImageView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* timeLabel;
@end

@implementation RequirementDetailTitleView
- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)]) {
        [self addSubview:self.userImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)setUserImageUrl:(NSString *)imageUrl title:(NSString *)title time:(NSString *)time needRound:(BOOL)needRuond{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[GetImagePath getImagePath:needRuond?@"默认图_需求详情_人头像126":@"默认图_需求详情_公司头像126"]];
    self.userImageView.layer.cornerRadius = needRuond?31.5:4;
    self.titleLabel.text = title;
    self.timeLabel.text = title;
    
    CGRect frame = self.userImageView.frame;
    frame.origin = CGPointMake(16, 13);
    self.userImageView.frame = frame;
    
    [RKViewFactory autoLabel:self.titleLabel maxWidth:200 maxHeight:40];
    frame = self.titleLabel.frame;
    frame.origin = CGPointMake(95, 20);
    self.titleLabel.frame = frame;
    
    frame = self.timeLabel.frame;
    frame.origin.x = CGRectGetMinX(self.titleLabel.frame);
    frame.origin.y = CGRectGetMaxY(self.titleLabel.frame)+5;
    self.timeLabel.frame = frame;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 63, 63)];
        _userImageView.layer.masksToBounds = YES;
    }
    return _userImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}
@end
