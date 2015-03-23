//
//  AddressBookApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import <Foundation/Foundation.h>

@interface AddressBookApi : NSObject
//获取通讯录
+ (NSURLSessionDataTask *)GetAddressBookListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block keywords:(NSString *)keywords noNetWork:(void(^)())noNetWork;

//申请好友
+ (NSURLSessionDataTask *)PostSendFriendRequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取收到的申请好友请求列表
+ (NSURLSessionDataTask *)GetFriendRequestListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block pageIndex:(NSString *)pageIndex noNetWork:(void(^)())noNetWork;

//同意一个好友申请请求
+ (NSURLSessionDataTask *)PostAgreeFriendWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
