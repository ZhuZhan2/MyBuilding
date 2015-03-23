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
@end
