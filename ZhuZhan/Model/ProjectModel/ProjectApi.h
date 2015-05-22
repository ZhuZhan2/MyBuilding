//
//  ProjectApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import <Foundation/Foundation.h>

@interface ProjectApi : NSObject
//获取项目列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取单个项目
+ (NSURLSessionDataTask *)SingleProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId noNetWork:(void(^)())noNetWork;

//获取本地项目
+ (NSURLSessionDataTask *)LocalProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectIds:(NSString *)projectIds noNetWork:(void(^)())noNetWork;

//添加项目
+ (NSURLSessionDataTask *)AddProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//修改项目
+ (NSURLSessionDataTask *)UpdateProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//高级搜索
+ (NSURLSessionDataTask *)AdvanceSearchProjectsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//查询项目动态
+ (NSURLSessionDataTask *)GetPiProjectLogsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId noNetWork:(void(^)())noNetWork;

//添加搜索条件
+ (NSURLSessionDataTask *)SearchConditionWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//更新查询次数
+ (NSURLSessionDataTask *)SearchCountAddWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取搜索条件，热门搜索
+ (NSURLSessionDataTask *)GetSearchConditionsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void(^)())noNetWork;

//项目普通搜索
+ (NSURLSessionDataTask *)GetPiProjectSeachWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex keywords:(NSString *)keywords noNetWork:(void(^)())noNetWork;

//获取专题
+ (NSURLSessionDataTask *)GetPiProjectSeminarWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取获取专题项目
+ (NSURLSessionDataTask *)GetSeminarProjectsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block Id:(NSString *)Id startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//删除搜索条件
+ (NSURLSessionDataTask *)DeleteSearchConditionsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//地图搜索 精度,维度
+ (NSURLSessionDataTask *)GetMapSearchWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block longitude:(NSString*)longitude latitude:(NSString*)latitude radius:(NSString *)radius startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取推荐项目
+ (NSURLSessionDataTask *)GetRecommenddProjectsWithBlock:(void (^)(NSMutableArray *posts,int count ,NSError *error))block startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//我的项目
+ (NSURLSessionDataTask *)GetMyProjectsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//项目搜索
+ (NSURLSessionDataTask *)SearchProjectsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId keywords:(NSString *)keywords projectIds:(NSString *)projectIds startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;
@end
