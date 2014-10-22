//
//  CompanyApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/10/20.
//
//

#import <Foundation/Foundation.h>

@interface CompanyApi : NSObject
//获取所有公司列表
+ (NSURLSessionDataTask *)GetCompanyListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex;

//申请认证
+ (NSURLSessionDataTask *)AddCompanyEmployeeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//我的公司
+ (NSURLSessionDataTask *)GetMyCompanyWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block;


@end
