//
//  RequirementContactsInfoView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import <UIKit/UIKit.h>

@interface RequirementContactsInfoView : UIView
@property (nonatomic, copy)NSString* realName;
@property (nonatomic, copy)NSString* phoneNumber;

@property (nonatomic, strong)UITextField* realNameField;
@property (nonatomic, strong)UITextField* phoneNumberField;

+ (RequirementContactsInfoView*)infoView;
@end
