//
//  ContractsRepealModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/22.
//
//

#import "ContractsRepealModel.h"

@implementation ContractsRepealModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.a_id=dict[@"id"];
    self.a_fileName=dict[@"fileName"];
    {
        NSString* createdTime=dict[@"createdTime"];
        self.a_createdTime=[createdTime substringToIndex:createdTime.length-3];
    }
    self.a_serialNumber=dict[@"serialNumber"];
    self.a_content=dict[@"contents"];
    self.a_status=[dict[@"status"] integerValue];
}
@end
