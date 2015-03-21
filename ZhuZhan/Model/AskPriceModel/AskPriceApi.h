//
//  AskPriceApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/20.
//
//

#import <Foundation/Foundation.h>

@interface AskPriceApi : NSObject
//发起询价
+ (NSURLSessionDataTask *)PostAskPriceWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取列表
+ (NSURLSessionDataTask *)GetAskPriceWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block status:(NSString *)status startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取询价列表详情
+ (NSURLSessionDataTask *)GetAskPriceDetailsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block tradeId:(NSString *)tradeId noNetWork:(void(^)())noNetWork;
@end
