//
//  MarketModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarketModel.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"

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
    if([dict[@"userType"] isEqualToString:@"01"]){
        self.a_needRound = YES;
    }else{
        self.a_needRound = NO;
    }
    
    if([dict[@"reqType"] isEqualToString:@"01"]){
        //找项目
        self.a_reqType = 1;
    }else if ([dict[@"reqType"] isEqualToString:@"02"]){
        //找材料
        self.a_reqType = 2;
    }else if ([dict[@"reqType"] isEqualToString:@"03"]){
        //找关系
        self.a_reqType = 3;
    }else if ([dict[@"reqType"] isEqualToString:@"04"]){
        //找合作
        self.a_reqType = 4;
    }else{
        //其他
        self.a_reqType = 5;
    }
    
    if([dict[@"province"] isEqualToString:@""] && [dict[@"city"] isEqualToString:@""]){
        self.a_address = @"-";
    }else{
        self.a_address = [NSString stringWithFormat:@"%@ %@",dict[@"province"],dict[@"city"]];
    }
    
    if([dict[@"reqDesc"] isEqualToString:@""]){
        self.a_reqDesc = @"-";
    }else{
        self.a_reqDesc = dict[@"reqDesc"];
    }
    
    if([dict[@"moneyMin"] isEqualToString:@""] && [dict[@"moneyMax"] isEqualToString:@""]){
        self.a_money = @"-";
    }else{
        self.a_money = [NSString stringWithFormat:@"%@－%@",dict[@"moneyMin"],dict[@"moneyMax"]];
    }
    
    if([dict[@"bigTypeCn"] isEqualToString:@""]){
        self.a_bigTypeCn = @"-";
    }else{
        self.a_bigTypeCn = dict[@"bigTypeCn"];
    }
    
    if([dict[@"smallTypeCn"] isEqualToString:@""]){
        self.a_smallTypeCn = @"-";
    }else{
        self.a_smallTypeCn = dict[@"smallTypeCn"];
    }
    
    self.a_commentCount = dict[@"commentsNum"];
    
    if([[LoginSqlite getdata:@"userId"] isEqualToString:dict[@"loginId"]]){
        self.a_isSelf = YES;
    }else{
        self.a_isSelf = NO;
    }
    
    if([dict[@"isFriend"] isEqualToString:@"0"]){
        self.a_isFriend = NO;
    }else{
        self.a_isFriend = YES;
    }
}
@end
