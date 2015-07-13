//
//  MyPointHistoryModel.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointHistoryModel.h"

@implementation MyPointHistoryModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    /**
     points	影响积分数
     action	操作符号
     createdTime 时间
     reason	备注/原因
     source	来源分类
     sourceCn 来源转义
     */
    self.a_points = dict[@"points"];
    self.a_action = dict[@"action"];
    self.a_createdTime = dict[@"createdTime"];
    self.a_reason = dict[@"reason"];
    self.a_source = dict[@"source"];
    self.a_sourceCn = dict[@"sourceCn"];
}
@end
