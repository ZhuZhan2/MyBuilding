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
#import "RKShadowView.h"
#import "ContactsTitleView.h"

@interface ContactsActiveCell ()<ContactsActiveTitleViewDelegate,ContactsTitleViewDelegate>
//动态,头顶上的用户信息及评论
@property (nonatomic, strong)ContactsActiveTitleView* activeTitleView;

//非动态,头顶上的用户信息及评论
@property (nonatomic, strong)ContactsTitleView* titleView;

//动态内容
@property (nonatomic, strong)UILabel* contentLabel;//3行

@property (nonatomic, strong)UILabel* secondContentLabel;//2行

@property (nonatomic, strong)UILabel* thirdContentLabel;//2行


//动态图片
@property (nonatomic, strong)UIImageView* mainImageView;

//评论视图
@property (nonatomic, strong)ManyCommentsView* commentView;

@property (nonatomic, strong)UIView* topShadow;

@property (nonatomic, strong)UIView* bottomShadow;

@property (nonatomic, strong)ContactsActiveCellModel* model;
@end

#define kCommentContentWidth 300
#define kCommentContentMaxHeight 65
#define kCommentSecondContentMaxHeight 45
#define kCommentThirdContentMaxHeight 20

#define kCommentContentFont [UIFont systemFontOfSize:17.5]
#define kCommentThirdContentFont [UIFont systemFontOfSize:15]

@implementation ContactsActiveCell
@synthesize model = _model;

+ (CGFloat)carculateCellHeightWithModel:(ContactsActiveCellModel *)cellModel{
    CGFloat height = 0;
    
    height += 10;//上阴影
    
    height += [ContactsActiveTitleView titleViewHeight]+20;
    
    if (![cellModel.content isEqualToString:@""]) {
        height += [RKViewFactory autoLabelWithMaxWidth:kCommentContentWidth maxHeight:kCommentContentMaxHeight font:kCommentContentFont content:cellModel.content]+10;
    }
    
    if (![cellModel.secondContent isEqualToString:@""]) {
        height += [RKViewFactory autoLabelWithMaxWidth:kCommentContentWidth maxHeight:kCommentSecondContentMaxHeight font:kCommentContentFont content:cellModel.secondContent]+10;
    }
    
    if (![cellModel.thirdContent isEqualToString:@""]) {
        height += [RKViewFactory autoLabelWithMaxWidth:kCommentContentWidth maxHeight:kCommentThirdContentMaxHeight font:kCommentThirdContentFont content:cellModel.thirdContent]+10;
    }
    
    if (![cellModel.mainImageUrl isEqualToString:@""]) {
        height += 160;
    }
    
    if (cellModel.commentArr.count) {
        height += [ManyCommentsView carculateHeightWithCommentArr:cellModel.commentArr needAssistView:cellModel.commentNumber>3];
    }
    
    
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.topShadow];
        [self addSubview:self.activeTitleView];
        [self addSubview:self.titleView];
        [self addSubview:self.contentLabel];
        [self addSubview:self.secondContentLabel];
        [self addSubview:self.thirdContentLabel];
        [self addSubview:self.mainImageView];
        [self addSubview:self.commentView];
        [self addSubview:self.bottomShadow];
    }
    return self;
}

- (void)setModel:(ContactsActiveCellModel *)model isActive:(BOOL)isActive{
    _model = model;
    
    if (isActive) {
        [self.activeTitleView setImageUrl:model.userImageUrl title:model.title actionTime:model.actionTime needRound:model.needRound];
    }else{
        [self.titleView setImageUrl:model.userImageUrl title:model.title actionName:model.actionName actionTime:model.actionTime actionNameColor:model.actionNameColor needRound:model.needRound];
    }
    self.activeTitleView.hidden = !isActive;
    self.titleView.hidden = isActive;
    
    if (![model.content isEqualToString:@""]) {
        self.contentLabel.hidden = NO;
        self.contentLabel.text = model.content;
        [RKViewFactory autoLabel:self.contentLabel maxWidth:kCommentContentWidth maxHeight:kCommentContentMaxHeight];
    }else{
        self.contentLabel.hidden = YES;
    }
    
    if (![model.secondContent isEqualToString:@""]) {
        self.secondContentLabel.hidden = NO;
        self.secondContentLabel.text = model.secondContent;
        [RKViewFactory autoLabel:self.secondContentLabel maxWidth:kCommentContentWidth maxHeight:kCommentSecondContentMaxHeight];
    }else{
        self.secondContentLabel.hidden = YES;
    }
    
    if (![model.thirdContent isEqualToString:@""]) {
        self.thirdContentLabel.hidden = NO;
        self.thirdContentLabel.text = model.thirdContent;
        [RKViewFactory autoLabel:self.thirdContentLabel maxWidth:kCommentContentWidth maxHeight:kCommentThirdContentMaxHeight];
    }else{
        self.thirdContentLabel.hidden = YES;
    }
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageUrl]];
    
    [self.commentView setCommentNumber:model.commentNumber commentArr:model.commentArr needAssistView:model.commentNumber>3];
    
    CGFloat height = 0;
    
    height += CGRectGetHeight(self.topShadow.frame);
    
    UIView* titleView = isActive?self.activeTitleView:self.titleView;
    CGRect frame = titleView.frame;
    frame.origin.y = height+10;
    titleView.frame = frame;
    height += CGRectGetHeight(titleView.frame)+10+10;
    
    if (![model.content isEqualToString:@""]) {
        frame = self.contentLabel.frame;
        frame.origin.y = height;
        frame.origin.x = 10;
        self.contentLabel.frame = frame;
        height += CGRectGetHeight(self.contentLabel.frame)+10;
    }
    
    if (![model.secondContent isEqualToString:@""]) {
        frame = self.secondContentLabel.frame;
        frame.origin.y = height;
        frame.origin.x = 10;
        self.secondContentLabel.frame = frame;
        height += CGRectGetHeight(self.secondContentLabel.frame)+10;
    }
    
    if (![model.thirdContent isEqualToString:@""]) {
        frame = self.thirdContentLabel.frame;
        frame.origin.y = height;
        frame.origin.x = 10;
        self.thirdContentLabel.frame = frame;
        height += CGRectGetHeight(self.thirdContentLabel.frame)+10;
    }
    
    if (![model.mainImageUrl isEqualToString:@""]) {
        self.mainImageView.hidden = NO;
        frame = self.mainImageView.frame;
        frame.origin.y = height;
        self.mainImageView.frame = frame;
        height += CGRectGetHeight(self.mainImageView.frame);
    }else{
        self.mainImageView.hidden = YES;
    }
    
    if (model.commentArr.count) {
        self.commentView.hidden = NO;
        frame = self.commentView.frame;
        frame.origin.y = height;
        self.commentView.frame = frame;
        height += CGRectGetHeight(self.commentView.frame);
    }else{
        self.commentView.hidden = YES;
    }
    
    
    frame = self.bottomShadow.frame;
    frame.origin.y = height-1;
    self.bottomShadow.frame = frame;
    height += 0;
}

- (ContactsActiveTitleView *)activeTitleView{
    if (!_activeTitleView) {
        _activeTitleView = [ContactsActiveTitleView titleView];
        _activeTitleView.delegate = self;
    }
    return _activeTitleView;
}

- (ContactsTitleView *)titleView{
    if (!_titleView) {
        _titleView = [ContactsTitleView titleView];
        _titleView.delegate = self;
    }
    return _titleView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = kCommentContentFont;
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

- (UILabel *)secondContentLabel{
    if (!_secondContentLabel) {
        _secondContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondContentLabel.font = kCommentContentFont;
        _secondContentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _secondContentLabel;
}

- (UILabel *)thirdContentLabel{
    if (!_thirdContentLabel) {
        _thirdContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _thirdContentLabel.font = kCommentThirdContentFont;
        _thirdContentLabel.textColor = RGBCOLOR(71, 71, 71);
    }
    return _thirdContentLabel;
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
    }
    return _commentView;
}

- (UIView *)topShadow{
    if (!_topShadow) {
        _topShadow = [RKShadowView seperatorLineWithHeight:10 top:9];
    }
    return _topShadow;
}

- (UIView *)bottomShadow{
    if (!_bottomShadow) {
        _bottomShadow = [RKShadowView seperatorLine];
    }
    return _bottomShadow;
}

- (void)titleViewUserImageClicked{
    if ([self.delegate respondsToSelector:@selector(contactsUserImageClickedWithIndexPath:)]) {
        [self.delegate contactsUserImageClickedWithIndexPath:self.model.indexPath];
    }
}

- (void)titleViewAssistBtnClicked{
    if ([self.delegate respondsToSelector:@selector(contactsCommentBtnClickedWithIndexPath:)]) {
        [self.delegate contactsCommentBtnClickedWithIndexPath:self.model.indexPath];
    }
}
@end
