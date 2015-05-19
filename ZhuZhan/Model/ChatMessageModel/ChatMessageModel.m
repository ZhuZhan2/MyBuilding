//
//  ChatMessageModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/10.
//
//

#import "ChatMessageModel.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"
@implementation ChatMessageModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"chatlogId"]];
    if([[ProjectStage ProjectStrStage:dict[@"nickName"]] isEqualToString:@""]){
        self.a_name = [ProjectStage ProjectStrStage:dict[@"senderName"]];
    }else{
        self.a_name = [ProjectStage ProjectStrStage:dict[@"nickName"]];
    }
    if(![[ProjectStage ProjectStrStage:dict[@"senderImageId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"senderImageId"]], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"senderImageId"]];
    }
    
    if([dict[@"msgType"] isEqualToString:@"01"]){
        self.a_message = [ProjectStage ProjectStrStage:dict[@"content"]];
    }else{
        if(![[ProjectStage ProjectStrStage:dict[@"content"]] isEqualToString:@""]){
            self.a_message = [NSString stringWithFormat:@"%s%@",socketHttp,image([ProjectStage ProjectStrStage:dict[@"content"]], @"chatImage", @"200", @"200", @"")];
        }else{
            self.a_message = [ProjectStage ProjectStrStage:dict[@"content"]];
        }
    }
    
    self.a_time = [ProjectStage ChatMessageTimeStage:dict[@"createdTime"]];
    self.a_userId = [ProjectStage ProjectStrStage:dict[@"sender"]];
    if([[LoginSqlite getdata:@"userId"] isEqualToString:dict[@"sender"]]){
        self.a_type = chatTypeMe;
    }else{
        self.a_type = chatTypeOther;
    }
    self.a_groupId = [ProjectStage ProjectStrStage:dict[@"groupId"]];
    self.a_groupName = [ProjectStage ProjectStrStage:dict[@"groupName"]];
    self.a_msgType = [ProjectStage ProjectStrStage:dict[@"msgType"]];
    self.a_isLocal = NO;
    
    CGSize size = [ChatMessageModel getImageWidth:dict[@"imageWidth"] height:dict[@"imageHeight"]];
    self.a_imageWidth = size.width;
    self.a_imageHeight = size.height;
}

+(CGSize)getImageWidth:(NSString *)width height:(NSString *)height{
    CGSize newSize ;
    CGFloat newWidth = [width intValue];
    CGFloat newHeight = [height intValue];
    if(newWidth > newHeight){
        if(newWidth>200){
            newWidth = 200;
        }
        double origin = 200/[width floatValue];
        newHeight = newHeight*origin;
        newSize.width = (int)newWidth;
        newSize.height = (int)newHeight;
        return newSize;
    }else if(newWidth == newHeight){
        newSize.width = 200;
        newSize.height = 200;
        return newSize;
    }else{
        if(newHeight>200){
            newHeight = 200;
        }
        CGFloat origin = 200/[height floatValue];
        newWidth = newWidth*origin;
        newSize.width = newWidth;
        newSize.height = newHeight;
        return newSize;
    }
    
}
@end
