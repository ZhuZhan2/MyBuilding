//
//  ContractsSalerModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "ContractsSalerModel.h"

@implementation ContractsSalerModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.a_id=dict[@"id"];
    self.a_status=[dict[@"status"] integerValue];
}
@end
