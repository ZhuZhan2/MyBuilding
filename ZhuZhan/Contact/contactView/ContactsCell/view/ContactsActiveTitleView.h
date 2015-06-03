//
//  ContactsActiveTitleView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import <UIKit/UIKit.h>

@protocol ContactsActiveTitleViewDelegate <NSObject>
- (void)titleViewUserImageClicked;
- (void)titleViewAssistBtnClicked;
@end

@interface ContactsActiveTitleView : UIView
@property (nonatomic, strong)UIImageView* userImageView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* actionTimeLabel;
@property (nonatomic, strong)UIButton* assistBtn;
@property (nonatomic, weak)id<ContactsActiveTitleViewDelegate> delegate;

+ (ContactsActiveTitleView*)titleView;
- (void)setImageUrl:(NSString*)imageUrl title:(NSString*)title actionTime:(NSString*)actionTime needRound:(BOOL)needRound;

+ (CGFloat)titleViewHeight;
@end
