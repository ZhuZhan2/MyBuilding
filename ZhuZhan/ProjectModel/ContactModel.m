//
//  ContactModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ContactModel.h"
#import "ProjectStage.h"
@implementation ContactModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_contactName = [ProjectStage ProjectStrStage:dict[@"landName"]];
    self.a_mobilePhone = [ProjectStage ProjectStrStage:dict[@"landDistrict"]];
    self.a_accountName = [ProjectStage ProjectStrStage:dict[@"landProvince"]];
    self.a_accountAddress = [ProjectStage ProjectStrStage:dict[@"landCity"]];
    self.a_projectId = [ProjectStage ProjectStrStage:dict[@"landAddress"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"landArea"]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"landPlotRatio"]];
    self.a_category = [ProjectStage ProjectStrStage:dict[@"landUsages"]];
}
@end
