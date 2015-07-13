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
        self.a_toDayGet = [NSString stringWithFormat:@"今天签到可获得%@积分",dict[@"toDayGet"]];
    }else{
        self.a_hasSign = YES;
        int count = [dict[@"toDayGet"] intValue]+1;
        if(count >20){
            count = 20;
        }
        self.a_toDayGet = [NSString stringWithFormat:@"明天签到可获得%d积分",count];
    }
    self.a_signDays = dict[@"signDays"];
    self.a_status = dict[@"status"];
    self.a_lastSignTime = dict[@"lastSignTime"];
}
@end
