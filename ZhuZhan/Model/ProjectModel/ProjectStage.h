//
//  ProjectStage.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <Foundation/Foundation.h>
#import "projectModel.h"
@interface ProjectStage : NSObject
//字符串的处理
+(NSString *)ProjectStrStage:(NSString *)str;

//时间的处理
+(NSString *)ProjectTimeStage:(NSString *)str;

+(NSDate *)ProjectDateStage:(NSString *)str;

+(NSString *)ProjectNewTimeStage:(NSString *)str;

+(NSString *)ChatMessageTimeStage:(NSString *)str;

//bool的处理
+(NSString *)ProjectBoolStage:(NSString *)str;

//判断项目阶段
+(NSString *)JudgmentProjectStage:(projectModel *)model;

//判断项目详细阶段,给展示页用
+(NSArray*)JudgmentProjectDetailStage:(projectModel*)model;

//处理高级搜索的搜索条件
+(NSString *)SearchProjectStage:(NSString *)str;

//处理金额的方法
+(NSString *)stringtoRBM:(NSString *)text;

//判断业主类型
//+(NSString *)JudgeOwenType:(NSString *)str;
@end
