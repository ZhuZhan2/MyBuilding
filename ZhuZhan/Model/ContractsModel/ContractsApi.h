//
//  ContractsApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import <Foundation/Foundation.h>

@interface ContractsApi : NSObject
//发起佣金
+ (NSURLSessionDataTask *)PostContractWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//修改主条款
+ (NSURLSessionDataTask *)PostUpdateWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取所有列表
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block keyWords:(NSString*)keyWords archiveStatus:(NSString*)archiveStatus contractsType:(NSString*)contractsType startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//主条款详情//供应商合同详情
+ (NSURLSessionDataTask *)PostDetailWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//同意主条款
+ (NSURLSessionDataTask *)PostAgreeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//不同意主条款
+ (NSURLSessionDataTask *)PostDisagreeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//关闭主条款
+ (NSURLSessionDataTask *)PostCloseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//同意供应商佣金合同
+ (NSURLSessionDataTask *)PostCommissionAgreeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//不同意供应商佣金合同
+ (NSURLSessionDataTask *)PostCommissionDisagreeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//关闭供应商佣金合同模板
+ (NSURLSessionDataTask *)PostCommissionCloseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//上传供应商佣金合同模板
+ (NSURLSessionDataTask *)PostCommissionUploadWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//同意销售佣金合同
+ (NSURLSessionDataTask *)PostSalesAgreeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//不同意供应商佣金合同
+ (NSURLSessionDataTask *)PostSalesDisagreeWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//关闭供应商佣金合同模板
+ (NSURLSessionDataTask *)PostSalesCloseWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//销售佣金合同详情
+ (NSURLSessionDataTask *)PostSalesDetailWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//撤销合同详情
+ (NSURLSessionDataTask *)PostRevocationDetailWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;
@end
