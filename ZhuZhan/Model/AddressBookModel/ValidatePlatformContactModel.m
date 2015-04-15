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
     "HEAD_IMAGEID" = "";
     isFriend = 0;
     isPlatformUser = 1;
     loginId = "1e745f66-d1e6-4855-8e50-7cf36aa40f3d";
     loginName = "zhou yue123";
     loginTel = 12345678901;
     userType = 01;
     waiting = 1;
     */
    self.a_isFriend=[dict[@"isFriend"] isEqualToString:@"1"];
    self.a_isPlatformUser=[dict[@"isPlatformUser"] isEqualToString:@"1"];
    self.a_loginId=dict[@"loginId"];
    self.a_loginName=dict[@"loginName"];
    self.a_loginTel=dict[@"loginTel"];
    self.a_isWaiting=[dict[@"waiting"] isEqualToString:@"1"];
}
@end
