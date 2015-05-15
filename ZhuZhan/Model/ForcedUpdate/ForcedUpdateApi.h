//
//  ForcedUpdateApi.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/15.
//
//

#import <Foundation/Foundation.h>

@interface ForcedUpdateApi : NSObject
//判断是否有新版本
//downloadType 01 02
//deviceType 03
+ (NSURLSessionDataTask *)GetLastestReleaseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userVersion:(NSString*)userVersion deviceType:(NSString*)deviceType downloadType:(NSString*)downloadType noNetWork:(void(^)())noNetWork;
@end
