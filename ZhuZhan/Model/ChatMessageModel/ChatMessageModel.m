//
//  ChatMessageModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/10.
//
//

#import "ChatMessageModel.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"
@implementation ChatMessageModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"chatlogId"]];
    self.a_name = [ProjectStage ProjectStrStage:dict[@"senderName"]];
    if(![[ProjectStage ProjectStrStage:dict[@"senderImageId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"senderImageId"]], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"senderImageId"]];
    }
    self.a_message = [ProjectStage ProjectStrStage:dict[@"content"]];
    self.a_time = [ProjectStage ProjectStrStage:dict[@"createdTime"]];
    self.a_userId = [ProjectStage ProjectStrStage:dict[@"sender"]];
    if([[LoginSqlite getdata:@"userId"] isEqualToString:dict[@"sender"]]){
        self.a_type = chatTypeMe;
    }else{
        self.a_type = chatTypeOther;
    }
    self.a_groupId = [ProjectStage ProjectStrStage:dict[@"groupId"]];
    self.a_groupName = [ProjectStage ProjectStrStage:dict[@"groupName"]];
}
@end
