//
//  ChatMoreSelectView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/18.
//
//

#import "ChatMoreSelectView.h"
#import "RKShadowView.h"
@interface ChatMoreSelectView ()
@property (nonatomic, strong)NSArray* views;
@property (nonatomic, weak)id<ChatMoreSelectViewDelegate> delegate;
@end

@implementation ChatMoreSelectView
+ (ChatMoreSelectView *)chatMoreSelectViewWithViews:(NSArray*)views delegate:(id<ChatMoreSelectViewDelegate>)delegate{
    ChatMoreSelectView* moreSelectView = [[ChatMoreSelectView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 115)];
    moreSelectView.delegate = delegate;
    moreSelectView.views = views;
    [moreSelectView setUp];
    return moreSelectView;
}

- (void)setUp{
    UIView* seperatorLine = [RKShadowView seperatorLine];
    [self addSubview:seperatorLine];
    [self.views enumerateObjectsUsingBlock:^(UIView* view, NSUInteger idx, BOOL *stop) {
        CGRect frame = view.frame;
        CGPoint origin = CGPointMake(82+98*idx, 20);
        frame.origin = origin;
        view.frame = frame;
        [self addSubview:view];

        view.tag = idx;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClicked:)];
        [view addGestureRecognizer:tap];
    }];
}

- (void)btnClicked:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(chatMoreSelectViewClickedWithIndex:)]) {
        [self.delegate chatMoreSelectViewClickedWithIndex:tap.view.tag];
    }
}
@end
