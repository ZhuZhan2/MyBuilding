//
//  ParticularsModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/28.
//
//

#import "ParticularsModel.h"
#import "ProjectStage.h"
@implementation ParticularsModel
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_id = [ProjectStage ProjectStrStage:dict[@"userId"]];
    self.a_company = [ProjectStage ProjectStrStage:dict[@"companyName"]];
    self.a_inDate = [ProjectStage ProjectTimeStage:dict[@"startTime"]];
    self.a_outDate = [ProjectStage ProjectTimeStage:dict[@"endTime"]];
    self.a_information = [ProjectStage ProjectStrStage:dict[@"workDesc"]];
    self.a_isIn = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isWorking"]]];
}
@end
