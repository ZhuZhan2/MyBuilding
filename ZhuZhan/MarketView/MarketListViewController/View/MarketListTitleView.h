//
//  MarketListTitleView.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@interface MarketListTitleView : UIView
@property(nonatomic,strong)UIImageView *headImage;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* typeLabel;
@property (nonatomic, strong)UILabel* timeLabel;
@property (nonatomic, strong)UIImageView *cutLine1;
@property (nonatomic, strong)UIImageView *cutLine2;
+ (CGFloat)titleViewHeight;
- (void)setImageUrl:(NSString*)imageUrl title:(NSString*)title type:(NSString*)type time:(NSString*)time needRound:(BOOL)needRound;
@end
