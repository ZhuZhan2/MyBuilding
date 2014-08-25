//
//  projectModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-25.
//
//

#import <Foundation/Foundation.h>

@interface projectModel : NSObject
//项目ID
@property (nonatomic,copy) NSString *a_id;
//地块名称
@property (nonatomic,copy) NSString *a_landName;
//所在区域
@property (nonatomic,copy) NSString *a_district;
//所在省市
@property (nonatomic,copy) NSString *a_province;
//市区县
@property (nonatomic,copy) NSString *a_city;
//地块地址（项目地址）
@property (nonatomic,copy) NSString *a_landAddress;
//土地面积
@property (nonatomic,copy) NSString *a_area;
//土地容积率
@property (nonatomic,copy) NSString *a_plotRatio;
//地块用途
@property (nonatomic,copy) NSString *a_usage;
//拍卖单位
@property (nonatomic,copy) NSString *a_auctionUnit;
//项目名称
@property (nonatomic,copy) NSString *a_projectName;
//项目描述
@property (nonatomic,copy) NSString *a_description;
//业主单位
@property (nonatomic,copy) NSString *a_owner;
//预计开工时间
@property (nonatomic,copy) NSString *a_expectedStartTime;
//预计竣工时间
@property (nonatomic,copy) NSString *a_expectedFinishTime;
//投资额
@property (nonatomic,copy) NSString *a_investment;
//建筑面积
@property (nonatomic,copy) NSString *a_areaOfStructure;
//建筑层高
@property (nonatomic,copy) NSString *a_storeyHeight;
//外资参与
@property (nonatomic,copy) NSString *a_foreignInvestment;
//业主类型
@property (nonatomic,copy) NSString *a_ownerType;
//经度
@property (nonatomic,copy) NSString *a_longitude;
//纬度
@property (nonatomic,copy) NSString *a_latitude;

@property (nonatomic, copy) NSDictionary *dict;
+ (NSURLSessionDataTask *)GetListWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block;
@end
