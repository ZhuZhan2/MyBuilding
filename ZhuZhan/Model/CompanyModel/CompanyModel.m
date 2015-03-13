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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"companyId"]];
    self.a_companyName = [ProjectStage ProjectStrStage:dict[@"companyName"]];
    self.a_companyIndustry = [ProjectStage ProjectStrStage:dict[@"companyIndustry"]];
    self.a_companyFocusNumber = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"companyFocusNumber"]]];
    self.a_companyEmployeeNumber = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"employeesNum"]]];
    self.a_companyDescription = [ProjectStage ProjectStrStage:dict[@"companyDesc"]];
    if(![[ProjectStage ProjectStrStage:dict[@"loginImagesId"]] isEqualToString:@""]){
        self.a_companyLogo = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"loginImagesId"]], @"login", @"", @"", @"")];
    }else{
        self.a_companyLogo = [ProjectStage ProjectStrStage:dict[@"loginImagesId"]];
    }
    self.a_focused = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isFocus"]]];
    self.a_companyContactName = [ProjectStage ProjectStrStage:dict[@"contactName"]];
    self.a_companyContactCellphone = [ProjectStage ProjectStrStage:dict[@"contactTel"]];
    self.a_companyContactEmail = [ProjectStage ProjectStrStage:dict[@"companyEmail"]];
    self.a_companyLocation = [ProjectStage ProjectStrStage:dict[@"address"]];
    self.a_companyProvince = [ProjectStage ProjectStrStage:dict[@"companyProvince"]];
    self.a_companyCity = [ProjectStage ProjectStrStage:dict[@"companyCity"]];
    self.a_reviewStatus = [ProjectStage ProjectStrStage:dict[@"reviewStatus"]];
}
@end
