//
//  ActivesModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-17.
//
//

#import "ActivesModel.h"
#import "ProjectStage.h"
#import "ContactCommentModel.h"
@implementation ActivesModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.a_id = [ProjectStage ProjectStrStage:dict[@"actives"][@"id"]];
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"actives"][@"entityId"]];
    self.a_entityUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"entityUrl"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"actives"][@"projectName"]];
    self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"actives"][@"projectStage"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"actives"][@"userName"]];
    self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"avatarUrl"]];
    self.a_time = [ProjectStage ProjectDateStage:dict[@"actives"][@"createdTime"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"actives"][@"content"]];
    self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"imageLocation"]];
    self.a_category = [ProjectStage ProjectStrStage:dict[@"actives"][@"category"]];
    self.a_eventType = [ProjectStage ProjectStrStage:dict[@"actives"][@"eventType"]];
    self.a_title = [ProjectStage ProjectStrStage:dict[@"actives"][@"title"]];
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageHeight"]]];
    
    self.a_commentsArr = [[NSMutableArray alloc] init];
    if([dict[@"comments"] count] !=0){
        for(NSDictionary *item in dict[@"comments"]){
            ContactCommentModel *model = [[ContactCommentModel alloc] init];
            [model setDict:item];
            [self.a_commentsArr addObject:model];
        }
    }
}
@end
