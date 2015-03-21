//
//  RKPointKit.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "RKPointKit.h"

@implementation RKPointKit
+(NSArray*)point:(CGPoint)point addSubPoints:(NSArray*)subPoints{
    NSMutableArray* newPoints=[NSMutableArray array];
    for (NSValue* value in subPoints) {
        CGPoint subPoint=[value CGPointValue];
        CGPoint newPoint=[self point:point addSubPoint:subPoint];
        [newPoints addObject:[NSValue valueWithCGPoint:newPoint]];
    }
    return newPoints;
}

+(NSArray*)points:(NSArray*)points addSubPoints:(NSArray*)subPoints{
    NSMutableArray* newPoints=[NSMutableArray array];
    for (int i=0; i<points.count; i++) {
        CGPoint point=[points[i] CGPointValue];
        CGPoint subPoint=[subPoints[i] CGPointValue];
        CGPoint newPoint=[self point:point addSubPoint:subPoint];
        [newPoints addObject:[NSValue valueWithCGPoint:newPoint]];
    }
    return newPoints;
}

+(CGPoint)point:(CGPoint)point addSubPoint:(CGPoint)subPoint{
    CGPoint newPoint=CGPointMake(point.x+subPoint.x, point.y+subPoint.y);
    return newPoint;
}
@end
