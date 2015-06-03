//
//  CommentNumberView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/2.
//
//

#import <UIKit/UIKit.h>

@interface CommentNumberView : UIView
+ (CGFloat)commentNumberViewHeight;
+ (CommentNumberView*)commentNumberView;
- (void)setNumber:(NSInteger)number;
@end
