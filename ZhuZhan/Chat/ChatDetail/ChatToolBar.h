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
@end

@interface ChatToolBar : UIView
@property(nonatomic,readonly,copy)NSString* text;
@property(nonatomic,weak)id<ChatToolBarDelegate>delegate;
+(ChatToolBar*)chatToolBar;
+(CGFloat)orginChatToolBarHeight;
@end
