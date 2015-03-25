//
//  UserOrCompanyModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/25.
//
//

#import "UserOrCompanyModel.h"

@implementation UserOrCompanyModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_loginId = dict[@"loginId"];
    self.a_loginName = dict[@"loginName"];
    self.a_nickName = dict[@"nickName"];
    self.a_isVerified = dict[@"isVerified"];
    self.a_userType = dict[@"userType"];
}
@end
