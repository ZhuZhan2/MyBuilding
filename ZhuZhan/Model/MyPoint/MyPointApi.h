//
//  MyPointApi.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import <Foundation/Foundation.h>
#import "PointDetailModel.h"

@interface MyPointApi : NSObject
//历史积分详情
+ (NSURLSessionDataTask *)GetPointsLogWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary*)dic startIndex:(NSInteger)startIndex noNetWork:(void(^)())noNetWork;

//获取积分详情
+ (NSURLSessionDataTask *)GetPointDetailWithBlock:(void (^)(PointDetailModel *model, NSError *error))block  noNetWork:(void(^)())noNetWork;

//签到
+ (NSURLSessionDataTask *)SignWithBlock:(void (^)(int todayPoint, NSError *error))block  noNetWork:(void(^)())noNetWork;
@end
