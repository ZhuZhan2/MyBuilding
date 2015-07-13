//
//  MyPointApi.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointApi.h"
#import "ConnectionAvailable.h"

@implementation MyPointApi
+ (NSURLSessionDataTask *)GetPointsLogWithBlock:(void (^)(NSMutableArray *, NSError *))block dic:(NSMutableDictionary *)dic noNetWork:(void (^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/require/pageRequire?pageSize=20&pageIndex=0"];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        //        NSLog(@"JSON[@\"data\"][@\"rows\"]===>%@",JSON[@"data"][@"rows"]);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
//            for(NSDictionary *item in JSON[@"data"][@"rows"]){
//                MarketModel *model = [[MarketModel alloc] init];
//                [model setDict:item];
//                [mutablePosts addObject:model];
//            }
//            if (block) {
//                block([NSMutableArray arrayWithArray:mutablePosts],JSON[@"data"][@"total"] ,nil);
//            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"errorMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
//        if (block) {
//            block([NSMutableArray array],nil ,error);
//        }
    }];
}

+ (NSURLSessionDataTask *)GetPointDetailWithBlock:(void (^)(NSMutableDictionary *dict, NSError *error))block  noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/points/getPoints"];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        if ([JSON[@"status"][@"statusCode"] isEqualToString:@"200"]) {
            if (block) {
                block(JSON[@"data"] ,nil);
            }
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block(nil, error);
        }
    }];
}
@end
