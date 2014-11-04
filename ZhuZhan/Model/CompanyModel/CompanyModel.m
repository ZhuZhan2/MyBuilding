//
//  CompanyModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/20.
//
//

#import "CompanyModel.h"
#import "ProjectStage.h"
@implementation CompanyModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_companyName = [ProjectStage ProjectStrStage:dict[@"companyName"]];
    self.a_companyIndustry = [ProjectStage ProjectStrStage:dict[@"companyIndustry"]];
    self.a_companyFocusNumber = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"companyFocusNumber"]]];
    self.a_companyEmployeeNumber = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"companyEmployeeNumber"]]];
    self.a_companyDescription = [ProjectStage ProjectStrStage:dict[@"companyDescription"]];
    self.a_companyLogo = [ProjectStage ProjectStrStage:dict[@"companyLogo"]];
    self.a_focused = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"focused"]]];
    self.a_companyContactName = [ProjectStage ProjectStrStage:dict[@"companyContactName"]];
    self.a_companyContactCellphone = [ProjectStage ProjectStrStage:dict[@"companyContactCellphone"]];
    self.a_companyContactEmail = [ProjectStage ProjectStrStage:dict[@"companyContactEmail"]];
    self.a_companyLocation = [ProjectStage ProjectStrStage:dict[@"companyLocation"]];
}
@end
