//
//  ChatToolBar.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/13.
//
//

#import <UIKit/UIKit.h>

@protocol ChatToolBarDelegate <NSObject>
-(void)chatToolBarSizeChangeWithHeight:(CGFloat)height;
-(void)chatToolSendBtnClickedWithContent:(NSString*)content;
@end

@interface ChatToolBar : UIView
@property(nonatomic,readonly,copy)NSString* text;
@property(nonatomic,weak)id<ChatToolBarDelegate>delegate;
@property(nonatomic)NSInteger maxTextCount;//询价报价式回复专用
@property(nonatomic)NSInteger maxTextCountInChat;//聊天式回复专用
+(ChatToolBar*)chatToolBar;
+(CGFloat)orginChatToolBarHeight;
@end
