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
            self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]], @"dynamic", @"640", @"320", @"1")];
            self.a_imageOriginalUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]], @"dynamic", @"", @"", @"")];
        }else{
            self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]];
            self.a_imageOriginalUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]];
        }
    }else if([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"02"]){
        self.a_entityName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"projectName"]];
        self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"messageData"][@"projectStage"]];
        self.a_projectDemo = [ProjectStage ProjectStrStage:dict[@"demo"]];
        self.a_content = [ProjectStage ProjectStrStage:dict[@"messageContent"]];
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageType"]] isEqualToString:@"03"]){
        self.a_entityName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productName"]];
        self.a_content = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productName"]];
        if(![[ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]] isEqualToString:@""]){
            self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]], @"product", @"640", @"320", @"1")];
            self.a_imageOriginalUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]], @"product", @"", @"", @"")];
        }else{
            self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]];
            self.a_imageOriginalUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]];
        }
    }else{
        self.a_content = [ProjectStage ProjectStrStage:dict[@"messageContent"]];
    }
    self.a_time = [ProjectStage ProjectCardTimeStage:dict[@"createdTime"]];
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
    self.a_userType=[LoginSqlite getdata:@"userType"];
    if(![self.a_category isEqualToString:@"CompanyAgree"]){
        if(![[ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]] isEqualToString:@""]){
            self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]], @"login", @"", @"", @"")];
        }else{
            self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]];
        }
    }else{
        if(![[ProjectStage ProjectStrStage:dict[@"messageData"][@"loginImagesId"]] isEqualToString:@""]){
            self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"messageData"][@"loginImagesId"]], @"login", @"", @"", @"")];
        }else{
            self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"loginImagesId"]];
        }
    }
    
    self.a_address = [NSString stringWithFormat:@"%@ %@",[ProjectStage ProjectStrStage:dict[@"messageData"][@"landCity"]],[ProjectStage ProjectStrStage:dict[@"messageData"][@"landAddress"]]];
}
@end
