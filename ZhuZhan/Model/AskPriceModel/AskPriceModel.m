//
//  AskPriceModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/20.
//
//

#import "AskPriceModel.h"
#import "ProjectStage.h"
@implementation AskPriceModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"id"];
    self.a_tradeCode = dict[@"tradeCode"];
    if([dict[@"tradeStatus"] isEqualToString:@"0"]){
        self.a_tradeStatus = @"进行中";
    }else if ([dict[@"tradeStatus"] isEqualToString:@"1"]){
        self.a_tradeStatus = @"已完成";
    }else{
        self.a_tradeStatus = @"已关闭";
    }
    self.a_createdBy = dict[@"createdBy"];
    self.a_requestName = dict[@"requestName"];
    NSMutableString *str = [[NSMutableString alloc] init];
    [dict[@"invitedUser"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendString:[NSString stringWithFormat:@"%@,",obj[@"loginName"]]];
    }];
    if(str.length !=0){
        self.a_invitedUser = [str substringWithRange:NSMakeRange(0,str.length-1)];
    }else{
        self.a_invitedUser = @"";
    }
    self.a_invitedUserArr = dict[@"invitedUser"];
    [dict[@"productBigCategory"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        self.a_productBigCategory = obj[@"name"];
    }];
    NSMutableString *str2 = [[NSMutableString alloc] init];
    [dict[@"productCategory"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str2 appendString:[NSString stringWithFormat:@"%@,",obj[@"name"]]];
    }];
    if(str2.length !=0){
        self.a_productCategory = [str2 substringWithRange:NSMakeRange(0,str.length-1)];
    }else{
        self.a_productCategory = @"";
    }
    self.a_remark = dict[@"remark"];
    self.a_category = dict[@"category"];
    self.a_time = [ProjectStage ProjectTimeStage:dict[@"createdTime"]];
}
@end

@implementation InvitedUserModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"loginId"];
    self.a_name = dict[@"loginName"];
    self.a_status = dict[@"status"];
    self.a_isVerified = dict[@"isVerified"];
}
@end
