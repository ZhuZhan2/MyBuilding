//
//  ChoseContctApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/10.
//
//

#import <Foundation/Foundation.h>

@interface ChoseContctApi : NSObject
//获取联系人
+ (NSURLSessionDataTask *)GetContactsListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork;
@end
