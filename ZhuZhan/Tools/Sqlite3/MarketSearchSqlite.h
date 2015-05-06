//
//  MarketSearchSqlite.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/6.
//
//

#import <Foundation/Foundation.h>

@interface MarketSearchSqlite : NSObject
+(void)opensql;
+(void)delAllRecordWithType:(NSInteger)type;
+(void)insertRecord:(NSString *)record type:(NSInteger)type ;
+(NSMutableArray *)loadList:(NSInteger)type;
@end
