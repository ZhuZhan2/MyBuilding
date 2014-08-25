//
//  LoginModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "LoginModel.h"

@implementation LoginModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
     self.a_id = dict[@"userId"];
     self.a_userToken = dict[@"userToken"];
     self.a_deviceToken = dict[@"devicetoken"];
}


// post参数：
// {"cellPhone": ":@“143123123”}
// 
// RESPONSE:
//     {
//         "d": {
//             "status": {
//                 "statusCode": 1300
//             }
//         }
//     }

+ (NSURLSessionDataTask *)GenerateWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/code/generate"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}


// post参数：
// {
// "cellPhone": ":cellPhone",
// "password": ":”password",
// "deviceType": ":mobile || web",
// "barCode": ":“123123"
// }
// 
//
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        },
//        "data": [
//                 {
//                     "userId": "618e491f-2541-4467-80a8-6e0c6eb561ae",
//                     "userToken": "40f0571e-1764-4967-8808-8bd0bba6b471",
//                     "isFaceRegister": false,
//                     "faceCount": 0
//                 }
//                ]
//    }
//}
+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/account/register2"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//    "cellPhone": "13812312314",
//    "password": "1234",
//    "deviceType": ":mobile || web"
//}
//
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        },
//        "data": [
//                 {
//                     "userId": "d85b740b-f5ca-432b-86a6-422a0569f0d1",
//                     "userToken": "0b3af34d-e9b8-4455-9220-737e68470711",
//                     "devicetoken": null
//                 }
//                 ]
//    }
//}
+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/account/login"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            LoginModel *model = [[LoginModel alloc] init];
            [model setDict:JSON[@"d"][@"data"][0]];
            [mutablePosts addObject:model];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//  "userId":"用户id",
//  "faceId":"face++id"
//}
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        },
//        "data": [
//                 {
//                     "userId": "d85b740b-f5ca-432b-86a6-422a0569f0d1",
//                     "userToken": "0b3af34d-e9b8-4455-9220-737e68470711",
//                     "IsFaceRegister": "0",
//                     "FaceCount":"注册脸的个数"
//                 }
//                 ]
//    }
//}
+ (NSURLSessionDataTask *)PostFaceLoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/Account/PostFaceLogin"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//    "userId": "d85b740b-f5ca-432b-86a6-422a0569f0d1",
//    "deviceType": "web"
//}
//
//RESPONSE:
//{
//    "d": {
//        "status": {
//            "statusCode": 1300
//        }
//    }
//}
+ (NSURLSessionDataTask *)PostLogOutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/Account/PostLogOut"];
    return [[AFAppDotNetAPIClient sharedClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"result"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
