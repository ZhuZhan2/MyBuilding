//
//  CommentModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentModel.h"
#import "ProjectStage.h"
@implementation CommentModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"entityId"]];;
    self.a_name = [ProjectStage ProjectStrStage:dict[@"name"]];
    self.a_time = [ProjectStage ProjectTimeStage:dict[@"updatedTime"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"activeContents"]];
    self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"activeImage"]];
    self.a_type = [ProjectStage ProjectStrStage:dict[@"type"]];
}
@end
