//
//  IsFocusedApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/8.
//
//

#import <Foundation/Foundation.h>

@interface IsFocusedApi : NSObject
//是否关注
+ (NSURLSessionDataTask *)GetIsFocusedListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId targetId:(NSString *)targetId noNetWork:(void(^)())noNetWork;

//添加关注
+ (NSURLSessionDataTask *)AddFocusedListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block  dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取关注的人列表
+ (NSURLSessionDataTask *)GetPersonalFocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取关注的人列表
+ (NSURLSessionDataTask *)GetCompanyFocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取关注的项目列表
+ (NSURLSessionDataTask *)GetProjectFocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取关注的产品列表
+ (NSURLSessionDataTask *)GetProductFocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;
@end
