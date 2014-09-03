//
//  MyCenterModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "MyCenterModel.h"
#import "ProjectStage.h"
@implementation MyCenterModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_name = [ProjectStage ProjectStrStage:dict[@"fullName"]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"duties"]];
    self.a_sex = [ProjectStage ProjectStrStage:dict[@"sex"]];
    //self.a_phone = [ProjectStage ProjectStrStage:dict[@"phone"]];
    self.a_company = [ProjectStage ProjectTimeStage:dict[@"company"]];
}
@end
