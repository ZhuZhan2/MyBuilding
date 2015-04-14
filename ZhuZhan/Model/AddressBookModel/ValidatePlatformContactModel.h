//
//  ValidatePlatformContactModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/14.
//
//

#import <Foundation/Foundation.h>


@interface ValidatePlatformContactModel : NSObject
@property (nonatomic)BOOL a_isFriend;
@property (nonatomic)BOOL a_isPlatformUser;
@property (nonatomic, copy)NSString* a_userPhoneName;
@property (nonatomic, copy)NSString* a_loginId;
@property (nonatomic, copy)NSString* a_loginName;
@property (nonatomic, copy)NSString* a_loginTel;
@property (nonatomic, strong)NSDictionary* dict;
@end
