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
#import "ConnectionAvailable.h"
#import "MyCenterModel.h"
#import "ParticularsModel.h"
#import "LoginSqlite.h"
@implementation ContactModel

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.userId = [ProjectStage ProjectStrStage:_dict[@"userId"]];
    self.userName = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"loginName"]]];
    self.realName = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"realName"]]];
    self.sex = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"sexCn"]]];
    self.birthday = [ProjectStage ProjectTimeStage:[_dict objectForKey:@"birthday"]];
    self.constellation = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"constel"]]];
    self.bloodType = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"bloodTypeCn"]]];
    self.email = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"email"]]];
    self.cellPhone = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"cellphone"]]];
    self.companyName = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",_dict[@"workHistory"][@"companyName"]]];
    self.position = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",_dict[@"workHistory"][@"duties"]]];
    self.userParticularsId = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",_dict[@"id"]]];
    self.password = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",[_dict objectForKey:@"password"]]];
    if(![[ProjectStage ProjectStrStage:dict[@"headImageId"]] isEqualToString:@""]){
        self.userImage = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"headImageId"]], @"login", @"", @"", @"")];
    }else{
        self.userImage = [ProjectStage ProjectStrStage:dict[@"headImageId"]];
    }
    self.provice = [ProjectStage ProjectStrStage:dict[@"landProvince"]];
    self.city = [ProjectStage ProjectStrStage:dict[@"landCity"]];
    self.district = [ProjectStage ProjectStrStage:dict[@"landDistrict"]];
    if(![[ProjectStage ProjectStrStage:dict[@"backgroundImageId"]] isEqualToString:@""]){
        self.personalBackground=[NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"backgroundImageId"]], @"login", @"", @"", @"")];
    }else{
        self.personalBackground=[ProjectStage ProjectStrStage:dict[@"backgroundImageId"]];
    }
    self.industry = [ProjectStage ProjectStrStage:dict[@"industry"]];
}

//POST:
//{
//    "sourceUserId": "源用户Id" 必填
//     "targetUserId":"目标用户Id" 必填
//}
+ (NSURLSessionDataTask *)AddfriendsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
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
+ (NSURLSessionDataTask *)ProcessrequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
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
+ (NSURLSessionDataTask *)AddfocusWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    if ([dic[@"FocusId"] isEqualToString:[LoginSqlite getdata:@"userId"]] ) {
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/networking/addUserFocus"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"json====>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSLog(@"成功关注");
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1308"]){
            NSLog(@"已经关注");
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
+ (NSURLSessionDataTask *)AddtagWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
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

+ (NSURLSessionDataTask *)AllActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/ActiveCenter/Actives?UserId=%@&pageSize=5&pageIndex=%d",userId,startIndex];
    NSLog(@"+++++++=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        //NSLog(@"JSON===>%@",JSON[@"d"][@"data"][0][@"actives"][@"content"]);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
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

+ (NSURLSessionDataTask *)UserDetailsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/userDetails?userId=%@",userId];
    NSLog(@"%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            MyCenterModel *model = [[MyCenterModel alloc] init];
            [model setDict:JSON[@"data"]];
            [mutablePosts addObject:model];
            ParticularsModel *parModel = [[ParticularsModel alloc] init];
            if(![[NSString stringWithFormat:@"%@",JSON[@"data"][@"workHistory"]] isEqualToString:@"<null>"]){
                [parModel setDict:JSON[@"data"][@"workHistory"]];
                [mutablePosts addObject:parModel];
            }else{
                [mutablePosts addObject:@"null"];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"errorMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
