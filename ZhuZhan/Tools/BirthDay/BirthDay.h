//
//  BirthDay.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-11.
//
//

#import <Foundation/Foundation.h>

@interface BirthDay : NSObject
//通过生日计算年龄
+(NSString *)getAge:(NSString *)dateStr;

//通过生日计算星座
+(NSString *)getConstellation:(NSString *)dateStr;

//通过生日计算属相
+(NSString *)getZodiac:(NSString *)dateStr;
@end
