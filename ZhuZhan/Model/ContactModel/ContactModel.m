//
//  ContactModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "ContactModel.h"
#import "AFAppDotNetAPIClient.h"
#import "ProjectStage.h"
#import "ActivesModel.h"
@implementation ContactModel



-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.userName = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"userName"]]];
    self.realName = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"fullName"]]];
    self.sex = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"sex"]]];
    self.locationProvice = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"locationProvince"]]];
    self.locationCity = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"locationCity"]]];
    self.birthday = [ProjectStage ProjectTimeStage:[_dict objectForKey:@"birthday"]];
    self.constellation = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"constellation"]]];
    self.bloodType = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"bloodType"]]];
    self.email = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"email"]]];
    self.cellPhone = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"cellPhone"]]];
    self.companyName = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"company"]]];
    self.position = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"duties"]]];
    self.password = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"password"]]];
}

//POST:
//{
//    "sourceUserId": "源用户Id" 必填
//     "targetUserId":"目标用户Id" 必填
//}
+ (NSURLSessionDataTask *)AddfriendsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/addfriends"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//POST:
//{
//    "sourceUserId": "源用户Id" 必填
//    "targetUserId":"目标用户Id" 必填
//    "isAgree":"true/false" 必填
//}
+ (NSURLSessionDataTask *)ProcessrequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/processrequest"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

//POST:
//{
//    "userId": ":"用户Id" 必填
//    "focusId":"关注的用户Id" 必填
//    "FocusType":"Company",
//    "UserType":"Company"
//}
+ (NSURLSessionDataTask *)AddfocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/addUserFocus"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"json====>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //[mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1308"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已关注" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

//POST:
//{
//    "userId": ":"用户Id" 必填
//    "targetUserId":"朋友的用户Id" 必填
//    "tagName":"标签名"
//}
+ (NSURLSessionDataTask *)AddtagWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/addtag"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)AllActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex{
    NSString *urlStr = [NSString stringWithFormat:@"api/ActiveCenter/Actives?UserId=%@&pageSize=10&pageIndex=%d",userId,startIndex];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        //NSLog(@"JSON===>%@",JSON[@"d"][@"data"][0][@"actives"][@"content"]);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"d"][@"data"]){
                ActivesModel *model = [[ActivesModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1302"]){
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

+ (NSURLSessionDataTask *)UserDetailsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId{
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/UserDetails?userId=%@",userId];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            //for(NSDictionary *item in JSON[@"d"][@"data"]){
                
            //}
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1302"]){
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}
@end
