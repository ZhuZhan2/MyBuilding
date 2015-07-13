//
//  MyPointApi.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointApi.h"
#import "ConnectionAvailable.h"
#import "MyPointHistoryModel.h"
@implementation MyPointApi
+ (NSURLSessionDataTask *)GetPointsLogWithBlock:(void (^)(NSMutableArray *, NSError *))block dic:(NSMutableDictionary *)dic startIndex:(NSInteger)startIndex noNetWork:(void (^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/points/getPointsLog?pageIndex=%d&pageSize=15&datetime=%@",(int)startIndex,dic[@"datetime"]];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"data"][@"rows"]){
                MyPointHistoryModel *model = [[MyPointHistoryModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts] ,nil);
            }
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
