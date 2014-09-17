//
//  LoginSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LoginSqlite.h"

@implementation LoginSqlite
+(void)opensql
{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        
        
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Login (primarykey INTEGER PRIMARY KEY  AUTOINCREMENT, data Varchar ,datakey Varchar);";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"创建数据库表错误: %s", errorMsg);
        }
        
    }
    else
    {
        NSLog(@"打开数据库失败！");
        
    }
    if(sqlite3_close(zpzchinaMobileDB)==SQLITE_OK)
    { // NSLog(@"关闭数据库成功!");
    }
    
}

+(NSString *)getdata:(NSString *)datakey defaultdata:(NSString *)defaultdata
{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Login (primarykey INTEGER PRIMARY KEY  AUTOINCREMENT, data Varchar,datakey Varchar);";
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"创建数据库表错误: %s", errorMsg);
        }
        
    }
    else
    {
        NSLog(@"打开数据库失败！");
        
    }
    
    char *name;
    NSString *data=[[NSString alloc]initWithString:defaultdata];
    sqlite3_stmt *statement;
    NSString *sql=[[NSString alloc]initWithFormat:@"select datakey,data from Login where datakey='%@'",datakey];
    const char *selectSql=[sql UTF8String];
    if (sqlite3_prepare_v2(zpzchinaMobileDB, selectSql, -1, &statement, nil)==SQLITE_OK) {
        //NSLog(@"select ok.!!!!!!");
        //查询成功
    }
    
    while (sqlite3_step(statement)==SQLITE_ROW) {
        name=(char *)sqlite3_column_text(statement, 1);
        data=[[NSString alloc]initWithUTF8String:name];
        
    }
    
    
    sqlite3_finalize(statement);
    if(sqlite3_close(zpzchinaMobileDB)==SQLITE_OK)
    {  // NSLog(@"关闭数据库成功!");
    }
    return data;
}

+(void)insertData:(NSString *)data datakey:(NSString *)datakey
{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    sqlite3_stmt *stmt;
    int i=0;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Login (primarykey INTEGER PRIMARY KEY  AUTOINCREMENT, data Varchar,datakey Varchar);";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"创建数据库表错误: %s", errorMsg);
        }
        
    }
    else
    {
        NSLog(@"打开数据库失败！");
        
    }
    
    
    
    
    NSString *sql=[NSString stringWithFormat:@"select primarykey,datakey,data from Login where datakey='%@'",datakey];
    const char *selectSql=[sql UTF8String];
    
    if (sqlite3_prepare_v2(zpzchinaMobileDB, selectSql, -1, &stmt, nil)==SQLITE_OK) {
        
        //查询成功
    }
    else
    {
        
    }
    while (sqlite3_step(stmt)==SQLITE_ROW) {
        i=sqlite3_column_int(stmt, 0);
        
    }
    
    
    //如果之前的数据不存在 则主键加1新添一条记录
    
    if (i==0)
    {
        
        NSString *sql=[NSString stringWithFormat:@"select primarykey,datakey,data from Login where primarykey=0"];
        const char *selectSql=[sql UTF8String];
        if (sqlite3_prepare_v2(zpzchinaMobileDB, selectSql, -1, &stmt, nil)==SQLITE_OK) {
            
            //查询成功
        }
        
        while (sqlite3_step(stmt)==SQLITE_ROW)
        {
            
            i=sqlite3_column_int(stmt, 2);
        }
        i=i+1;
        
    }
    
    
    char *update = "INSERT OR REPLACE INTO Login (primarykey,datakey, data) VALUES (?,?,?);";
    if (sqlite3_prepare_v2(zpzchinaMobileDB, update, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, i);
        sqlite3_bind_text(stmt,2, [datakey UTF8String],-1,NULL);
        sqlite3_bind_text(stmt,3, [data UTF8String], -1, NULL);
    }
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
        //NSAssert(0, @"更新数据库表FIELDS出错: %s", errorMsg);
        sqlite3_finalize(stmt);
    
    
    if (sqlite3_prepare_v2(zpzchinaMobileDB, update, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, 0);
        sqlite3_bind_text(stmt,2, [@"primarykey" UTF8String],-1,NULL);
        sqlite3_bind_int(stmt, 3, i);
        
    }
    if (sqlite3_step(stmt) != SQLITE_DONE)
        //NSAssert(0, @"更新数据库表FIELDS出错: %s", errorMsg);
        sqlite3_finalize(stmt);
    
    
    if(sqlite3_close(zpzchinaMobileDB)==SQLITE_OK)
    {  // NSLog(@"关闭数据库成功!");
        
    }
}

+(void)dropTable{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        
        NSString *createSQL = @"DROP TABLE Login";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"Login删除成功");
        }
        
    }
}
@end
