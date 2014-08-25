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
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex;

//获取单个项目
+ (NSURLSessionDataTask *)SingleProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId;

//添加项目
+ (NSURLSessionDataTask *)AddProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//修改项目
+ (NSURLSessionDataTask *)UpdateProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//高级搜索
+ (NSURLSessionDataTask *)AdvanceSearchProjectsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic startIndex:(int)startIndex;

//查询评论
+ (NSURLSessionDataTask *)GetPiProjectCommentWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId;

//添加评论
+ (NSURLSessionDataTask *)PostAddPiProjectCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//查询项目动态
+ (NSURLSessionDataTask *)GetPiProjectLogsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId;
@end
