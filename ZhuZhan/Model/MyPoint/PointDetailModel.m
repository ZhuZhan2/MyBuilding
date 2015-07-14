//
//  PointDetailModel.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/13.
//
//

#import "PointDetailModel.h"

@implementation PointDetailModel
-(void)setDict:(NSDictionary *)dict{
    self.a_loginId = dict[@"loginId"];
    self.a_points = [dict[@"points"] intValue];
    if([dict[@"hasSign"] isEqualToString:@"0"]){
        self.a_hasSign = NO;
        self.a_todayGet = [NSString stringWithFormat:@"今天签到可获得%@积分",dict[@"todayGet"]];
    }else{
        self.a_hasSign = YES;
        self.a_todayGet = [NSString stringWithFormat:@"明天签到可获得%@积分",dict[@"tomorrowGet"]];
    }
    self.a_signDays = dict[@"signdays"];
    self.a_status = dict[@"status"];
    self.a_lastSignTime = dict[@"lastSignTime"];
}
@end
