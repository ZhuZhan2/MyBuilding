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
    self.a_userName=[[ProjectStage ProjectStrStage:dict[@"createUser"][@"loginName"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    if(![[ProjectStage ProjectStrStage:dict[@"createUser"][@"loginImagesId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"createUser"][@"loginImagesId"], @"login", @"37", @"37", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginImagesId"]];
    }
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"imageHeight"]]];
    NSString *height = nil;
    if([self.a_imageWidth intValue]>310){
        height = [NSString stringWithFormat:@"%d",(int)([self.a_imageHeight floatValue]/([self.a_imageWidth floatValue]/310))];
        self.a_imageWidth = @"310";
        self.a_imageHeight = height;
    }
    if(![[ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]] isEqualToString:@""]){
        self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"dynamicImagesId"], @"dynamic", @"310", @"", @"")];
    }else{
        self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]];
    }
    if([dict[@"sourceCode"] isEqualToString:@"00"]){
        self.a_category = @"Personal";
        self.a_content=[[ProjectStage ProjectStrStage:dict[@"content"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]){
        self.a_category = @"Company";
        self.a_content=[[ProjectStage ProjectStrStage:dict[@"content"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    }else if ([dict[@"sourceCode"] isEqualToString:@"02"]){
        self.a_category = @"Project";
        self.a_content=[[ProjectStage ProjectStrStage:dict[@"content"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    }else{
        self.a_category = @"Product";
        self.a_content=[[ProjectStage ProjectStrStage:dict[@"operationData"][@"productDesc"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageWidth"]]];
        self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageHeight"]]];
    }
    if([dict[@"sourceCode"] isEqualToString:@"00"]&&[dict[@"operationCode"] isEqualToString:@"00"]){
        self.a_eventType = @"Actives";
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]&&[dict[@"operationCode"] isEqualToString:@"00"]){
        self.a_eventType = @"Actives";
    }else if ([dict[@"sourceCode"] isEqualToString:@"00"]&&[dict[@"operationCode"] isEqualToString:@"01"]){
        self.a_content=[[ProjectStage ProjectStrStage:dict[@"operationData"][@"productDesc"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        self.a_eventType = @"AutomaticProduct";
        self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageWidth"]]];
        self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageHeight"]]];
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]&&[dict[@"operationCode"] isEqualToString:@"01"]){
        self.a_eventType = @"AutomaticProduct";
        self.a_content=[[ProjectStage ProjectStrStage:dict[@"operationData"][@"productDesc"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageWidth"]]];
        self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageHeight"]]];
    }else if ([dict[@"sourceCode"] isEqualToString:@"00"]&&[dict[@"operationCode"] isEqualToString:@"02"]){
        self.a_eventType = @"AutomaticProject";
    }else if ([dict[@"sourceCode"] isEqualToString:@"01"]&&[dict[@"operationCode"] isEqualToString:@"02"]){
        self.a_eventType = @"AutomaticProject";
    }else{
        self.a_eventType = @"Automatic";
    }
    //self.a_eventType = [ProjectStage ProjectStrStage:dict[@"actives"][@"eventType"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"operationData"][@"projectName"]];
    self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"projectStage"]];
    self.a_title = [ProjectStage ProjectStrStage:dict[@"title"]];
    self.a_createdBy = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginId"]];
    self.a_name = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginName"]];
    if([[ProjectStage ProjectStrStage:dict[@"createUser"][@"userType"]] isEqualToString:@"01"]){
        self.a_userType = @"Personal";
    }else{
        self.a_userType = @"Company";
    }
    
    if(![[ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]] isEqualToString:@""]){
        self.a_productImage = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"operationData"][@"productImagesId"], @"product", @"310", @"", @"")];
    }else{
        self.a_productImage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]];
    }
    self.a_productName = [ProjectStage ProjectStrStage:dict[@"operationData"][@"productName"]];
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
    NSLog(@"a_imageUrl===>%@",self.a_imageUrl);
    NSLog(@"a_productImage===>%@",self.a_productImage);
}
@end
