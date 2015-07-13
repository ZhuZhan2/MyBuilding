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
    }else{
        self.a_hasSign = YES;
    }
    self.a_signDays = dict[@"signDays"];
    self.a_toDayGet = dict[@"toDayGet"];
    self.a_status = dict[@"status"];
    self.a_lastSignTime = dict[@"lastSignTime"];
}
@end
