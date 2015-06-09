//
//  PublishRequirementMaterialView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/8.
//
//

#import <UIKit/UIKit.h>

@protocol PublishRequirementMaterialViewDelegate <NSObject>
- (void)materialViewBigCategoryBtnClicked;
- (void)materialViewSmallCategoryBtnClicked;
@end

@interface PublishRequirementMaterialView : UIView
+ (PublishRequirementMaterialView*)materialView;
@property (nonatomic, copy)NSString* bigCategory;
@property (nonatomic, copy)NSString* smallCategory;
@property (nonatomic, copy)NSString* requirementDescribe;
@property (nonatomic, weak)id<PublishRequirementMaterialViewDelegate> delegate;
@end
