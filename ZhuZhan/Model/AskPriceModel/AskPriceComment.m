//
//  AskPriceComment.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/27.
//
//

#import "AskPriceComment.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"
@implementation AskPriceComment
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"id"];
    self.a_name = dict[@"commentsUserName"];
    self.a_contents = dict[@"contents"];
    self.a_createdBy = dict[@"createdBy"];
    self.a_createdTime = [NSString stringWithFormat:@"%@",[ProjectStage ProjectDateStage:dict[@"createdTime"]]];
    self.a_quoteId = dict[@"quoteId"];
    self.a_tradeCode = dict[@"tradeCode"];
    self.a_tradeId = dict[@"tradeId"];
    self.a_tradeUserAndCommentUser = dict[@"tradeUserAndCommentUser"];
    if([dict[@"createdBy"] isEqualToString:[LoginSqlite getdata:@"userId"]]){
        self.a_isSelf = YES;
    }else{
        self.a_isSelf = NO;
    }
    
    if([dict[@"isVerified"] isEqualToString:@"00"]){
        self.a_isVerified = dict[@""];
    }else{
        self.a_isVerified = dict[@"平台认证公司资质，诚实可信"];
    }
}
@end
