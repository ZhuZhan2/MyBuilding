//
//  IsFocusedApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/8.
//
//

#import <Foundation/Foundation.h>

@interface IsFocusedApi : NSObject
//获取所有公司列表
+ (NSURLSessionDataTask *)GetIsFocusedListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId targetId:(NSString *)targetId noNetWork:(void(^)())noNetWork;

//添加关注
+ (NSURLSessionDataTask *)AddFocusedListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block  dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
