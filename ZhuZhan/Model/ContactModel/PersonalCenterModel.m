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
-(void)setDict:(NSDictionary *)dict{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"messageId"]];
    self.a_messageSourceId = [ProjectStage ProjectStrStage:dict[@"messageSourceId"]];
    self.a_createdTime = [ProjectStage ProjectCardTimeStage:dict[@"createdTime"]];
    
    self.a_loginId = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginId"]];
    self.a_loginName = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginName"]];
    if(![[ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"userInfo"][@"loginImagesId"]];
    }
    self.a_userType = [LoginSqlite getdata:@"userType"];
    
    self.a_messageType = [ProjectStage ProjectStrStage:dict[@"messageType"]];
    self.a_operationType = [ProjectStage ProjectStrStage:dict[@"operationType"]];
    
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"projectName"]];
    self.a_projectAddress = [NSString stringWithFormat:@"%@ %@",[ProjectStage ProjectStrStage:dict[@"messageData"][@"landCity"]],[ProjectStage ProjectStrStage:dict[@"messageData"][@"projectAddress"]]];
    
    self.a_productName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productName"]];
    
    self.a_companyName = [ProjectStage ProjectStrStage:dict[@"messageData"][@"companyName"]];
    
    if([[ProjectStage ProjectStrStage:dict[@"messageData"][@"reqType"]] isEqualToString:@"01"]){
        self.a_reqTypeStr = @"找项目";
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageData"][@"reqType"]] isEqualToString:@"02"]){
        self.a_reqTypeStr = @"找材料";
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageData"][@"reqType"]] isEqualToString:@"03"]){
        self.a_reqTypeStr = @"找关系";
    }else if ([[ProjectStage ProjectStrStage:dict[@"messageData"][@"reqType"]] isEqualToString:@"03"]){
        self.a_reqTypeStr = @"找合作";
    }else{
        self.a_reqTypeStr = @"其他";
    }
    self.a_reqDesc = [ProjectStage ProjectStrStage:dict[@"messageData"][@"reqDesc"]];
    
    if([self.a_messageType isEqualToString:@"01"] && [self.a_operationType isEqualToString:@"01"]){
        //动态被评论
        self.a_type = 0;
    }else if ([self.a_messageType isEqualToString:@"02"] && [self.a_operationType isEqualToString:@"01"]){
        //项目被评论
        self.a_type = 1;
    }else if ([self.a_messageType isEqualToString:@"02"] && [self.a_operationType isEqualToString:@"02"]){
        //项目认证通过
        self.a_type = 2;
    }else if ([self.a_messageType isEqualToString:@"02"] && [self.a_operationType isEqualToString:@"03"]){
        //项目认证不通过
        self.a_type = 3;
    }else if ([self.a_messageType isEqualToString:@"02"] && [self.a_operationType isEqualToString:@"05"]){
        //项目活动申请付款通过
        self.a_type = 4;
    }else if ([self.a_messageType isEqualToString:@"02"] && [self.a_operationType isEqualToString:@"06"]){
        //项目活动申请付款不通过
        self.a_type = 5;
    }else if ([self.a_messageType isEqualToString:@"03"] && [self.a_operationType isEqualToString:@"01"]){
        //产品被评论
        self.a_type = 6;
    }else if ([self.a_messageType isEqualToString:@"04"] && [self.a_operationType isEqualToString:@"02"]){
        //被公司认证通过
        self.a_type = 7;
    }else if ([self.a_messageType isEqualToString:@"10"] && [self.a_operationType isEqualToString:@"01"]){
        //需求被评论
        self.a_type = 8;
    }else if([self.a_messageType isEqualToString:@"10"] && [self.a_operationType isEqualToString:@"04"]){
        //需求有回复
        self.a_type = 9;
    }else if ([self.a_messageType isEqualToString:@"11"] && [self.a_operationType isEqualToString:@"07"]){
        //积分被关闭
        self.a_type = 10;
    }
    
    if([self.a_messageType isEqualToString:@"01"]){
        if(![[ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]] isEqualToString:@""]){
            self.a_imageUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]], @"dynamic", @"640", @"320", @"1")];
            self.a_imageOriginalUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]], @"dynamic", @"", @"", @"")];
        }else{
            self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]];
            self.a_imageOriginalUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"dynamicImagesId"]];
        }
        self.a_msgContent = [ProjectStage ProjectStrStage:dict[@"messageData"][@"content"]];
    }else if ([self.a_messageType isEqualToString:@"03"]){
        if(![[ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]] isEqualToString:@""]){
            self.a_imageUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]], @"product", @"640", @"320", @"1")];
            self.a_imageOriginalUrl = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]], @"product", @"", @"", @"")];
        }else{
            self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]];
            self.a_imageOriginalUrl = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productImagesId"]];
        }
        self.a_msgContent = [ProjectStage ProjectStrStage:dict[@"messageData"][@"productName"]];
    }else if([self.a_messageType isEqualToString:@"11"]){
        self.a_msgContent = [ProjectStage ProjectStrStage:dict[@"messageContent"]];
    }
    
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"messageData"][@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"messageData"][@"imageHeight"]]];
    
    if([dict[@"messageData"][@"isOpen"] isEqualToString:@"00"]){
        self.a_isPubilc = YES;
    }else{
        self.a_isPubilc = NO;
    }
    
    self.a_reqId = dict[@"messageData"][@"reqId"];
}
@end
