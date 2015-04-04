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
//创建人
@property(nonatomic,strong)NSString *a_createdBy;
//第几次报价
@property(nonatomic,strong)NSString *a_quoteTimes;
//附件图片
@property(nonatomic,strong)NSMutableArray *a_otherAttachmentsArr;
//资质图片
@property(nonatomic,strong)NSMutableArray *a_qualificationsAttachmentsArr;
//报价图片
@property(nonatomic,strong)NSMutableArray *a_quoteAttachmentsArr;
@property(nonatomic,strong)NSDictionary *dict;
@end

@interface ImagesModel : NSObject
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_createdBy;
@property(nonatomic,strong)NSString *a_category;
@property(nonatomic,strong)NSString *a_location;
@property(nonatomic,strong)NSString *a_name;
@property(nonatomic,strong)NSString *a_quotesId;
@property(nonatomic,strong)NSString *a_tradeCode;
@property(nonatomic,strong)NSString *a_extension;
@property(nonatomic)BOOL a_isUrl;
@property(nonatomic,strong)NSDictionary *dict;
@end
