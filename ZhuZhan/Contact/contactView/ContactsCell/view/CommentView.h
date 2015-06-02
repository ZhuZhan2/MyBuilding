//
//  CommentView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView
@property (nonatomic, strong)UIImageView* userImageView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* actionTimeLabel;
@property (nonatomic, strong)UILabel* contentLabel;

+ (CGFloat)carculateHeightWithContent:(NSString*)content;

+ (CommentView*)commentView;
- (void)setImageUrl:(NSString*)imageUrl title:(NSString*)title actionTime:(NSString*)actionTime content:(NSString*)content;
@end
