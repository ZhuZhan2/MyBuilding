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
+ (NSURLSessionDataTask *)GetEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block entityId:(NSString *)entityId entityType:(NSString *)entityType;

//添加评论
+ (NSURLSessionDataTask *)AddEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//添加动态
+ (NSURLSessionDataTask *)SendActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;
@end
