//
//  CommentApi.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentApi.h"
#import "AFAppDotNetAPIClient.h"
#import "ContactCommentModel.h"
#import "ActivesModel.h"
#import "PersonalCenterModel.h"
#import "ConnectionAvailable.h"
@implementation CommentApi
+ (NSURLSessionDataTask *)GetEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block entityId:(NSString *)entityId entityType:(NSString *)entityType startIndex:(int)startIndex noNetWork:(void (^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/comment/listComment?paramId=%@&commentType=%@&pageSize=10&pageIndex=%d",entityId,entityType,startIndex];
    NSLog(@"===>%@",urlStr);
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"data"][@"rows"]){
                ContactCommentModel *model = [[ContactCommentModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
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

+ (NSURLSessionDataTask *)AddEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/comment/addComment"];
    NSLog(@"%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"data"]];
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

+ (NSURLSessionDataTask *)DelEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/comment/delComment"];
    NSLog(@"%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            if (block) {
                block([NSMutableArray arrayWithArray:nil], nil);
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

/*
 1. EntityID:用户或者项目ID
 2. ActiveText:动态文字
 3. ActivePicture:动态图片名字，包含后缀
 4. PictureStrings:图片内容，base64 无头
 5. Type:类型，Personal or Project
 */
+ (NSURLSessionDataTask *)SendActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic imgData:(NSData *)imgData noNetWork:(void(^)())noNetWork
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/dynamicInfo/addDynamicInfo"];
    NSLog(@"%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if(imgData !=nil){
            [formData appendPartWithFileData:imgData name:@"dynamicImageString" fileName:@"active.jpg" mimeType:@"image/jpg"];
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject ==> %@",responseObject);
        if([[NSString stringWithFormat:@"%@",responseObject[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            if (block) {
                block([NSMutableArray arrayWithObjects:responseObject[@"status"][@"statusCode"], nil], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];

}

+ (NSURLSessionDataTask *)CommentUrlWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block url:(NSString *)url noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    return [[AFAppDotNetAPIClient sharedNewClient] GET:url parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"d"][@"data"]){
                ActivesModel* model=[[ActivesModel alloc]init];
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

+ (NSURLSessionDataTask *)PersonalActiveWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId startIndex:(int)startIndex noNetWork:(void(^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/message/getMessageList?pageSize=15&pageIndex=%d",startIndex];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"data"][@"rows"]){
                PersonalCenterModel* model=[[PersonalCenterModel alloc]init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"status"][@"errorMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}


+ (NSURLSessionDataTask *)UserBriefInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block userId:(NSString *)userId noNetWork:(void (^)())noNetWork{
    if (![ConnectionAvailable isConnectionAvailable]) {
        if (noNetWork) {
            noNetWork();
        }
        return nil;
    }
    NSString *urlStr = [NSString stringWithFormat:@"api/account/UserBriefInformation?userId=%@",userId];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"status"][@"statusCode"]]isEqualToString:@"200"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"d"][@"data"]];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1302"]){
            
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
