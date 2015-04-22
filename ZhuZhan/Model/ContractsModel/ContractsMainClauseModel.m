//
//  ContractsMainClauseModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "ContractsMainClauseModel.h"

@implementation ContractsMainClauseModel
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.a_contentMain=dict[@"contentMain"];
//    @property (nonatomic, copy)NSString* a_fileName;
//    @property (nonatomic)NSInteger a_status;
    self.a_fileName=dict[@"fileName"];
    self.a_status=[dict[@"status"] integerValue];
}
@end
