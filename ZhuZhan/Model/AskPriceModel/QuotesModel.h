//
//  QuotesModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/21.
//
//

#import <Foundation/Foundation.h>
//列表
@interface QuotesModel : NSObject
//大v
@property(nonatomic,strong)NSString *a_isVerified;
//人的id
@property(nonatomic,strong)NSString *a_loginId;
//人的名字
@property(nonatomic,strong)NSString *a_loginName;
//状态
@property(nonatomic,strong)NSString *a_status;
@property(nonatomic,strong)NSDictionary *dict;
@end

//详情
@interface QuotesDetailModel : NSObject
//报价id
@property(nonatomic,strong)NSString *a_id;
//询价id
@property(nonatomic,strong)NSString *a_bookBuildingId;
//报价时间
@property(nonatomic,strong)NSString *a_createdTime;
//是否被采纳
@property(nonatomic,strong)NSString *a_isAccepted;
//内容
@property(nonatomic,strong)NSString *a_quoteContent;
//平台认证
@property(nonatomic,strong)NSString *a_quoteIsVerified;
//报价人的名字
@property(nonatomic,strong)NSString *a_quoteUser;
//状态
@property(nonatomic,strong)NSString *a_status;
//流水号
@property(nonatomic,strong)NSString *a_tradeCode;
@property(nonatomic,strong)NSDictionary *dict;
@end
