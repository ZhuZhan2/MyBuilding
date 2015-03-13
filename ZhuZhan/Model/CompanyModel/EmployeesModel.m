//
//  EmployeesModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/22.
//
//

#import "EmployeesModel.h"
#import "ProjectStage.h"
@implementation EmployeesModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"userId"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"loginName"]];
    if(![[ProjectStage ProjectStrStage:dict[@"headImageId"]] isEqualToString:@""]){
        self.a_userIamge = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"headImageId"]], @"login", @"", @"", @"")];
    }else{
        self.a_userIamge = [ProjectStage ProjectStrStage:dict[@"headImageId"]];
    }
    self.a_isFocused = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isFocus"]]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"duties"]];
    self.a_department = [ProjectStage ProjectBoolStage:dict[@"department"]];
    self.a_company = [ProjectStage ProjectStrStage:dict[@"company"]];
}
@end
