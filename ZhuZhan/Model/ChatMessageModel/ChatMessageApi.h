//
//  ChatMessageApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import <Foundation/Foundation.h>

@interface ChatMessageApi : NSObject
//创建群
+ (NSURLSessionDataTask *)CreateWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
