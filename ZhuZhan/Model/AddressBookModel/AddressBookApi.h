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
+ (NSURLSessionDataTask *)GetFriendRequestListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block pageIndex:(int)pageIndex noNetWork:(void(^)())noNetWork;

//同意一个好友申请请求
+ (NSURLSessionDataTask *)PostAgreeFriendWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//清空好友列表
+ (NSURLSessionDataTask *)DelFriendRequestListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block noNetWork:(void(^)())noNetWork;

//删除单条好友
+ (NSURLSessionDataTask *)DelSingleFriendRequestWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//修改联系人备注
+ (NSURLSessionDataTask *)UpdateNickNameWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//删除好友
+ (NSURLSessionDataTask *)DeleteContactsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
