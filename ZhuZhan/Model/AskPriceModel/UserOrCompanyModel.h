//
//  UserOrCompanyModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/25.
//
//

#import <Foundation/Foundation.h>

@interface UserOrCompanyModel : NSObject
@property(nonatomic,strong)NSString *a_loginId;
@property(nonatomic,strong)NSString *a_loginName;
@property(nonatomic,strong)NSString *a_nickName;
@property(nonatomic,strong)NSString *a_isVerified;
@property(nonatomic,strong)NSString *a_userType;
@property(nonatomic,strong)NSDictionary *dict;
@end
