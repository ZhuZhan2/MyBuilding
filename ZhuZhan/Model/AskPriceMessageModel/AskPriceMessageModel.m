//
//  AskPriceMessageModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import "AskPriceMessageModel.h"
#import "ProjectStage.h"
@implementation AskPriceMessageModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"messageId"];
    self.a_time = [ProjectStage ProjectTimeStage:dict[@"createdTime"]];
    self.a_status = dict[@"status"];
    self.a_messageSourceId = dict[@"messageSourceId"];
    self.a_messageObjectId = dict[@"messageObjectId"];
    NSString *str = @"";
    if([self.a_status isEqualToString:@"03"]){
        //新建询价
        str=@"询价";
    }else if([self.a_status isEqualToString:@"04"]){
        //新建报价
        str=@"回复";
    }else if([self.a_status isEqualToString:@"05"]){
        //回复
        str=@"回复";
    }else if([self.a_status isEqualToString:@"06"]){
        //采纳
        str=@"采纳";
    }else if([self.a_status isEqualToString:@"07"]){
        //关闭
        str=@"关闭";
    }
    
    NSString *typeStr = @"";
    self.a_messageType = dict[@"messageType"];
    if([self.a_messageType isEqualToString:@"06"]){
        self.a_title = @"您有一个询价提醒";
        typeStr = @"询价单";
    }else if ([self.a_messageType isEqualToString:@"07"]){
        self.a_title = @"您有一个报价提醒";
        typeStr = @"报价单";
    }else{
        self.a_title = @"您有一个合同提醒";
    }
    
    NSString *messageContent = dict[@"messageContent"];
    if(messageContent.length >20){
        self.a_content = [NSString stringWithFormat:@"参与用户 \"%@\" %@了您的需求描述：%@...的%@",dict[@"loginName"],str,[messageContent substringToIndex:20],typeStr];
    }else{
        self.a_content = [NSString stringWithFormat:@"参与用户 %@ %@您的需求描述：%@的%@ ",dict[@"loginName"],str,messageContent,typeStr];
    }
}
@end
