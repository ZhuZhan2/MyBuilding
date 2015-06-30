//
//  ChatSendImageView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/29.
//
//

#import <UIKit/UIKit.h>

@protocol ChatSendImageViewDelegate <NSObject>
- (void)chatSendImage:(UIImage*)image;
@end

@interface ChatSendImageView : UIView
@property (nonatomic, weak)id<ChatSendImageViewDelegate> delegate;
@property (nonatomic, strong)UIImageView* mainImageView;
@end
