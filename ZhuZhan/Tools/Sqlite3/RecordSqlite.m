//
//  RecordSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-22.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "RecordSqlite.h"
#import "SqliteHelper.h"
#import "RecordModel.h"
@implementation RecordSqlite
+(void)opensql{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Record (name Text ,time Text); ";
        
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

+(void)dropTable{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        
        NSString *createSQL = @"DROP TABLE Record";
        
        if (sqlite3_exec(zhuZhanDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zhuZhanDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"ProjectLog删除成功");
        }
        
    }
}

+(void)delAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Record"]];
	}
}

//新建数据
+(void)InsertData:(NSDictionary *)dic{
    NSLog(@"==>%@",dic);
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"INSERT INTO Record(name,time ) VALUES (?,?);",
         [dic objectForKey:@"name"],[dic objectForKey:@"time"]];
	}
    [sqlite executeNonQuery:[NSString stringWithFormat:@"delete from record where time <> '%@' and name = '%@'",dic[@"time"],dic[@"name"]]];
}

+(NSMutableArray *)loadList{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Record order by time desc"]];
        for (NSDictionary * dict in results) {
            RecordModel *model = [[RecordModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}
@end
