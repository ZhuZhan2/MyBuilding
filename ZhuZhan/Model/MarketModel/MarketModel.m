//
//  MarketModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarketModel.h"
#import "ProjectStage.h"

@implementation MarketModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"reqId"];
    self.a_loginId = dict[@"loginId"];
    self.a_loginName = dict[@"loginName"];
    if(![[ProjectStage ProjectStrStage:dict[@"loginImagesId"]] isEqualToString:@""]){
        self.a_avatarUrl = [NSString stringWithFormat:@"%s%@",serverAddress,image(dict[@"loginImagesId"], @"login", @"", @"", @"")];
    }else{
        self.a_avatarUrl = [ProjectStage ProjectStrStage:dict[@"loginImagesId"]];
    }
    self.a_reqTypeCn = dict[@"reqTypeCn"];
    self.a_createdTime = [ProjectStage ProjectCardTimeStage:dict[@"createdTime"]];
}
@end
