//
//  ManyCommentsView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import <UIKit/UIKit.h>

@interface ManyCommentsView : UIView

+ (CGFloat)carculateHeightWithCommentArr:(NSMutableArray*)commentArr;

+ (ManyCommentsView*)manyCommentsView;
- (CGFloat)setCommentNumber:(NSInteger)commentNumber commentArr:(NSMutableArray*)commentArr;
@end
