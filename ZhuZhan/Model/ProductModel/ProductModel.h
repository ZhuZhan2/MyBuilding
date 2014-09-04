//
//  ProductModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
//获取产品
+ (NSURLSessionDataTask *)GetProductInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block productId:(NSString *)productId startIndex:(int)startIndex;

//添加产品
+ (NSURLSessionDataTask *)AddProductInfomationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//发布产品信息
+ (NSURLSessionDataTask *)PublishProductInfomationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;
@end
