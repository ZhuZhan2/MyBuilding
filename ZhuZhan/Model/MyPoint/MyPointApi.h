//
//  MyPointApi.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import <Foundation/Foundation.h>

@interface MyPointApi : NSObject
+ (NSURLSessionDataTask *)GetPointsLogWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary*)dic noNetWork:(void(^)())noNetWork;
@end
