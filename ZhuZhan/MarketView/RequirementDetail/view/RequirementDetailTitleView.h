//
//  RequirementDetailTitleView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@class RequirementDetailTitleView;
@protocol RequirementDetailTitleViewDelegate <NSObject>
- (void)requirementDetailTitleViewClicked:(RequirementDetailTitleView*)titleView;
- (void)requirementDetailTitleViewUserImageClicked:(RequirementDetailTitleView*)titleView imageView:(UIImageView*)imageView;
@end

@interface RequirementDetailTitleView : UIView
- (void)setUserImageUrl:(NSString *)imageUrl title:(NSString *)title time:(NSString *)time needRound:(BOOL)needRuond;
@property (nonatomic, weak)id<RequirementDetailTitleViewDelegate> delegate;
@end
