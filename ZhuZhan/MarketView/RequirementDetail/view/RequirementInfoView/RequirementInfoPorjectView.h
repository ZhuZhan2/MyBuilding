//
//  RequirementInfoPorjectView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@interface RequirementInfoPorjectView : UIView
+ (RequirementInfoPorjectView*)projectViewWithRequirementDescribe:(NSString*)requirementDescribe;
@property (nonatomic, copy)NSString* area;
@property (nonatomic, copy)NSString* minMoney;
@property (nonatomic, copy)NSString* maxMoney;
@property (nonatomic, copy)NSString* requirementDescribe;


@property (nonatomic, strong)UITextField* areaField;
@property (nonatomic, strong)UITextField* minMoneyField;
@property (nonatomic, strong)UIView* sepe;
@property (nonatomic, strong)UITextField* maxMoneyField;
@property (nonatomic, strong)UILabel* requirementDescribeLabel;
@end