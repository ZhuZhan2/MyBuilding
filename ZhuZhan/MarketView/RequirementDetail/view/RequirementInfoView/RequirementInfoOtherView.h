//
//  RequirementInfoOtherView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@interface RequirementInfoOtherView : UIView
+ (RequirementInfoOtherView*)otherViewWithRequirementDescribe:(NSString*)requirementDescribe;
@property (nonatomic, copy)NSString* requirementDescribe;

@property (nonatomic, strong)UILabel* requirementDescribeLabel;
@end
