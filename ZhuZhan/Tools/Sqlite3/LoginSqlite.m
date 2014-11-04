//
//  LoginSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LoginSqlite.h"
#import "SqliteHelper.h"
@implementation LoginSqlite
+(void)opensql
{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        
        
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Login (data Text ,datakey Text);";
        
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

+(NSString *)getdata:(NSString *)datakey
{
    NSString *str = nil;
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"select data from Login where datakey='%@'",datakey]];
        if(results.count !=0){
            for(NSDictionary *item in results){
                str = item[@"data"];
            }
        }else{
            str = @"";
        }
    }
    
    return str;
}

+(void)insertData:(NSString *)data datakey:(NSString *)datakey{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        if([[LoginSqlite loadKey:datakey] count] !=0){
            [sqlite executeQuery:@"UPDATE Login SET data=? WHERE datakey=?;",
             data,datakey];
        }else{
            [sqlite executeQuery:@"INSERT INTO Login(data,datakey ) VALUES (?,?);",
             data,datakey];
        }
    }
}

+(NSArray *)loadKey:(NSString *)datakey{
    NSArray *results = nil;
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT datakey FROM Login where datakey='%@'",datakey]];
    }
    return results;
}

+(void)dropTable{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        
        NSString *createSQL = @"DROP TABLE Login";
        
        if (sqlite3_exec(zhuZhanDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zhuZhanDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"Login删除成功");
        }
        
    }
}

+(void)deleteAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"delete from Login"];
    }
}
@end
