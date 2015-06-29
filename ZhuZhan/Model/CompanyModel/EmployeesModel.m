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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"loginId"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"loginName"]];
    if(![[ProjectStage ProjectStrStage:dict[@"headImageId"]] isEqualToString:@""]){
        self.a_userIamge = [NSString stringWithFormat:@"%@%@",[userDefaults objectForKey:@"serverAddress"],image([ProjectStage ProjectStrStage:dict[@"headImageId"]], @"login", @"", @"", @"")];
    }else{
        self.a_userIamge = [ProjectStage ProjectStrStage:dict[@"headImageId"]];
    }
    self.a_isFocused = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isFocus"]]];
    self.a_duties = [ProjectStage ProjectStrStage:dict[@"duties"]];
    self.a_department = [ProjectStage ProjectBoolStage:dict[@"department"]];
    self.a_company = [ProjectStage ProjectStrStage:dict[@"company"]];
    
    /*
     @property (nonatomic)BOOL isFriend;
     @property (nonatomic)BOOL isWaiting;
     */
    if (dict[@"isFriend"]) {
        self.a_isFriend=[dict[@"isFriend"] isEqualToString:@"1"];
    }
    if (dict[@"waiting"]) {
        self.a_isWaiting=[dict[@"waiting"] isEqualToString:@"1"];
    }
}
@end
