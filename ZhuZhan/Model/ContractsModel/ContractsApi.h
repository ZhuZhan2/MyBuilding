//
//  ContractsApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import <Foundation/Foundation.h>

@interface ContractsApi : NSObject
//发起佣金
+ (NSURLSessionDataTask *)PostContractWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取列表
+ (NSURLSessionDataTask *)GetContractsAllListsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block archiveStatus:(NSString *)archiveStatus startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//获取所有列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;
@end
