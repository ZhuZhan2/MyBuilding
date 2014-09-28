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

-(instancetype)initWithEntityID:(NSString*)entityID userName:(NSString*)userName commentContents:(NSString*)commentContents userImage:(NSString*)userImage time:(NSDate*)time{
    if (self=[super init]) {
        self.a_id = entityID;
        self.a_name = userName;
        self.a_imageUrl = userImage;
        self.a_content = commentContents;
        self.a_time = time;
    }
    return self;
}
@end
