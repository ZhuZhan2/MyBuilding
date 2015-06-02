//
//  ManyCommentsView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import "ManyCommentsView.h"
#import "CommentView.h"
#import "CommentModel.h"
#import "CommentNumberView.h"
#import "RKShadowView.h"

@interface ManyCommentsView()
@property (nonatomic, strong)CommentNumberView* commentNumberView;

@property (nonatomic, strong)NSMutableArray* commentArr;
@property (nonatomic, strong)NSMutableArray* commentViewArr;

@property (nonatomic, strong)UILabel* moreCommentsLabel;
@end

@implementation ManyCommentsView
+ (CGFloat)carculateHeightWithCommentArr:(NSMutableArray *)commentArr{
    __block CGFloat height = 0;
    [commentArr enumerateObjectsUsingBlock:^(CommentModel* commentModel, NSUInteger idx, BOOL *stop) {
        height += [CommentView carculateHeightWithContent:commentModel.content];
    }];
    
    height += [CommentNumberView commentNumberViewHeight];
    
    if (commentArr.count >= 3) {
        height += 30;
    }
    return height;
}

+ (ManyCommentsView*)manyCommentsView{
    return [[ManyCommentsView alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 0);
        [self addSubview:self.commentNumberView];
        [self addSubview:self.moreCommentsLabel];
    }
    return self;
}

- (CGFloat)setCommentNumber:(NSInteger)commentNumber commentArr:(NSMutableArray*)commentArr{
    [self.commentNumberView setNumber:commentNumber];
    
    self.commentArr = commentArr;
    

    
    return 0;
}

- (void)setCommentArr:(NSMutableArray *)commentArr{
    _commentArr = commentArr;
    
    [self.commentViewArr enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    [self.commentViewArr removeAllObjects];
    
    __block CGFloat height = CGRectGetMaxY(self.commentNumberView.frame);
    [commentArr enumerateObjectsUsingBlock:^(CommentModel* commentModel, NSUInteger idx, BOOL *stop) {
        CommentView* commentView = [CommentView commentView];
        [commentView setImageUrl:commentModel.userImageUrl title:commentModel.userName actionTime:commentModel.actionTime content:commentModel.content needTopLine:idx needBottomLine:idx==2];
        
        CGRect frame = commentView.frame;
        frame.origin = CGPointMake(0, height);
        commentView.frame = frame;
        [self addSubview:commentView];
        
        [self.commentViewArr addObject:commentView];
        height += CGRectGetHeight(commentView.frame);
    }];
    
    if (commentArr.count >= 3) {
        self.moreCommentsLabel.hidden = NO;
        
        CGRect frame = self.moreCommentsLabel.frame;
        frame.origin.y = height;
        self.moreCommentsLabel.frame = frame;
        
        height += 30;
    }else{
        self.moreCommentsLabel.hidden = YES;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (NSMutableArray *)commentViewArr{
    if (!_commentViewArr) {
        _commentViewArr = [NSMutableArray array];
    }
    return _commentViewArr;
}

- (CommentNumberView *)commentNumberView{
    if (!_commentNumberView) {
        _commentNumberView = [CommentNumberView commentNumberView];
    }
    return _commentNumberView;
}

- (UILabel *)moreCommentsLabel{
    if (!_moreCommentsLabel) {
        _moreCommentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _moreCommentsLabel.textColor = AllNoDataColor;
        _moreCommentsLabel.text = @"更多评论";
        _moreCommentsLabel.font = [UIFont systemFontOfSize:14];
        _moreCommentsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moreCommentsLabel;
}
@end
