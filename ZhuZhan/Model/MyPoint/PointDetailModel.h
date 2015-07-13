//
//  PointDetailModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/13.
//
//

#import <Foundation/Foundation.h>

@interface PointDetailModel : NSObject
//人的id
@property(nonatomic,strong)NSString *a_loginId;
//积分总数
@property(nonatomic)int a_points;
//今日签到状态
@property(nonatomic)BOOL a_hasSign;
//连续签到天数
@property(nonatomic,strong)NSString *a_signDays;
//今日可领积分数
@property(nonatomic,strong)NSString *a_toDayGet;
//积分账户状态 00正常 01不正常
@property(nonatomic,strong)NSString *a_status;
//最后签到时间
@property(nonatomic,strong)NSString *a_lastSignTime;
@property(nonatomic,strong)NSDictionary *dict;
@end
