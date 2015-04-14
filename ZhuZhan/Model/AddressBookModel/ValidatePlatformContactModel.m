//
//  ValidatePlatformContactModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/14.
//
//

#import "ValidatePlatformContactModel.h"

@implementation ValidatePlatformContactModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    /*
     isFriend = 0;
     isPlatformUser = 0;
     loginId = "";
     loginName = "";
     loginTel = "888-555-5512";
     */
    self.a_isFriend=[dict[@"isFriend"] isEqualToString:@"1"];
    self.a_isPlatformUser=[dict[@"isPlatformUser"] isEqualToString:@"1"];
    self.a_loginId=dict[@"loginId"];
    self.a_loginName=dict[@"loginName"];
    self.a_loginTel=dict[@"loginTel"];

}
@end
