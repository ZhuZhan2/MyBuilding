//
//  ChoseContctApi.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/10.
//
//

#import "ChoseContctApi.h"
#import "ConnectionAvailable.h"
#import "LoginSqlite.h"
#import "ChoseContactModel.h"
#import "pinyin.h"
@implementation ChoseContctApi
+ (NSURLSessionDataTask *)GetContactsListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/hasCompany?userId=%@",[LoginSqlite getdata:@"userId"]];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            NSArray *array = [[NSArray alloc] initWithObjects:@"张三",@"李四",@"王五",@"赵六",@"熊建武",@"陆贤明",nil];
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ChoseContactModel *model = [[ChoseContactModel alloc] init];
                model.a_chName = obj;
                model.a_enName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([obj characterAtIndex:0])] uppercaseString];
                [mutablePosts addObject:model];
            }];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"errorMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}
@end
