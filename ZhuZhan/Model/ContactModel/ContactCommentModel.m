//
//  ContactCommentModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import "ContactCommentModel.h"
#import "ProjectStage.h"
@implementation ContactCommentModel
-(void)setDict:(NSDictionary *)dict{
    self.a_id = [ProjectStage ProjectStrStage:dict[@"commentId"]];
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"paramId"]];
    self.a_createdBy = [ProjectStage ProjectStrStage:dict[@"createdUser"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"loginName"]];
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    self.a_commentContents = [ProjectStage ProjectStrStage:dict[@"content"]];
    if(![[ProjectStage ProjectStrStage:dict[@"imageUrl"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"imageUrl"]]];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"imageUrl"]];
    }
    if([dict[@"userType"] isEqualToString:@"01"]){
        self.a_userType = @"Personal";
    }else{
        self.a_userType = @"Company";
    }
}

-(instancetype)initWithID:(NSString*)ID entityID:(NSString*)entityID createdBy:(NSString*)createdBy userName:(NSString*)userName commentContents:(NSString*)commentContents avatarUrl:(NSString*)avatarUrl time:(NSDate*)time{
    if (self= [super init]) {
        self.a_id = ID;
        self.a_entityId = entityID;
        self.a_createdBy = createdBy;
        self.a_userName = userName;
        self.a_time = time;
        self.a_commentContents = commentContents;
        self.a_avatarUrl = avatarUrl;
    }
    return self;
}
@end
