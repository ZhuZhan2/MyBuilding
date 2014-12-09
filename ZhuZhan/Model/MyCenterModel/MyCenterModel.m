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
    if(![[ProjectStage ProjectStrStage:dict[@"userImage"]] isEqualToString:@""]){
        self.a_userImage = [NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"userImage"]]];
    }else{
        self.a_userImage = [ProjectStage ProjectStrStage:dict[@"userImage"]];
    }
    self.a_location = [NSString stringWithFormat:@"%@ %@",[ProjectStage ProjectStrStage:dict[@"city"]],[ProjectStage ProjectStrStage:dict[@"district"]]];
    self.a_birthday = [ProjectStage ProjectTimeStage:dict[@"birthday"]];
    self.a_constellation = [ProjectStage ProjectStrStage:dict[@"constellation"]];
    self.a_bloodType = [ProjectStage ProjectStrStage:dict[@"bloodType"]];
    self.a_province = [ProjectStage ProjectStrStage:dict[@"province"]];
    self.a_city = [ProjectStage ProjectStrStage:dict[@"city"]];
    self.a_district = [ProjectStage ProjectStrStage:dict[@"district"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"userName"]];
    if(![[ProjectStage ProjectStrStage:dict[@"backgroundImage"]] isEqualToString:@""]){
        self.a_backgroundImage=[NSString stringWithFormat:@"%s%@",serverAddress,[ProjectStage ProjectStrStage:dict[@"backgroundImage"]]];
    }else{
        self.a_backgroundImage=[ProjectStage ProjectStrStage:dict[@"backgroundImage"]];
    }
}
@end
