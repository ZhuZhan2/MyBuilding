//
//  MarketApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import <Foundation/Foundation.h>

@interface MarketApi : NSObject
//上传供应商佣金合同模板
+ (NSURLSessionDataTask *)AddWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取首页20条需求列表
+ (NSURLSessionDataTask *)GetPageRequireListWithBlock:(void (^)(NSMutableArray *posts,NSString *total,NSError *error))block noNetWork:(void(^)())noNetWork;

//获取所有公开需求列表
+ (NSURLSessionDataTask *)GetAllPublicListWithBlock:(void (^)(NSMutableArray *posts,NSError *error))block startIndex:(int)startIndex requireType:(NSString *)requireType keywords:(NSString *)keywords noNetWork:(void(^)())noNetWork;
@end
