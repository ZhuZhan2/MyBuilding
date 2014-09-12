//
//  BirthDay.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-11.
//
//

#import "BirthDay.h"

@implementation BirthDay
+(NSString *)getAge:(NSString *)dateStr{
    //通过生日计算年龄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSDate *birthDate = [dateFormatter dateFromString:dateStr];
     NSTimeInterval dateDiff = [birthDate timeIntervalSinceNow];
     int age=trunc(dateDiff/(60*60*24))/365;
    NSString *str = [[NSString stringWithFormat:@"%d",age] substringFromIndex:1];
    return str;
}

+(NSString *)getConstellation:(NSString *)dateStr{
    
    int m;//月份
    int d;//日
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDate = [dateFormatter dateFromString:dateStr];
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:birthDate];
    m = [conponent month];
    d = [conponent day];
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        
        return @"错误日期格式!";
        
    }
    
    if(m==2 && d>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            
            return @"错误日期格式!!!";
            
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
}

+(NSString *)getZodiac:(NSString *)dateStr{
    NSString *astroString = @"猴鸡狗猪鼠牛虎兔龙蛇马羊";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDate = [dateFormatter dateFromString:dateStr];
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:birthDate];
    NSRange range = NSMakeRange([conponent year]%12,1);
    NSString *str = [astroString substringWithRange:range];
    return str;
}
@end
