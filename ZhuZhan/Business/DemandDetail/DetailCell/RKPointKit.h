//
//  RKPointKit.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import <Foundation/Foundation.h>

@interface RKPointKit : NSObject
+(CGPoint)point:(CGPoint)point addSubPoint:(CGPoint)subPoint;

+(NSArray*)points:(NSArray*)points addSubPoints:(NSArray*)subPoints;

+(NSArray*)point:(CGPoint)point addSubPoints:(NSArray*)subPoints;
@end
