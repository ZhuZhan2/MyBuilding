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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"entityId"]];
    self.a_createdBy = [ProjectStage ProjectStrStage:dict[@"createdBy"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"userName"]];
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    self.a_commentContents = [ProjectStage ProjectStrStage:dict[@"commentContents"]];
    if(![[ProjectStage ProjectStrStage:dict[@"userImage"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"userImage"]]];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"userImage"]];
    }
    self.a_userType = [ProjectStage ProjectStrStage:dict[@"userType"]];
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
