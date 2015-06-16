//
//  MarketListTitleView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import "MarketListTitleView.h"
#import "RKViewFactory.h"
@implementation MarketListTitleView
+ (CGFloat)titleViewHeight{
    return 60;
}

- (id)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, [MarketListTitleView titleViewHeight]);
        [self addSubview:self.headBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.cutLine1];
        [self addSubview:self.cutLine2];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setImageUrl:(NSString*)imageUrl title:(NSString *)title type:(NSString *)type time:(NSString *)time needRound:(BOOL)needRound{
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:needRound?@"默认图_用户头像_卡片头像":@"默认图_公司头像_卡片头像"]];
    self.headBtn.layer.cornerRadius = needRound?20:3;
    self.titleLabel.text = title;
    self.typeLabel.text = type;
    self.timeLabel.text = time;
    
    [RKViewFactory autoLabel:self.typeLabel];
    
    CGRect frame = self.headBtn.frame;
    frame.origin = CGPointMake(10, 10);
    self.headBtn.frame = frame;
    
    frame = self.titleLabel.frame;
    frame.origin = CGPointMake(60, 12);
    self.titleLabel.frame = frame;
    
    frame = self.typeLabel.frame;
    frame.origin = CGPointMake(60, 32);
    self.typeLabel.frame = frame;
    
    frame = self.timeLabel.frame;
    frame.origin = CGPointMake(CGRectGetMaxX(self.typeLabel.frame)+5, 32);
    self.timeLabel.frame = frame;
}

- (UIButton *)headBtn{
    if (!_headBtn) {
        _headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _headBtn.layer.masksToBounds = YES;
    }
    return _headBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 20)];
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
        _typeLabel.font = [UIFont systemFontOfSize:15];
        _typeLabel.textColor = BlueColor;
    }
    return _typeLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 15)];
        _timeLabel.textColor = AllNoDataColor;
        _timeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _timeLabel;
}

-(UIImageView *)cutLine2{
    if(!_cutLine2){
        _cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, [MarketListTitleView titleViewHeight]-1, 320, 1)];
        _cutLine2.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine2;
}

-(UIImageView *)cutLine1{
    if(!_cutLine1){
        _cutLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine1.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine1;
}
@end
