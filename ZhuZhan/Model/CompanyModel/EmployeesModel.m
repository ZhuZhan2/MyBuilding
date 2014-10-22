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
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"userName"]];
    self.a_userIamge = [ProjectStage ProjectStrStage:dict[@"userIamge"]];
    self.a_isFocused = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isFocused"]]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"duties"]];
    self.a_department = [ProjectStage ProjectBoolStage:dict[@"department"]];
}
@end
