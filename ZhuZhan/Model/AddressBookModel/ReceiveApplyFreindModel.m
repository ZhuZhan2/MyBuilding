//
//  ReceiveApplyFreindModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "ReceiveApplyFreindModel.h"

@implementation ReceiveApplyFreindModel
-(void)setDic:(NSDictionary *)dic{
    _dic=dic;
    /*
     @property(nonatomic,copy)NSString* a_createdTime;
     @property(nonatomic,copy)NSString* a_createdUser;
     @property(nonatomic,copy)NSString* a_imageId;
     @property(nonatomic,copy)NSString* a_loginName;
     @property(nonatomic,copy)NSString* a_messageContent;
     @property(nonatomic,copy)NSString* a_messageId;
     @property(nonatomic,copy)NSString* a_messageObjectId;
     @property(nonatomic,copy)NSString* a_messageType;
     @property(nonatomic,copy)NSString* a_status;
     */
    self.a_createdTime=dic[@"createdTime"];
    self.a_createdUser=dic[@"createdUser"];
    self.a_imageId=dic[@"imageId"];
    self.a_loginName=dic[@"loginName"];
    self.a_messageContent=dic[@"messageContent"];
    self.a_messageId=dic[@"messageId"];
    self.a_messageObjectId=dic[@"messageObjectId"];
    self.a_messageType=dic[@"messageType"];
    self.a_isFinished=[dic[@"status"] isEqualToString:@"02"];

}
@end
