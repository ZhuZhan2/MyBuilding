//
//  MarketSearchSqlite.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/6.
//
//

#import "MarketSearchSqlite.h"
#import "SqliteHelper.h"
@implementation MarketSearchSqlite
+(void)opensql{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS t_marketSearch (id INTEGER PRIMARY KEY,record TEXT,type TEXT); ";
        
        if (sqlite3_exec(zhuZhanDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zhuZhanDB);
            NSAssert(0, @"创建数据库表错误: %s", errorMsg);
        }
        
    }
    else
    {
        NSLog(@"打开数据库失败！");
        
    }
    if(sqlite3_close(zhuZhanDB)==SQLITE_OK)
    { // NSLog(@"关闭数据库成功!");
    }
    
}

+(void)delAllRecordWithType:(NSInteger)type{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"DELETE FROM t_marketSearch WHERE type =%d",(int)type]];
    }
}

+(void)insertRecord:(NSString *)record type:(NSInteger)type {
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"DELETE FROM t_marketSearch WHERE record = '%@' AND type = %d",record,(int)type]];
    }
    
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"INSERT INTO t_marketSearch(record,type) VALUES ('%@',%d);",record,(int)type]];
    }
    
    NSArray* array = [self loadList:type];
    if (array.count>10) {
        [sqlite executeQuery:[NSString stringWithFormat:@"DELETE FROM t_marketSearch WHERE id IN (SELECT MIN(id) FROM t_marketSearch WHERE type = %d)",(int)type]];
    }
}

+(NSMutableArray *)loadList:(NSInteger)type{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_marketSearch  WHERE type = %d ORDER BY id DESC",(int)type]];
        for (NSDictionary * dict in results) {
            NSString* record = dict[@"record"];
            [list addObject:record];
        }
    }
    return list;
}
@end
