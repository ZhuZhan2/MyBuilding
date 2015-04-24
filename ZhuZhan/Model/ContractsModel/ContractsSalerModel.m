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
    self.a_fileName=dict[@"fileName"];
    self.a_status=[dict[@"status"] integerValue];
    self.a_serialNumber=dict[@"serialNumber"];
    self.a_contractsRecordId=dict[@"contractsRecordId"];
    {
        NSString* createdTime=dict[@"createdTime"];
        self.a_createdTime=[createdTime substringToIndex:createdTime.length-3];
    }
}
@end
