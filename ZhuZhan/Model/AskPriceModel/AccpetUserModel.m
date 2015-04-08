//
//  AccpetUserModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/8.
//
//

#import "AccpetUserModel.h"

@implementation AccpetUserModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_userId = dict[@"userId"];
    self.a_loginName = dict[@"loginName"];
    self.a_lastQuoteId = dict[@"lastQuoteId"];
}
@end
