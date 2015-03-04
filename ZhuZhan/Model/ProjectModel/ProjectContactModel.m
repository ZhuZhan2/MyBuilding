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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"contactId"]];
    self.a_contactName = [ProjectStage ProjectStrStage:dict[@"contactName"]];
    self.a_mobilePhone = [ProjectStage ProjectStrStage:dict[@"contactTel"]];
    self.a_accountName = [ProjectStage ProjectStrStage:dict[@"company"]];
    self.a_accountAddress = [ProjectStage ProjectStrStage:dict[@"companyAddr"]];
    self.a_projectId = [ProjectStage ProjectStrStage:dict[@"projectId"]];
    //self.a_projectName = [ProjectStage ProjectStrStage:dict[@"contactProjectName"]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"contactDuties"]];
    self.a_category = [ProjectStage ProjectStrStage:dict[@"contactCategory"]];
}
@end
