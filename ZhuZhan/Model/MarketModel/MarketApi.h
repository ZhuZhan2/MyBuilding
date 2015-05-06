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
@end
