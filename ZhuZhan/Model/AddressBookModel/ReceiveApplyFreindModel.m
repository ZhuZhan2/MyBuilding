//
//  ReceiveApplyFreindModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "ReceiveApplyFreindModel.h"
#import "ProjectStage.h"
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.a_createdTime=[ProjectStage ChatMessageTimeStage:dic[@"createdTime"]];
    self.a_createdUser=dic[@"createdUser"];
    self.a_loginName=dic[@"loginName"];
    self.a_messageContent=dic[@"messageContent"];
    if(![dic[@"imageId"] isEqualToString:@""]){
        self.a_imageId = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image(dic[@"imageId"], @"login", @"", @"", @"")];
    }else{
        self.a_imageId = dic[@"imageId"];
    }
    self.a_messageId=dic[@"messageId"];
    self.a_messageObjectId=dic[@"messageObjectId"];
    self.a_messageType=dic[@"messageType"];
    self.a_isFinished=[dic[@"status"] isEqualToString:@"01"];
    self.a_status=dic[@"status"];
}
@end
