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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"entityId"]];;
    self.a_name = [ProjectStage ProjectStrStage:dict[@"createdBy"]];
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"commentContents"]];
    //self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"activeImage"]];
    self.a_type = [ProjectStage ProjectStrStage:dict[@"entityType"]];
}
@end
