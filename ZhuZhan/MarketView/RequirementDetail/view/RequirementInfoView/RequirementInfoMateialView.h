//
//  RequirementInfoMateialView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@interface RequirementInfoMateialView : UIView
+ (RequirementInfoMateialView*)mateialViewWithRequirementDescribe:(NSString*)requirementDescribe smallCategory:(NSString*)smallCategory;
@property (nonatomic, copy)NSString* bigCategory;
@property (nonatomic, copy)NSString* smallCategory;
@property (nonatomic, copy)NSString* requirementDescribe;

@property (nonatomic, strong)UITextField* bigCategoryField;
@property (nonatomic, strong)UILabel* smallCategoryLabel;
@property (nonatomic, strong)UILabel* requirementDescribeLabel;
@end
