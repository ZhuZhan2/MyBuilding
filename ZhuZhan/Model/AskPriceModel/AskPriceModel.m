//
//  AskPriceModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/20.
//
//

#import "AskPriceModel.h"

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
    self.a_invitedUser = dict[@"invitedUser"];
    self.a_productBigCategory = dict[@"productBigCategory"];
    self.a_productCategory = dict[@"productCategory"];
    self.a_remark = dict[@"remark"];
}
@end
