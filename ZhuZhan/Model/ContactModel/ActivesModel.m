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
    self.a_entityUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"actives"][@"entityUrl"]]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"actives"][@"projectName"]];
    self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"actives"][@"projectStage"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"actives"][@"userName"]];
    if(![[ProjectStage ProjectStrStage:dict[@"actives"][@"avatarUrl"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"actives"][@"avatarUrl"]]];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"avatarUrl"]];
    }
    self.a_time = [ProjectStage ProjectDateStage:dict[@"actives"][@"createdTime"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"actives"][@"content"]];
    if(![[ProjectStage ProjectStrStage:dict[@"actives"][@"imageLocation"]] isEqualToString:@""]){
        self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"actives"][@"imageLocation"]]];
    }else{
        self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"actives"][@"imageLocation"]];
    }
    self.a_category = [ProjectStage ProjectStrStage:dict[@"actives"][@"category"]];
    self.a_eventType = [ProjectStage ProjectStrStage:dict[@"actives"][@"eventType"]];
    self.a_title = [ProjectStage ProjectStrStage:dict[@"actives"][@"title"]];
    self.a_createdBy = [ProjectStage ProjectStrStage:dict[@"actives"][@"createdBy"]];
    self.a_userType = [ProjectStage ProjectStrStage:dict[@"actives"][@"userType"]];
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageHeight"]]];
    
    if(![[ProjectStage ProjectStrStage:dict[@"actives"][@"productImage"]] isEqualToString:@""]){
        self.a_productImage = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"actives"][@"productImage"]]];
    }else{
        self.a_productImage = [ProjectStage ProjectStrStage:dict[@"actives"][@"productImage"]];
    }

    self.a_commentsArr = [[NSMutableArray alloc] init];
    if([dict[@"comments"] count] !=0){
        for(NSDictionary *item in dict[@"comments"]){
            ContactCommentModel *model = [[ContactCommentModel alloc] init];
            [model setDict:item];
            [self.a_commentsArr addObject:model];
        }
        
        if(self.a_commentsArr.count >=3){
            [self.a_commentsArr insertObject:@"" atIndex:2];
        }
    }
}
@end
