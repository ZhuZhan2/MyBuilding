//
//  AskPriceMessageApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/17.
//
//

#import <Foundation/Foundation.h>

@interface AskPriceMessageApi : NSObject
//获取所有列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block messageType:(NSString *)messageType  startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//删除消息
+ (NSURLSessionDataTask *)DeleteMessageWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
