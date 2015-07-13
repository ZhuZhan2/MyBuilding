//
//  MyPointHistoryModel.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import <Foundation/Foundation.h>

@interface MyPointHistoryModel : NSObject
/**
 points	影响积分数
 action	操作符号
 createdTime 时间
 reason	备注/原因
 source	来源分类
 sourceCn 来源转义
 */
@property (nonatomic, copy)NSString* a_points;
@property (nonatomic, copy)NSString* a_action;
@property (nonatomic, copy)NSString* a_createdTime;
@property (nonatomic, copy)NSString* a_reason;
@property (nonatomic, copy)NSString* a_source;
@property (nonatomic, copy)NSString* a_sourceCn;

@property (nonatomic, strong)NSDictionary* dict;
@end
