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
#import "ManyCommentsView.h"
@interface ContactsActiveCell ()
//头顶上的用户信息及评论
@property (nonatomic, strong)ContactsActiveTitleView* titleView;

//动态内容
@property (nonatomic, strong)UILabel* contentLabel;

//动态图片
@property (nonatomic, strong)UIImageView* mainImageView;

//评论视图
@property (nonatomic, strong)ManyCommentsView* commentView;
@end

#define kCommentContentWidth 300
#define kCommentContentMaxHeight 55
#define kCommentContentFont [UIFont systemFontOfSize:15]

@implementation ContactsActiveCell
@synthesize model = _model;

+ (CGFloat)carculateCellHeightWithModel:(ContactsActiveCellModel *)cellModel{
    CGFloat height = 0;
    
    height += [ContactsActiveTitleView titleViewHeight]+20;
    
    height += [RKViewFactory autoLabelWithMaxWidth:kCommentContentWidth maxHeight:kCommentContentMaxHeight font:kCommentContentFont content:cellModel.content]+10;
    
    if (![cellModel.mainImageUrl isEqualToString:@""]) {
        height += 160+10;
    }
    
    height += [ManyCommentsView carculateHeightWithCommentArr:cellModel.commentArr];

    return height;
}

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
    [self.titleView setImageUrl:model.userImageUrl title:model.title actionTime:model.actionTime];

    self.contentLabel.text = model.content;
    [RKViewFactory autoLabel:self.contentLabel maxWidth:kCommentContentWidth maxHeight:kCommentContentMaxHeight];
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageUrl]];
    
    [self.commentView setCommentNumber:2 commentArr:model.commentArr];
    
    CGFloat height = 0;
    
    CGRect frame = self.titleView.frame;
    frame.origin.y = 10;
    self.titleView.frame = frame;
    height += CGRectGetHeight(self.titleView.frame)+10+10;
    
    frame = self.contentLabel.frame;
    frame.origin.y = height;
    frame.origin.x = 10;
    self.contentLabel.frame = frame;
    height += CGRectGetHeight(self.contentLabel.frame)+10;
    
    if (![model.mainImageUrl isEqualToString:@""]) {
        self.mainImageView.hidden = NO;
        frame = self.mainImageView.frame;
        frame.origin.y = height;
        self.mainImageView.frame = frame;
        height += CGRectGetHeight(self.mainImageView.frame)+10;
    }else{
        self.mainImageView.hidden = YES;
    }
    
    frame = self.commentView.frame;
    frame.origin.y = height;
    self.commentView.frame = frame;
    height += CGRectGetHeight(self.commentView.frame);
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
        _contentLabel.backgroundColor = [UIColor greenColor];
        _contentLabel.font = kCommentContentFont;
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    }
    return _mainImageView;
}

- (ManyCommentsView *)commentView{
    if (!_commentView) {
        _commentView = [ManyCommentsView manyCommentsView];
        _commentView.backgroundColor = [UIColor grayColor];
    }
    return _commentView;
}
@end
