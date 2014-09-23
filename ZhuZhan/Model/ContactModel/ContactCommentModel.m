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
    self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"avatarUrl"]];
}
@end
