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
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClicked)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setUserImageUrl:(NSString *)imageUrl title:(NSString *)title time:(NSString *)time needRound:(BOOL)needRuond{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[GetImagePath getImagePath:needRuond?@"默认图_需求详情_人头像126":@"默认图_需求详情_公司头像126"]];
    self.userImageView.layer.cornerRadius = needRuond?31.5:4;
    self.titleLabel.text = title;
    self.timeLabel.text = time;
    
    CGRect frame = self.userImageView.frame;
    frame.origin = CGPointMake(16, 13);
    self.userImageView.frame = frame;
    
    [RKViewFactory autoLabel:self.titleLabel maxWidth:200 maxHeight:42];
    frame = self.titleLabel.frame;
    frame.origin = CGPointMake(95, 15);
    self.titleLabel.frame = frame;
    
    frame = self.timeLabel.frame;
    frame.origin.x = CGRectGetMinX(self.titleLabel.frame);
    frame.origin.y = CGRectGetMaxY(self.titleLabel.frame)+3;
    self.timeLabel.frame = frame;
}

- (void)titleViewClicked{
    if ([self.delegate respondsToSelector:@selector(requirementDetailTitleViewClicked:)]) {
        [self.delegate requirementDetailTitleViewClicked:self];
    }
}

- (void)userImageViewClicked:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(requirementDetailTitleViewUserImageClicked:imageView:)]) {
        [self.delegate requirementDetailTitleViewUserImageClicked:self imageView:(UIImageView*)tap.view];
    }
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 63, 63)];
        _userImageView.layer.masksToBounds = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userImageViewClicked:)];
        [_userImageView addGestureRecognizer:tap];
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
