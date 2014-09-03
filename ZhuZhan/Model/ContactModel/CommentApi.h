//
//  CommentApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import <Foundation/Foundation.h>

@interface CommentApi : NSObject
//查询评论
+ (NSURLSessionDataTask *)SingleProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block projectId:(NSString *)projectId;
@end
