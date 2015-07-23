//
//  FakeProjectStage.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/16.
//
//

#import "ProjectStage.h"

@interface FakeProjectStage : ProjectStage
+(NSString*)getPart:(NSArray*)detailStage contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images;
@end
