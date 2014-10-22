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
@end
