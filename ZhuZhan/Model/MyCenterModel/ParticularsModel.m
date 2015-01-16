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
    self.a_id = [ProjectStage ProjectStrStage:dict[@"id"]];
    self.a_company = [ProjectStage ProjectStrStage:dict[@"companyName"]];
    self.a_inDate = [ProjectStage ProjectTimeStage:dict[@"inDate"]];
    self.a_outDate = [ProjectStage ProjectTimeStage:dict[@"outDate"]];
    self.a_information = [ProjectStage ProjectStrStage:dict[@"information"]];
    self.a_isIn = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"isIn"]]];
}
@end
