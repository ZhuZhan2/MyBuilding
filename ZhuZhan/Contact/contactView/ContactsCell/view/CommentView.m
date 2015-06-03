//
//  CommentView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "CommentView.h"
#import "RKViewFactory.h"
#import "RKShadowView.h"
#define kCommentContentWidth 300
#define kCommentContentHeight 55
#define kCommentContentFont [UIFont systemFontOfSize:16]

@implementation CommentView
+ (CGFloat)carculateHeightWithContent:(NSString *)content{
    CGFloat height = [RKViewFactory autoLabelWithMaxWidth:kCommentContentWidth maxHeight:kCommentContentHeight font:kCommentContentFont content:content];
    return 50+height+10;
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

- (void)setImageUrl:(NSString *)imageUrl title:(NSString *)title actionTime:(NSString *)actionTime content:(NSString *)content needTopLine:(BOOL)needTopLine needBottomLine:(BOOL)needBottomLine needRound:(BOOL)needRound{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[GetImagePath getImagePath:needRound?@"默认图_人脉_评论头像":@"默认图_公司头像_评论头像"]];
    self.userImageView.layer.cornerRadius = needRound?15:3;
    self.titleLabel.text = title;
    self.actionTimeLabel.text = actionTime;
    self.contentLabel.text = content;
    [RKViewFactory autoLabel:self.contentLabel maxWidth:kCommentContentWidth maxHeight:kCommentContentHeight];
    
    CGRect frame = self.userImageView.frame;
    frame.origin = CGPointMake(10, 10);
    self.userImageView.frame = frame;
    
    frame = self.titleLabel.frame;
    frame.origin = CGPointMake(55, 8);
    self.titleLabel.frame = frame;
    
    frame = self.actionTimeLabel.frame;
    frame.origin = CGPointMake(55, 28);
    self.actionTimeLabel.frame = frame;
    
    frame = self.contentLabel.frame;
    frame.origin = CGPointMake(10, 50);
    self.contentLabel.frame = frame;
    
    frame = self.frame;
    frame.size.height = CGRectGetMaxY(self.contentLabel.frame)+10;
    self.frame = frame;
    
    if (needTopLine) {
        UIView* topLine = [RKShadowView seperatorLine];
        [self addSubview:topLine];
    }
    
    if (needBottomLine) {
        UIView* bottomLine = [RKShadowView seperatorLine];
        [self addSubview:bottomLine];
        
        frame = bottomLine.frame;
        frame.origin.y = CGRectGetHeight(self.frame)-1;
        bottomLine.frame = frame;
    }
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _userImageView.layer.masksToBounds = YES;
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
        _contentLabel.textColor = RGBCOLOR(97, 97, 97);
        _contentLabel.font = kCommentContentFont;
    }
    return _contentLabel;
}
@end
