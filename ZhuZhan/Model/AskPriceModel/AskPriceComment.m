//
//  AskPriceComment.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/27.
//
//

#import "AskPriceComment.h"
#import "ProjectStage.h"
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
}
@end
