//
//  ChatMoreSelectView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/18.
//
//

#import <UIKit/UIKit.h>

@protocol ChatMoreSelectViewDelegate <NSObject>
- (void)chatMoreSelectViewClickedWithIndex:(NSInteger)index;
@end

@interface ChatMoreSelectView : UIView
+ (ChatMoreSelectView *)chatMoreSelectViewWithViews:(NSArray*)views delegate:(id<ChatMoreSelectViewDelegate>)delegate;
@end
