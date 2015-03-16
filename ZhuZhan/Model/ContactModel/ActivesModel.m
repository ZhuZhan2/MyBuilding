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

    self.a_id = [ProjectStage ProjectStrStage:dict[@"dynamicId"]];
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"operationId"]];
    self.a_entityUrl = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"entityUrl"]]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"operationData"][@"projectName"]];
    self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"projectStage"]];
    self.a_userName=[[ProjectStage ProjectStrStage:dict[@"createUser"][@"loginName"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    if(![[ProjectStage ProjectStrStage:dict[@"createUser"][@"loginImagesId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"createUser"][@"loginImagesId"], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginImagesId"]];
    }
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    self.a_content=[[ProjectStage ProjectStrStage:dict[@"content"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    if(![[ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]] isEqualToString:@""]){
        self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"dynamicImagesId"], @"dynamic", @"", @"", @"")];
    }else{
        self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]];
    }
    if([dict[@"sourceCode"] isEqualToString:@"00"]){
        self.a_category = @"Personal";
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]){
        self.a_category = @"Company";
    }else if ([dict[@"sourceCode"] isEqualToString:@"02"]){
        self.a_category = @"Project";
    }else{
        self.a_category = @"Product";
    }
    if([dict[@"sourceCode"] isEqualToString:@"00"]&&[dict[@"operationCode"] isEqualToString:@"00"]){
        self.a_eventType = @"Actives";
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]&&[dict[@"operationCode"] isEqualToString:@"00"]){
        self.a_eventType = @"Actives";
    }else if ([dict[@"sourceCode"] isEqualToString:@"00"]&&[dict[@"operationCode"] isEqualToString:@"01"]){
        self.a_eventType = @"AutomaticProduct";
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]&&[dict[@"operationCode"] isEqualToString:@"01"]){
        self.a_eventType = @"AutomaticProduct";
    }else if ([dict[@"sourceCode"] isEqualToString:@"00"]&&[dict[@"operationCode"] isEqualToString:@"02"]){
        self.a_eventType = @"AutomaticProject";
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]&&[dict[@"operationCode"] isEqualToString:@"02"]){
        self.a_eventType = @"AutomaticProject";
    }else{
        self.a_eventType = @"Automatic";
    }
    //self.a_eventType = [ProjectStage ProjectStrStage:dict[@"actives"][@"eventType"]];
    self.a_title = [ProjectStage ProjectStrStage:dict[@"title"]];
    self.a_createdBy = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginId"]];
    if([[ProjectStage ProjectStrStage:dict[@"createUser"][@"userType"]] isEqualToString:@"01"]){
        self.a_userType = @"Personal";
    }else{
        self.a_userType = @"Company";
    }
    //self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageWidth"]]];
    //self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"actives"][@"imageHeight"]]];
    self.a_imageWidth = @"320";
    self.a_imageHeight = @"320";
    
    if(![[ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]] isEqualToString:@""]){
        self.a_productImage = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"operationData"][@"productImagesId"], @"product", @"", @"", @"")];
    }else{
        self.a_productImage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]];
    }

    self.a_commentsArr = [[NSMutableArray alloc] init];
    if([dict[@"commentData"] count] !=0){
        for(NSDictionary *item in dict[@"commentData"]){
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
