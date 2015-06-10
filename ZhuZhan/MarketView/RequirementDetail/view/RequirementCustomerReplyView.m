//
//  RequirementCustomerReplyView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/10.
//
//

#import "RequirementCustomerReplyView.h"
#import "RKViewFactory.h"
@interface RequirementCustomerReplyView ()
@property (nonatomic, strong)UILabel* contentLabel;
@property (nonatomic, strong)UILabel* timeLabel;
@end

@implementation RequirementCustomerReplyView

- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.contentLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)setContent:(NSString *)content time:(NSString *)time{
    self.contentLabel.text = content;
    self.timeLabel.text = time;
    
    [RKViewFactory autoLabel:self.contentLabel maxWidth:CGRectGetWidth(self.contentLabel.frame)];
    CGRect frame = self.timeLabel.frame;
    frame.origin.y = CGRectGetMaxY(self.contentLabel.frame)+5;
    self.timeLabel.frame = frame;
    
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(self.timeLabel.frame)+10);
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 10, kScreenWidth-36, 0)];
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-36, 0)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}
@end
