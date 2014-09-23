//
//  CommentApi.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "CommentApi.h"
#import "AFAppDotNetAPIClient.h"
#import "ProjectCommentModel.h"
@implementation CommentApi
+ (NSURLSessionDataTask *)GetEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block entityId:(NSString *)entityId entityType:(NSString *)entityType{
    NSString *urlStr = [NSString stringWithFormat:@"api/EntityComments/Get?entityId=%@&entityType=%@",entityId,entityType];
    return [[AFAppDotNetAPIClient sharedNewClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            for(NSDictionary *item in JSON[@"d"][@"data"]){
                ProjectCommentModel *model = [[ProjectCommentModel alloc] init];
                [model setDict:item];
                [mutablePosts addObject:model];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
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

// post参数：
// {
// "EntityId": ":entity ID", （项目，产品，公司，动态等）
// "entityType": ":”entityType", Personal,Company,Project,Product 之一
// "CommentContents": "评论内容",
// "CreatedBy": ":“评论人"
// }
+ (NSURLSessionDataTask *)AddEntityCommentsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic{
    NSString *urlStr = [NSString stringWithFormat:@"api/EntityComments/Add"];
    NSLog(@"%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON[@"d"][@"status"]];
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

/*
 1. EntityID:用户或者项目ID
 2. ActiveText:动态文字
 3. ActivePicture:动态图片名字，包含后缀
 4. PictureStrings:图片内容，base64 无头
 5. Type:类型，Personal or Project
 */
+ (NSURLSessionDataTask *)SendActivesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic
{
    NSString *urlStr = [NSString stringWithFormat:@"api/ActiveCenter/SendActives"];
    NSLog(@"%@",dic);
    return [[AFAppDotNetAPIClient sharedNewClient] POST:urlStr parameters:dic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        if([[NSString stringWithFormat:@"%@",JSON[@"d"][@"status"][@"statusCode"]]isEqualToString:@"1300"]){
            NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
            [mutablePosts addObject:JSON];
            if (block) {
                block([NSMutableArray arrayWithArray:mutablePosts], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:JSON[@"d"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
