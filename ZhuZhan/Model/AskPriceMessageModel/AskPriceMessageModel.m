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
    self.a_time = [ProjectStage ChatMessageTimeStage:dict[@"createdTime"]];
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
    BOOL isContracts = NO;
    self.a_messageType = dict[@"messageType"];
    if([self.a_messageType isEqualToString:@"06"]){
        self.a_title = @"您有一个询价提醒";
        typeStr = @"询价单";
    }else if ([self.a_messageType isEqualToString:@"07"]){
        self.a_title = @"您有一个报价提醒";
        typeStr = @"报价单";
    }else{
        if([self.a_status isEqualToString:@"08"]){
            //新建
            self.a_title = @"新合同提醒";
        }else if ([self.a_status isEqualToString:@"09"]){
            //更新
            self.a_title = @"合同状态更新提醒";
        }else if([self.a_status isEqualToString:@"10"]){
            //完成
            self.a_title = @"合同完成提醒";
        }else{
            //关闭
            self.a_title = @"合同关闭提醒";
        }
        isContracts = YES;
    }
    
    NSString *messageContent = dict[@"messageContent"];
    NSLog(@"===>%@",messageContent);
    if(messageContent.length >20){
        self.a_content = [NSString stringWithFormat:@"参与用户 \"%@\" %@了您的需求描述：%@...的%@",dict[@"loginName"],str,[messageContent substringToIndex:20],typeStr];
    }else{
        self.a_content = [NSString stringWithFormat:@"参与用户 %@ %@您的需求描述：%@的%@ ",dict[@"loginName"],str,messageContent,typeStr];
    }
    
    if(isContracts){
        self.a_content =messageContent;
    }
}
@end
