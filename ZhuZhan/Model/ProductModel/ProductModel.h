//
//  ProductModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic,copy) NSString *a_id;
//名字
@property (nonatomic,copy) NSString *a_name;
//内容
@property (nonatomic,copy) NSString *a_content;
//图片
@property (nonatomic,copy) NSString *a_imageUrl;
//评论数
@property (nonatomic,copy) NSString *a_commentNumber;

@property (nonatomic, copy) NSDictionary *dict;



//获取产品
+ (NSURLSessionDataTask *)GetProductInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block productId:(NSString *)productId startIndex:(int)startIndex;

//添加产品
+ (NSURLSessionDataTask *)AddProductInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;

//发布产品信息
+ (NSURLSessionDataTask *)PublishProductInformationWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic;
@end
