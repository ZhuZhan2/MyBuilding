//
//  ChatGroupMemberModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/13.
//
//

#import "ChatGroupMemberModel.h"

@implementation ChatGroupMemberModel
/*
 createdTime = "2015-04-13 14:53:22";
 createdUser = "d859009b-51b4-4415-ada1-d5ea09ca4130";
 groupId = "ab847661-c023-4ea3-a024-c19c6c457824";
 loginId = "2765fb48-405c-4648-8b9f-d03957260e0e";
 loginImagesId = "a150e8d9-378a-49d4-8b2a-fd9bd62da74f";
 loginName = ftzftz;
 nickName = "";
 */
-(void)setDict:(NSDictionary *)dict{
    self.a_createdTime=dict[@"createdTime"];
    self.a_createdUser=dict[@"createdUser"];
    self.a_groupId=dict[@"groupId"];
    self.a_loginId=dict[@"loginId"];
    if (![dict[@"loginImagesId"] isEqualToString:@""]) {
        self.a_loginImagesId=[NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"loginImagesId"], @"login", @"", @"", @"")];
    }else{
        self.a_loginImagesId=dict[@"loginImagesId"];
    }
    self.a_loginName=dict[@"loginName"];
    self.a_nickName=dict[@"nickName"];
}
@end
