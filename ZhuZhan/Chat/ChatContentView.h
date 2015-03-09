//
//  ChatContentView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/6.
//
//

#import <UIKit/UIKit.h>

@interface ChatContentView : UIImageView
+(CGFloat)carculateChatContentViewHeightWithContentStr:(NSString*)contentStr;
-(void)setUpContentLabel;
- (void)setText:(NSString *)text isSelf:(BOOL)isSelf;
@property(nonatomic,readonly)CGFloat maxWidth;
@end
