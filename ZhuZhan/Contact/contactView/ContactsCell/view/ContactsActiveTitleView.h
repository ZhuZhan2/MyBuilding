//
//  ContactsActiveTitleView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/1.
//
//

#import <UIKit/UIKit.h>

@interface ContactsActiveTitleView : UIView
@property (nonatomic, strong)UIImageView* userImageView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* actionTimeLabel;
@property (nonatomic, strong)UIButton* assistBtn;

+ (ContactsActiveTitleView*)titleView;
- (void)setImageUrl:(NSString*)imageUrl title:(NSString*)title actionTime:(NSString*)actionTime;

+ (CGFloat)titleViewHeight;
@end
