//
//  ChatListModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/11.
//
//

#import "ChatListModel.h"

@implementation ChatListModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_chatlogId = dict[@"chatlogId"];
    self.a_groupId = dict[@"groupId"];
    self.a_groupName = dict[@"name"];
    self.a_loginId = dict[@"loginId"];
    if(![dict[@"loginImagesId"] isEqualToString:@""]){
        self.a_loginImageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"loginImagesId"], @"login", @"", @"", @"")];
    }else{
        self.a_loginImageUrl = dict[@"loginImagesId"];
    }
    self.a_loginName = dict[@"loginName"];
    self.a_content = dict[@"content"];
    self.a_type = dict[@"type"];
    self.a_msgCount = dict[@"msgCount"];
    if([dict[@"msgCount"] isEqualToString:@"0"]){
        self.a_isShow = NO;
    }else{
        self.a_isShow = YES;
    }
}
@end
