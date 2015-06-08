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
/*
 deviceType
 安卓	02
 苹果	05
 */
/*
 downloadType
 苹果商城	01
 官网安装	02
 */
+ (NSURLSessionDataTask *)GetLastestReleaseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userVersion:(NSString*)userVersion deviceType:(NSString*)deviceType downloadType:(NSString*)downloadType noNetWork:(void(^)())noNetWork;
@end
