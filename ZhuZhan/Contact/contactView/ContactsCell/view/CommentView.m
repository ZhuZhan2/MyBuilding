//
//  CommentView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "CommentView.h"
#import "RKViewFactory.h"

#define kCommentContentWidth 300
#define kCommentContentHeight 55
#define kCommentContentFont [UIFont systemFontOfSize:14]

@implementation CommentView
+ (CGFloat)carculateHeightWithContent:(NSString *)content{
    CGFloat height = [RKViewFactory autoLabelWithMaxWidth:kCommentContentWidth maxHeight:kCommentContentHeight font:kCommentContentFont content:content];
    return 46+height+10;
}

+ (CommentView *)commentView{
    return [[CommentView alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 0);
        [self addSubview:self.userImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.actionTimeLabel];
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl title:(NSString *)title actionTime:(NSString *)actionTime content:(NSString *)content{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.titleLabel.text = title;
    self.actionTimeLabel.text = actionTime;
    self.contentLabel.text = content;
    [RKViewFactory autoLabel:self.contentLabel maxWidth:kCommentContentWidth maxHeight:kCommentContentHeight];
    
    CGRect frame = self.userImageView.frame;
    frame.origin = CGPointMake(10, 0);
    self.userImageView.frame = frame;
    
    frame = self.titleLabel.frame;
    frame.origin = CGPointMake(60, 2);
    self.titleLabel.frame = frame;
    
    frame = self.actionTimeLabel.frame;
    frame.origin = CGPointMake(60, 22);
    self.actionTimeLabel.frame = frame;
    
    frame = self.contentLabel.frame;
    frame.origin = CGPointMake(10, 46);
    self.contentLabel.frame = frame;
    
    frame = self.frame;
    frame.size.height = CGRectGetMaxY(self.contentLabel.frame)+10;
    self.frame = frame;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _userImageView.layer.cornerRadius = 20;
        _userImageView.layer.masksToBounds = YES;
        _userImageView.backgroundColor = [UIColor greenColor];
    }
    return _userImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}


- (UILabel *)actionTimeLabel{
    if (!_actionTimeLabel) {
        _actionTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 15)];
        _actionTimeLabel.textColor = AllNoDataColor;
        _actionTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _actionTimeLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kCommentContentWidth, 0)];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
        _contentLabel.font = kCommentContentFont;
        _contentLabel.backgroundColor = [UIColor yellowColor];
    }
    return _contentLabel;
}
@end
