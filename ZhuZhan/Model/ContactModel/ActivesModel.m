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
    self.a_dynamicLoginName=[[ProjectStage ProjectStrStage:dict[@"createUser"][@"loginName"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    if(![[ProjectStage ProjectStrStage:dict[@"createUser"][@"loginImagesId"]] isEqualToString:@""]){
        self.a_dynamicAvatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"createUser"][@"loginImagesId"], @"login", @"74", @"74", @"")];
    }else{
        self.a_dynamicAvatarUrl = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginImagesId"]];
    }
    self.a_dynamicLoginId = [ProjectStage ProjectStrStage:dict[@"createUser"][@"loginId"]];
    if([[ProjectStage ProjectStrStage:dict[@"createUser"][@"userType"]] isEqualToString:@"01"]){
        self.a_dynamicUserType = @"Personal";
        self.a_isPersonal = YES;
    }else{
        self.a_dynamicUserType = @"Company";
        self.a_isPersonal = NO;
    }
    self.a_time = [ProjectStage ProjectDateStage:dict[@"createdTime"]];
    
    self.a_imageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"imageWidth"]]];
    self.a_imageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"imageHeight"]]];
    NSString *height = nil;
    if([self.a_imageWidth intValue]>320){
        height = [NSString stringWithFormat:@"%d",(int)([self.a_imageHeight floatValue]/([self.a_imageWidth floatValue]/320))];
        self.a_imageWidth = @"320";
        self.a_imageHeight = height;
    }
    if(![[ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]] isEqualToString:@""]){
        self.a_imageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"dynamicImagesId"], @"dynamic", @"640", @"320", @"1")];
        self.a_bigImageUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"dynamicImagesId"], @"dynamic", @"640", @"", @"")];
    }else{
        self.a_imageUrl = [ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]];
        self.a_bigImageUrl = [ProjectStage ProjectStrStage:dict[@"dynamicImagesId"]];
    }
    
    self.a_entityId = [ProjectStage ProjectStrStage:dict[@"operationId"]];
    self.a_title = [ProjectStage ProjectStrStage:dict[@"title"]];
    self.a_content=[[ProjectStage ProjectStrStage:dict[@"content"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];

    self.a_operationCode = [ProjectStage ProjectStrStage:dict[@"operationCode"]];
    self.a_sourceCode = [ProjectStage ProjectStrStage:dict[@"sourceCode"]];
    
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"operationData"][@"projectName"]];
    self.a_projectStage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"projectStage"]];
    
    self.a_productName = [ProjectStage ProjectStrStage:dict[@"operationData"][@"productName"]];
    self.a_landAddress = [ProjectStage ProjectStrStage:dict[@"operationData"][@"landAddress"]];
    self.a_landProvince = [ProjectStage ProjectStrStage:dict[@"operationData"][@"landProvince"]];
    self.a_landCity = [ProjectStage ProjectStrStage:dict[@"operationData"][@"landCity"]];
    self.a_landDistrict = [ProjectStage ProjectStrStage:dict[@"operationData"][@"landDistrict"]];
    self.a_productDesc=[[ProjectStage ProjectStrStage:dict[@"operationData"][@"productDesc"]] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    self.a_productImageWidth = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageWidth"]]];
    self.a_productImageHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"operationData"][@"imageHeight"]]];
    if(![[ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]] isEqualToString:@""]){
        self.a_productImage = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"operationData"][@"productImagesId"], @"product", @"640", @"320", @"1")];
        self.a_bigProductImage = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"operationData"][@"productImagesId"], @"product", @"640", @"", @"")];
    }else{
        self.a_productImage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]];
        self.a_bigProductImage = [ProjectStage ProjectStrStage:dict[@"operationData"][@"productImagesId"]];
    }
    
    self.a_commentsArr = [[NSMutableArray alloc] init];
    if([dict[@"commentData"] count] !=0){
        for(NSDictionary *item in dict[@"commentData"]){
            ContactCommentModel *model = [[ContactCommentModel alloc] init];
            [model setDict:item];
            [self.a_commentsArr addObject:model];
        }
    }
    self.a_commentNum = [dict[@"commentNum"] integerValue];
    
    if([self.a_sourceCode isEqualToString:@"00"] && [self.a_operationCode isEqualToString:@"00"]){
        //个人 发布了动态
        self.a_type = 0;
    }else if ([self.a_sourceCode isEqualToString:@"01"] && [self.a_operationCode isEqualToString:@"00"]){
        //公司 发布了动态
        self.a_type = 0;
    }else if ([self.a_sourceCode isEqualToString:@"00"] && [self.a_operationCode isEqualToString:@"01"]){
        //个人 发布了产品
        self.a_type = 1;
    }else if ([self.a_sourceCode isEqualToString:@"01"] && [self.a_operationCode isEqualToString:@"01"]){
        //公司 发布了产品
        self.a_type = 1;
    }else if ([self.a_sourceCode isEqualToString:@"00"] && [self.a_operationCode isEqualToString:@"02"]){
        //个人 发布了项目
        self.a_type = 2;
    }else if ([self.a_sourceCode isEqualToString:@"01"] && [self.a_operationCode isEqualToString:@"02"]){
        //公司 发布了项目
        self.a_type = 2;
    }else if ([self.a_sourceCode isEqualToString:@"00"] && [self.a_operationCode isEqualToString:@"03"]){
        //个人 修改了个人资料
        self.a_type = 3;
    }else if ([self.a_sourceCode isEqualToString:@"01"] && [self.a_operationCode isEqualToString:@"03"]){
        //公司 修改了个人资料
        self.a_type = 3;
    }else if ([self.a_sourceCode isEqualToString:@"00"] && [self.a_operationCode isEqualToString:@"05"]){
        //个人 被公司认证通过
        self.a_type = 4;
    }else if ([self.a_sourceCode isEqualToString:@"02"] && [self.a_operationCode isEqualToString:@"03"]){
        //项目被修改了
        self.a_type = 5;
    }else if ([self.a_sourceCode isEqualToString:@"02"] && [self.a_operationCode isEqualToString:@"04"]){
        //项目被评论了
        self.a_type = 6;
    }else if ([self.a_sourceCode isEqualToString:@"03"] && [self.a_operationCode isEqualToString:@"04"]){
        //产品被评论了
        self.a_type = 7;
    }
}
@end
