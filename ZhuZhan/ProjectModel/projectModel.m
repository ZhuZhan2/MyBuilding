//
//  projectModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "projectModel.h"
#import "ProjectStage.h"
@implementation projectModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_landName = [ProjectStage ProjectStrStage:dict[@"landName"]];
    self.a_district = [ProjectStage ProjectStrStage:dict[@"landDistrict"]];
    self.a_province = [ProjectStage ProjectStrStage:dict[@"landProvince"]];
    self.a_city = [ProjectStage ProjectStrStage:dict[@"landCity"]];
    self.a_landAddress = [ProjectStage ProjectStrStage:dict[@"landAddress"]];
    self.a_area = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"landArea"]]];
    self.a_plotRatio = [ProjectStage ProjectStrStage:dict[@"landPlotRatio"]];
    self.a_usage = [ProjectStage ProjectStrStage:dict[@"landUsages"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"projectName"]];
    self.a_description = [ProjectStage ProjectStrStage:dict[@"projectDescription"]];
    self.a_exceptStartTime = [ProjectStage ProjectTimeStage:dict[@"exceptStartTime"]];
    self.a_exceptFinishTime = [ProjectStage ProjectTimeStage:dict[@"exceptFinishTime"]];
    self.a_investment = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"investment"]]];
    self.a_storeyArea = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"storeyArea"]]];
    self.a_storeyHeight = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"storeyHeight"]]];
    self.a_foreignInvestment = [ProjectStage ProjectBoolStage:dict[@"foreignInvestment"]];
    self.a_ownerType = [ProjectStage ProjectStrStage:dict[@"ownerType"]];
    self.a_longitude = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"longitude"]]];
    self.a_latitude = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"latitude"]]];
    self.a_mainDesignStage = [ProjectStage ProjectStrStage:dict[@"mainDesignStage"]];
    self.a_elevator = [ProjectStage ProjectBoolStage:dict[@"elevator"]];
    self.a_airCondition = [ProjectStage ProjectBoolStage:dict[@"airCondition"]];
    self.a_heating = [ProjectStage ProjectBoolStage:dict[@"heating"]];
    self.a_externalWallMeterial = [ProjectStage ProjectBoolStage:dict[@"externalWallMeterial"]];
    self.a_stealStructure = [ProjectStage ProjectBoolStage:dict[@"stealStructure"]];
    self.a_actureStartTime = [ProjectStage ProjectTimeStage:dict[@"actualStartTime"]];
    self.a_fireControl = [ProjectStage ProjectStrStage:dict[@"fireControl"]];
    self.a_green = [ProjectStage ProjectStrStage:dict[@"green"]];
    self.a_electorWeakInstallation = [ProjectStage ProjectStrStage:dict[@"electorWeakInstallation"]];
    self.a_decorationSituation = [ProjectStage ProjectStrStage:dict[@"decorationSituation"]];
    self.a_decorationProcess = [ProjectStage ProjectStrStage:dict[@"decorationProcess"]];
}


@end
