//
//  PersonalCenterModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import "PersonalCenterModel.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"
@implementation PersonalCenterModel

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"entityId"]];
    self.a_entityUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"entityUrl"]]];
    self.a_entityName = [ProjectStage ProjectStrStage:dict[@"entityName"]];
    self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"projectStage"]];
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    self.a_content = [ProjectStage ProjectStrStage:dict[@"content"]];
    if(![[ProjectStage ProjectStrStage:dict[@"imageLocation"]] isEqualToString:@""]){
        self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"imageLocation"]]];
    }else{
        self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"imageLocation"]];
    }
    self.a_category = [ProjectStage ProjectStrStage:dict[@"category"]];
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"imageHeight"]]];
    if(![[ProjectStage ProjectStrStage:dict[@"avatarUrl"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"avatarUrl"]]];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"avatarUrl"]];
    }
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"userName"]];
    self.a_userType=[LoginSqlite getdata:@"userType"];
}
@end
