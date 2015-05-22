//
//  ForcedUpdateApi.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/15.
//
//

#import "ForcedUpdateApi.h"
#import "ConnectionAvailable.h"

@implementation ForcedUpdateApi

+ (NSURLSessionDataTask *)GetLastestReleaseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userVersion:(NSString*)userVersion deviceType:(NSString*)deviceType downloadType:(NSString*)downloadType noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"api/release/getLastestRelease?userVersion=%@&deviceType=%@&downloadType=%@",userVersion,deviceType,downloadType];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        if (block) {
            block([NSMutableArray arrayWithObject:[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]],nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

@end
