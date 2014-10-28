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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"userId"]];
    self.a_realName = [ProjectStage ProjectStrStage:dict[@"realName"]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"duties"]];
    self.a_sex = [ProjectStage ProjectStrStage:dict[@"sex"]];
    self.a_cellPhone = [ProjectStage ProjectStrStage:dict[@"cellphone"]];
    self.a_company = [ProjectStage ProjectStrStage:dict[@"company"]];
    self.a_email = [ProjectStage ProjectStrStage:dict[@"email"]];
    self.a_userImage = [ProjectStage ProjectStrStage:dict[@"userImage"]];
    self.a_location = [NSString stringWithFormat:@"%@ %@",[ProjectStage ProjectStrStage:dict[@"city"]],[ProjectStage ProjectStrStage:dict[@"district"]]];
    self.a_birthday = [ProjectStage ProjectTimeStage:dict[@"birthday"]];
    self.a_constellation = [ProjectStage ProjectStrStage:dict[@"constellation"]];
    self.a_bloodType = [ProjectStage ProjectStrStage:dict[@"bloodType"]];
}
@end
