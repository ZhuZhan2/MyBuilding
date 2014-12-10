//
//  ProjectSqlite.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/9.
//
//

#import "ProjectSqlite.h"
#import "SqliteHelper.h"
#import "LocalProjectModel.h"
@implementation ProjectSqlite
+(void)opensql{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Project (projectId Text,time Text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE Project";
        
        if (sqlite3_exec(zhuZhanDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zhuZhanDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"Project删除成功");
        }
        
    }
}

+(void)delAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Project"]];
    }
}

//新建数据
+(void)InsertData:(NSDictionary *)dic{
    NSLog(@"==>%@",dic);
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"INSERT INTO Project(projectId,time) VALUES (?,?);",
         [dic objectForKey:@"projectId"],dic[@"time"]];
    }
    [sqlite executeNonQuery:[NSString stringWithFormat:@"delete from Project where time <> '%@' and projectId = '%@'",dic[@"time"],dic[@"projectId"]]];
    
    NSMutableArray *arr =[ProjectSqlite loadList];
    if(arr.count >8){
        [sqlite executeQuery:@"delete from Project Where time = (select min(time) from Project)"];
    }
}

+(NSMutableArray *)loadList{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project order by time desc"]];
        for (NSDictionary * dict in results) {
            LocalProjectModel *model = [[LocalProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
    }
    return list;
}

+(void)deleteAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"delete from Project"];
    }
}
@end
