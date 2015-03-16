//
//  LoginModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import "LoginModel.h"
#import "AFAppDotNetAPIClient.h"
#import "ContactModel.h"
#import "ProjectStage.h"
#import "ConnectionAvailable.h"
#import "EmployeesModel.h"
@implementation LoginModel
- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.a_userId = [ProjectStage ProjectStrStage:dict[@"userId"]];
    self.a_deviceToken = [ProjectStage ProjectStrStage:dict[@"token"]];
    self.a_userName = [ProjectStage ProjectStrStage:dict[@"loginName"]];
    if([dict[@"userType"] isEqualToString:@"01"]){
        self.a_userType = @"Personal";
    }else{
        self.a_userType = @"Company";
    }
    //self.a_loginStatus = [ProjectStage ProjectStrStage:dict[@"loginStatus"]];
    if(![[ProjectStage ProjectStrStage:dict[@"head"]] isEqualToString:@""]){
        self.a_userImage = [NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"head"]], @"login", @"", @"", @"")];
    }else{
        self.a_userImage = [ProjectStage ProjectStrStage:dict[@"head"]];
    }
    if(![[ProjectStage ProjectStrStage:dict[@"background"]] isEqualToString:@""]){
        self.a_backgroundImage=[NSString stringWithFormat:@"%s%@",serverAddress,image([ProjectStage ProjectStrStage:dict[@"background"]], @"login", @"", @"", @"")];
    }else{
        self.a_backgroundImage=[ProjectStage ProjectStrStage:dict[@"background"]];
    }
    //self.a_hasCompany = [ProjectStage ProjectStrStage:[NSString stringWithFormat:@"%@",dict[@"hasCompany"]]];
}

+ (NSURLSessionDataTask *)GenerateWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/generate"];
    NSLog(@"%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            if (block) {
                block(nil, nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"1331"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送太频繁请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码发送失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)VerifyCodeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/validCaptcha?cellPhone=%@&captcha=%@",dic[@"cellPhone"],dic[@"code"]];
    NSLog(@"%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            if (block) {
                block(nil, nil);
            }
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"验证码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)RegisterWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/register"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSLog(@"JSON===>%@",JSON[@"status"][@"errorMsg"]);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            if (block) {
                block([NSMutableArray array], nil);
            }
            NSNumber *errorcode = JSON[@"status"][@"statusCode"];
            switch ([errorcode intValue]) {
                case 11002:
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"register" object:@"手机号已存在"];
                    break;
                case 11017:
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"register" object:@"用户名已经存在"];
                    break;
                case 11005:
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"register" object:@"验证码错误"];
                    break;
                case 11006:
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"register" object:@"验证码过期"];
                    break;
                default:
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"register" object:@"注册失败，系统异常"];
                    break;
            }
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)LoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/login"];
    NSLog(@"dic===>%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            LoginModel *model = [[LoginModel alloc] init];
            [model setDict:JSON[@"data"]];
            [mutablePosts addObject:model];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            if (block) {
                block([NSMutableArray array], nil);
            }

            NSNumber *errorcode = JSON[@"status"][@"statusCode"];
            switch ([errorcode intValue]) {
                case 11018:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或手机号不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                case 1321:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你已经被拉黑" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                case 1322:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你已经禁止登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                case 11023:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                case 11017:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名已存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                default:
                    break;
            }
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)LogoutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/logout"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"mobile" forKey:@"deviceType"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON==>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
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

+ (NSURLSessionDataTask *)PostFaceLoginWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/Account/FaceLogin"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)PostLogOutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/Account/LogOut"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}


+ (NSURLSessionDataTask *)RegisterFaceWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/faceregister"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSLog(@"JSON===>%@",JSON);
        NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
        [mutablePosts addObject:JSON];
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


//完善用户信息
+ (NSURLSessionDataTask *)PostInformationImprovedWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSLog(@"%@",dic);
    NSString *urlStr = [NSString stringWithFormat:@"api/account/updateInformation"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]] isEqualToString:@"200"]){
            if(block){
                block(nil,nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

+ (NSURLSessionDataTask *)UpdateUserParticularsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/UserInformation/UpdateUserParticulars"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSString *statusCode = [[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]) {
            if(block){
                block(nil,nil);
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

+ (NSURLSessionDataTask *)AddUserParticularsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/addparticulars"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSString *statusCode = [[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]) {
            if(block){
                block(nil,nil);
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

+ (NSURLSessionDataTask *)GetUserInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/userDetails?userId=%@",userId];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"获取用户信息");
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            ContactModel *model = [[ContactModel alloc] init];
            [model setDict:JSON[@"data"]];
            [mutablePosts addObject:model];
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

+ (NSURLSessionDataTask *)AddUserImageWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block data:(NSData *)data dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/addUserImage"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"userImageStrings" fileName:@"userAvatar.jpg" mimeType:@"image/jpg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject ==> %@",responseObject);
        if (block) {
            block([NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%s%@",serverAddress,image(responseObject[@"data"], @"login", @"", @"", @"")], nil], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)AddBackgroundImageWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block data:(NSData *)data dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/addBackgroundImage"];
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"backgroundImageString" fileName:@"userBackground.jpg" mimeType:@"image/jpg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject ==> %@",responseObject);
        if (block) {
            block([NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%s%@",serverAddress,image(responseObject[@"data"], @"login", @"", @"", @"")], nil], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}


+ (NSURLSessionDataTask *)GetUserImagesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/userImages"];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject[@"data"]);
        if (block) {
            block([NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%s%@",serverAddress,responseObject[@"data"]], nil], nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)ChangePasswordWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/changePassword"];
    NSLog(@"dic==%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            NSNumber *errorcode = JSON[@"status"][@"statusCode"];
            switch ([errorcode intValue]) {
                case 11023:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"原密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                default:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"系统异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

+ (NSURLSessionDataTask *)GetRecommendUsersWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"api/Recommend/RecommendUsers?pageSize=50&pageIndex=%d",startIndex];
    NSLog(@"=====%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"d"][@"data"]){
                EmployeesModel *model = [[EmployeesModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1302"]){
            if (block) {
                block(nil, nil);
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

+ (NSURLSessionDataTask *)GetIsExistWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userName:(NSString*)userName noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    userName=userName?userName:@"";

    NSString *urlStr = [NSString stringWithFormat:@"api/account/isExist?userNameOrCellPhone=%@",userName];
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
    NSLog(@"urlStr==%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:encodedString parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if (block) {
            block([NSMutableArray arrayWithObjects:JSON[@"status"] ,nil],nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)FindPasswordWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/resetPassword"];
    NSLog(@"dic==%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            NSNumber *errorcode = JSON[@"status"][@"statusCode"];
            switch ([errorcode intValue]) {
                case 11018:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                case 11005:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                case 11006:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码过期" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
                default:
                {UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"系统异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];}
                    break;
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}

+ (NSURLSessionDataTask *)GetPhoneWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userName:(NSString*)userName noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    userName=userName?userName:@"";
    
    NSString *urlStr = [NSString stringWithFormat:@"api/account/cellPhone?userNameOrCellPhone=%@",userName];
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
    NSLog(@"urlStr==%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:encodedString parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if (block) {
            block([NSMutableArray arrayWithObjects:JSON,nil],nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}
@end
