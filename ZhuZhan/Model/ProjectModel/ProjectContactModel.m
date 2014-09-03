//
//  ContactModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectContactModel.h"
#import "ProjectStage.h"
@implementation ProjectContactModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_contactName = [ProjectStage ProjectStrStage:dict[@"contactName"]];
    self.a_mobilePhone = [ProjectStage ProjectStrStage:dict[@"contactCellphone"]];
    self.a_accountName = [ProjectStage ProjectStrStage:dict[@"contactCompany"]];
    self.a_accountAddress = [ProjectStage ProjectStrStage:dict[@"contactCompanyAddress"]];
    self.a_projectId = [ProjectStage ProjectStrStage:dict[@"contactProjectId"]];
    self.a_projectName = [ProjectStage ProjectStrStage:dict[@"contactProjectName"]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"contactDuties"]];
    self.a_category = [ProjectStage ProjectStrStage:dict[@"contactCategory"]];
}
@end
