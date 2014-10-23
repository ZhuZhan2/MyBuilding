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
+ (NSURLSessionDataTask *)GetCompanyListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block startIndex:(int)startIndex keyWords:(NSString *)keyWords;

//申请认证
+ (NSURLSessionDataTask *)AddCompanyEmployeeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//我的公司
+ (NSURLSessionDataTask *)GetMyCompanyWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block;

//获取员工列表
+ (NSURLSessionDataTask *)GetCompanyEmployeesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block companyId:(NSString *)companyId startIndex:(int)startIndex keyWords:(NSString *)keyWords;

@end
