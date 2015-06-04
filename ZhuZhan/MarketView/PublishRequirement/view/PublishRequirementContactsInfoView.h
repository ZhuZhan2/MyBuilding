//
//  PublishRequirementContactsInfoView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import <UIKit/UIKit.h>

@interface PublishRequirementContactsInfoView : UIView
@property (nonatomic, copy)NSString* publishUserName;
@property (nonatomic, copy)NSString* realName;
@property (nonatomic, copy)NSString* phoneNumber;
@property (nonatomic)BOOL allUserSee;

+ (PublishRequirementContactsInfoView*)infoView;
@end
