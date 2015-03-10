//
//  AddressBookApi.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import "AddressBookApi.h"
#import "ConnectionAvailable.h"
#import "AddressBookModel.h"
#import "LoginSqlite.h"
@implementation AddressBookApi
+ (NSURLSessionDataTask *)GetAddressBookListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork{
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
            for(int i=0;i<5;i++){
                AddressBookModel *ABModel = [[AddressBookModel alloc] init];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
                [dic setObject:[NSString stringWithFormat:@"test%d",i] forKey:@"name"];
                [ABModel setDict:dic];
                for(int j=0;j<5;j++){
                    AddressBookContactModel *contactModel = [[AddressBookContactModel alloc] init];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:[NSString stringWithFormat:@"%d",j] forKey:@"id"];
                    [dic setObject:[NSString stringWithFormat:@"test里的%d",j] forKey:@"name"];
                    [dic setObject:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg" forKey:@"head"];
                    [contactModel setDict:dic];
                    [ABModel.contactArr addObject:contactModel];
                }
                [mutablePosts addObject:ABModel];
            }
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
