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
+ (NSURLSessionDataTask *)GetIsFocusedListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId targetId:(NSString *)targetId EntityCategory:(NSString *)EntityCategory noNetWork:(void(^)())noNetWork;
@end
