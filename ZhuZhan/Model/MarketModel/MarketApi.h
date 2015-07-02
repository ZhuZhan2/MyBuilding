//
//  MarketApi.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import <Foundation/Foundation.h>

@interface MarketApi : NSObject
//上传供应商佣金合同模板
+ (NSURLSessionDataTask *)AddWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取首页20条需求列表
+ (NSURLSessionDataTask *)GetPageRequireListWithBlock:(void (^)(NSMutableArray *posts,NSString *total,NSError *error))block noNetWork:(void(^)())noNetWork;

//获取所有公开需求列表
+ (NSURLSessionDataTask *)GetAllPublicListWithBlock:(void (^)(NSMutableArray *posts,NSError *error))block startIndex:(int)startIndex requireType:(NSString *)requireType keywords:(NSString *)keywords noNetWork:(void(^)())noNetWork;

//获取所有我的需求列表
+ (NSURLSessionDataTask *)GetAllMyListWithBlock:(void (^)(NSMutableArray *posts,NSError *error))block startIndex:(int)startIndex requireType:(NSString *)requireType keywords:(NSString *)keywords isOpen:(NSString *)isOpen noNetWork:(void(^)())noNetWork;

//添加需求
+ (NSURLSessionDataTask *)AddRequireWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//需求详情
+ (NSURLSessionDataTask *)GetRequireInfoWithBlock:(void (^)(NSMutableArray *posts,NSError *error))block reqId:(NSString*)reqId noNetWork:(void(^)())noNetWork;

//获取评论列表
+ (NSURLSessionDataTask *)GetCommentListWithBlock:(void (^)(NSMutableArray *posts,NSString *total,NSError *error))block startIndex:(int)startIndex paramId:(NSString *)paramId commentType:(NSString *)commentType noNetWork:(void(^)())noNetWork;

//删除需求
+ (NSURLSessionDataTask *)DelRequireWithBlock:(void (^)(NSMutableArray *posts,NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

//获取banner图
+ (NSURLSessionDataTask *)GetBannerImagesWithBlock:(void (^)(NSMutableArray *posts,NSError *error))block noNetWork:(void(^)())noNetWork;
@end
