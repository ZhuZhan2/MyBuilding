//
//  ContactsTitleView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/2.
//
//

#import <UIKit/UIKit.h>

@protocol ContactsTitleViewDelegate <NSObject>
- (void)titleViewUserImageClicked;
@end

@interface ContactsTitleView : UIView
@property (nonatomic, strong)UIImageView* userImageView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* actionNameLabel;
@property (nonatomic, strong)UILabel* actionTimeLabel;
@property (nonatomic, weak)id<ContactsTitleViewDelegate> delegate;

+ (ContactsTitleView*)titleView;
- (void)setImageUrl:(NSString*)imageUrl title:(NSString*)title actionName:(NSString*)actionName actionTime:(NSString*)actionTime;

+ (CGFloat)titleViewHeight;
@end
