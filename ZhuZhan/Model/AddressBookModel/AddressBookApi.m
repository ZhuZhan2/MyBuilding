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
#import "ReceiveApplyFreindModel.h"
#import "FriendModel.h"
@implementation AddressBookApi
+ (NSURLSessionDataTask *)GetAddressBookListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block keywords:(NSString *)keywords noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/getContactsUserList?keywords=%@",keywords];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"data"]){
                AddressBookModel *ABModel = [[AddressBookModel alloc] init];
                [ABModel setDict:item];
                for(NSDictionary *item2 in item[@"groupUsers"]){
                    AddressBookContactModel *contactModel = [[AddressBookContactModel alloc] init];
                    [contactModel setDict:item2];
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

+ (NSURLSessionDataTask *)PostSendFriendRequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/sendFriendRequest"];
    NSLog(@"urlStr==%@",urlStr);

    return  [[AFAppDotNetAPIClient sharedNewClient]POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            if (block) {
                block(nil,nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"errorMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==>%@",error);
    }];
}

+ (NSURLSessionDataTask *)GetFriendRequestListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block pageIndex:(int)pageIndex noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/getFriendRequestList?pageIndex=%d&pageSize=15",pageIndex];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for (NSDictionary* dic in JSON[@"data"][@"rows"]) {
                ReceiveApplyFreindModel* model=[[ReceiveApplyFreindModel alloc]init];
                model.dic=dic;
                [mutablePosts addObject:model];
            }
            if (block) {
                block(mutablePosts, nil);
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

+ (NSURLSessionDataTask *)PostAgreeFriendWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/agreeFriend"];
    NSLog(@"urlStr==%@,%@",urlStr,dic);
    
    return  [[AFAppDotNetAPIClient sharedNewClient]POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if ([JSON[@"status"][@"statusCode"] isEqualToString:@"200"]) {
            if (block) {
                block(nil,nil);
            }
        }else{
            NSLog(@"error==%@",
                  JSON[@"status"][@"errorMsg"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==>%@",error);
    }];
}

+ (NSURLSessionDataTask *)DelFriendRequestListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/delFriendRequestList"];
    NSLog(@"urlStr==%@",urlStr);
    
    return  [[AFAppDotNetAPIClient sharedNewClient]POST:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if ([JSON[@"status"][@"statusCode"] isEqualToString:@"200"]) {
            if (block) {
                block(nil,nil);
            }
        }else{
            NSLog(@"error==%@",
                  JSON[@"status"][@"errorMsg"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==>%@",error);
    }];
}

+ (NSURLSessionDataTask *)DelSingleFriendRequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/delSingleFriendRequest"];
    NSLog(@"urlStr==%@",urlStr);
    
    return  [[AFAppDotNetAPIClient sharedNewClient]POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if ([JSON[@"status"][@"statusCode"] isEqualToString:@"200"]) {
            if (block) {
                block(nil,nil);
            }
        }else{
            NSLog(@"error==%@",
                  JSON[@"status"][@"errorMsg"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==>%@",error);
    }];
}

+ (NSURLSessionDataTask *)UpdateNickNameWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/updateNickName"];
    NSLog(@"urlStr==%@",urlStr);
    NSLog(@"dic==%@",dic);
    
    return  [[AFAppDotNetAPIClient sharedNewClient]POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if ([JSON[@"status"][@"statusCode"] isEqualToString:@"200"]) {
            if (block) {
                block(nil,nil);
            }
        }else{
            NSLog(@"error==%@",
                  JSON[@"status"][@"errorMsg"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==>%@",error);
    }];
}

+ (NSURLSessionDataTask *)DeleteContactsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void (^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/contacts/deleteContacts"];
    NSLog(@"urlStr==%@",urlStr);
    
    return  [[AFAppDotNetAPIClient sharedNewClient]POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if ([JSON[@"status"][@"statusCode"] isEqualToString:@"200"]) {
            if (block) {
                block(nil,nil);
            }
        }else{
            NSLog(@"error==%@",
                  JSON[@"status"][@"errorMsg"]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error==>%@",error);
    }];
}

+ (NSURLSessionDataTask *)GetUserRecommendInfoWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/recommend/getUserRecommendInfo?pageIndex=%d&pageSize=15",startIndex];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for (NSDictionary* item in JSON[@"data"][@"rows"]) {
                FriendModel *model = [[FriendModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block(mutablePosts, nil);
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

+ (NSURLSessionDataTask *)SearchUserWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block keywords:(NSString *)keywords startIndex:(int)startIndex noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/search?keywords=%@&pageIndex=%d&pageSize=15",keywords,startIndex];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for (NSDictionary* item in JSON[@"data"][@"rows"]) {
                FriendModel *model = [[FriendModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block(mutablePosts, nil);
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
