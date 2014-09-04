//
//  ProjectCommentModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import "ProjectCommentModel.h"
#import "ProjectStage.h"
@implementation ProjectCommentModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"entityId"]];
    self.a_name = [ProjectStage ProjectStrStage:dict[@"userName"]];
    self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"userImage"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"commentContents"]];
    //self.a_type = [ProjectStage ProjectStrStage:dict[@"entityType"]];
    self.a_type = @"comment";
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
}
@end
