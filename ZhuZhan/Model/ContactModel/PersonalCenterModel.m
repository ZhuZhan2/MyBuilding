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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"messageId"]];
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"messageSourceId"]];
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"messageData"][@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"messageData"][@"imageHeight"]]];
    if([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"01"]){
        self.a_content = [ProjectStage ProjectStrStage:dict[@"messageData"][@"content"]];
        if(![[ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]] isEqualToString:@""]){
            self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]], @"dynamic", @"60", @"60", @"")];
        }else{
            self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]];
        }
    }else if([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"02"]){
        self.a_entityName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"projectName"]];
        self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"messageData"][@"projectStage"]];
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"03"]){
        self.a_entityName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productName"]];
        self.a_content = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productDesc"]];
        if(![[ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]] isEqualToString:@""]){
            self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]], @"product", @"60", @"60", @"")];
        }else{
            self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]];
        }
    }else{
        self.a_content = [ProjectStage ProjectStrStage:dict[@"messageContent"]];
    }
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    if([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"01"]&&[[ProjectStage ProjectStrStage:dict[@"userInfo"][@"userType"]] isEqualToString:@"01"]){
        self.a_category = @"Personal";
        self.a_userName = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginName"]];
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"01"]&&[[ProjectStage ProjectStrStage:dict[@"userInfo"][@"userType"]] isEqualToString:@"02"]){
        self.a_category = @"Company";
        self.a_userName = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginName"]];
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"02"]){
        self.a_category = @"Project";
        self.a_userName = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginName"]];
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"03"]){
        self.a_category = @"Product";
        self.a_userName = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginName"]];
    }else{
        self.a_category = @"CompanyAgree";
        self.a_userName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"companyName"]];
    }
    
    if(![[ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]];
    }
    self.a_userType=[LoginSqlite getdata:@"userType"];
}
@end
