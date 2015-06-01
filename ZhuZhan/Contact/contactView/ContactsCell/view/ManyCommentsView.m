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
@interface ManyCommentsView()
@property (nonatomic)NSInteger commentNumber;
@property (nonatomic, strong)NSMutableArray* commentArr;
@property (nonatomic, strong)NSMutableArray* commentViewArr;
@end

@implementation ManyCommentsView
+ (CGFloat)carculateHeightWithCommentArr:(NSMutableArray *)commentArr{
    __block CGFloat height = 0;
    [commentArr enumerateObjectsUsingBlock:^(CommentModel* commentModel, NSUInteger idx, BOOL *stop) {
        height += [CommentView carculateHeightWithContent:commentModel.content];
    }];
    return height;
}

+ (ManyCommentsView*)manyCommentsView{
    return [[ManyCommentsView alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 0);
    }
    return self;
}

- (CGFloat)setCommentNumber:(NSInteger)commentNumber commentArr:(NSMutableArray*)commentArr{
    self.commentNumber = commentNumber;
    self.commentArr = commentArr;
    return 0;
}

- (void)setCommentArr:(NSMutableArray *)commentArr{
    _commentArr = commentArr;
    
    [self.commentViewArr enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    [self.commentViewArr removeAllObjects];
    
    __block CGFloat height = 0;
    [commentArr enumerateObjectsUsingBlock:^(CommentModel* commentModel, NSUInteger idx, BOOL *stop) {
        CommentView* commentView = [CommentView commentView];
        [commentView setImageUrl:commentModel.userImageUrl title:commentModel.userName actionTime:commentModel.actionTime content:commentModel.content];
        
        CGRect frame = commentView.frame;
        frame.origin = CGPointMake(0, height);
        commentView.frame = frame;
        [self addSubview:commentView];
        
        [self.commentViewArr addObject:commentView];
        height += CGRectGetHeight(commentView.frame);
    }];
    
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
@end
