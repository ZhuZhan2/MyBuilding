//
//  ContactsActiveCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "ContactsActiveCell.h"
#import "ContactsActiveTitleView.h"
#import "RKViewFactory.h"
@interface ContactsActiveCell ()
//头顶上的用户信息及评论
@property (nonatomic, strong)ContactsActiveTitleView* titleView;

//动态内容
@property (nonatomic, strong)UILabel* contentLabel;

//动态图片
@property (nonatomic, strong)UIImageView* mainImageView;

//评论视图
@property (nonatomic, strong)UIView* commentView;
@end

@implementation ContactsActiveCell
@synthesize model = _model;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleView];
        [self addSubview:self.contentLabel];
        [self addSubview:self.mainImageView];
        [self addSubview:self.commentView];
    }
    return self;
}

- (void)setModel:(ContactsActiveCellModel *)model{
    _model = model;
    self.contentLabel.text = model.content;
    [RKViewFactory autoLabel:self.contentLabel maxWidth:300];
    
    self.commentView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    
    CGRect frame = self.contentLabel.frame;
    frame.origin.y = CGRectGetMaxY(self.titleView.frame);
    frame.origin.x = 10;
    self.contentLabel.frame = frame;
    
    frame = self.mainImageView.frame;
    frame.origin.y = CGRectGetMaxY(self.contentLabel.frame);
    self.mainImageView.frame = frame;
    
    frame = self.commentView.frame;
    frame.origin.y = CGRectGetMaxY(self.mainImageView.frame);
    self.mainImageView.frame = frame;
}

- (ContactsActiveTitleView *)titleView{
    if (!_titleView) {
        _titleView = [ContactsActiveTitleView titleView];
    }
    return _titleView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _contentLabel;
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    }
    return _mainImageView;
}

- (UIView *)commentView{
    if (!_commentView) {
        _commentView = [[UIView alloc] initWithFrame:CGRectZero];
        _commentView.backgroundColor = [UIColor grayColor];
    }
    return _commentView;
}
@end
