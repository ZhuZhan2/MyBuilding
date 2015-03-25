//
//  AskPriceApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/20.
//
//

#import <Foundation/Foundation.h>

@interface AskPriceApi : NSObject
//发起询价
+ (NSURLSessionDataTask *)PostAskPriceWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取列表 00自己发起的询价 01别人给你发得询价
+ (NSURLSessionDataTask *)GetAskPriceWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block status:(NSString *)status startIndex:(int)startIndex other:(NSString *)other keyWorks:(NSString *)keyWorks noNetWork:(void(^)())noNetWork;

//获取询价列表详情
+ (NSURLSessionDataTask *)GetAskPriceDetailsWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block tradeId:(NSString *)tradeId noNetWork:(void(^)())noNetWork;

//报价
+ (NSURLSessionDataTask *)AddQuotesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//报价列表
+ (NSURLSessionDataTask *)GetQuotesListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block providerId:(NSString *)providerId tradeCode:(NSString *)tradeCode startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//回复
+ (NSURLSessionDataTask *)AddCommentWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//接受报价
+ (NSURLSessionDataTask *)AcceptQuotesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//关闭报价
+ (NSURLSessionDataTask *)CloseQuotesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//回复列表
+ (NSURLSessionDataTask *)GetCommentListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block tradeId:(NSString *)tradeId tradeUserAndCommentUser:(NSString *)tradeUserAndCommentUser startIndex:(int)startIndex noNetWork:(void(^)())noNetWork;

//上传附件
+ (NSURLSessionDataTask *)AddAttachmentWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dataArr:(NSMutableArray *)dataArr dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取分类
+ (NSURLSessionDataTask *)GetChildsListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block parentId:(NSString *)parentId noNetWork:(void(^)())noNetWork;

//获取用户及公司列表
+ (NSURLSessionDataTask *)GetUserOrCompanyListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block keyWorks:(NSString *)keyWorks noNetWork:(void(^)())noNetWork;
@end
