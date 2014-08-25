//
//  projectModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "projectModel.h"

@implementation projectModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = dict[@"id"];
    self.a_landName = dict[@"landName"];
    self.a_district = dict[@"landDistrict"];
    self.a_province = dict[@"landProvince"];
    self.a_city = dict[@"landCity"];
    self.a_landAddress = dict[@"landAddress"];
    self.a_area = dict[@"landArea"];
    self.a_plotRatio = dict[@"landPlotRatio"];
    self.a_usage = dict[@"landUsages"];
    self.a_projectName = dict[@"projectName"];
    self.a_description = dict[@"projectDescription"];
    self.a_exceptStartTime = dict[@"exceptStartTime"];
    self.a_exceptFinishTime = dict[@"exceptFinishTime"];
    self.a_investment = dict[@"investment"];
    self.a_storeyArea = dict[@"storeyArea"];
    self.a_storeyHeight = dict[@"storeyHeight"];
    self.a_foreignInvestment = dict[@"foreignInvestment"];
    self.a_ownerType = dict[@"ownerType"];
    self.a_longitude = dict[@"longitude"];
    self.a_latitude = dict[@"latitude"];
    self.a_mainDesignStage = dict[@"mainDesignStage"];
    self.a_elevator = dict[@"elevator"];
    self.a_airCondition = dict[@"airCondition"];
    self.a_heating = dict[@"heating"];
    self.a_externalWallMeterial = dict[@"externalWallMeterial"];
    self.a_stealStructure = dict[@"stealStructure"];
    self.a_actureStartTime = dict[@"actualStartTime"];
    self.a_fireControl = dict[@"fireControl"];
    self.a_green = dict[@"green"];
    self.a_electorWeakInstallation = dict[@"electorWeakInstallation"];
    self.a_decorationSituation = dict[@"decorationSituation"];
    self.a_decorationProcess = dict[@"decorationProcess"];
}


@end
