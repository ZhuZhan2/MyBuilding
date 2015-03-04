//
//  CommentApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <Foundation/Foundation.h>

@interface CommentApi : NSObject
//查询评论
+ (NSURLSessionDataTask *)GetEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block entityId:(NSString *)entityId entityType:(NSString *)entityType noNetWork:(void(^)())noNetWork;

//添加评论
+ (NSURLSessionDataTask *)AddEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//删除评论
+ (NSURLSessionDataTask *)DelEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block entityId:(NSString *)entityId entityType:(NSString *)entityType noNetWork:(void(^)())noNetWork;

//添加动态
+ (NSURLSessionDataTask *)SendActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//通过人脉的url获取项目详情
+ (NSURLSessionDataTask *)CommentUrlWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block url:(NSString *)url noNetWork:(void(^)())noNetWork;

//获取个人中心详情
+ (NSURLSessionDataTask *)PersonalActiveWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取人的统计
+ (NSURLSessionDataTask *)UserBriefInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void (^)())noNetWork;
@end
