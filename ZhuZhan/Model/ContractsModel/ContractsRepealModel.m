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
    self.a_status=[dict[@"status"] integerValue];
}
@end
