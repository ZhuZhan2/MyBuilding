//
//  RequirementDetailModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementDetailModel.h"

@implementation RequirementDetailModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_loginId = dict[@"loginId"];
    self.a_loginImagesId = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"loginImagesId"], @"login", @"260", @"260", @"")];
    self.a_loginName = dict[@"loginName"];
    self.a_createdTime = dict[@"createdTime"];
    self.a_isPsersonal = [dict[@"userType"] isEqualToString:@"01"];
    
    self.a_requireType = dict[@"reqType"];
    self.a_requireTypeName = @{@"01":@"找项目",
                               @"02":@"找材料",
                               @"03":@"找关系",
                               @"04":@"找合作",
                               @"05":@"其他"}[self.a_requireType];

    self.a_realName = dict[@"realName"];
    self.a_telphone = dict[@"telphone"];
    
    self.a_province = dict[@"province"];
    self.a_city = dict[@"city"];

    self.a_moneyMin = dict[@"moneyMin"];
    self.a_moneyMax = dict[@"moneyMax"];
    
    self.a_bigTypeCn = dict[@"bigTypeCn"];
    self.a_smallTypeCn = [dict[@"smallTypeCn"] stringByReplacingOccurrencesOfString:@"," withString:@"、"];

    self.a_reqDesc = dict[@"reqDesc"];
}
@end
