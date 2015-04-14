//
//  ImageSqlite.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/14.
//
//

#import "ImageSqlite.h"
#import "SqliteHelper.h"
#import "ImageModel.h"
@implementation ImageSqlite
+(void)opensql{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Image (imageId text,data blob,type text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE Image";
        
        if (sqlite3_exec(zhuZhanDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zhuZhanDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"Chat删除成功");
        }
        
    }
}

+(void)delAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Image"]];
    }
}

+(void)DelImage:(NSString *)imageId{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Image where imageId='%@'",imageId]];
    }
}

+(void)InsertData:(NSData *)data type:(NSString *)type imageId:(NSString *)imageId{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"INSERT INTO Image(imageId,data,type) VALUES (?,?,?);",
         imageId,data,type];
    }
}

+(NSMutableArray *)loadList:(NSString *)type{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Image where type = '%@'",type]];
        for (NSDictionary * dict in results) {
            ImageModel *model = [[ImageModel alloc]init];
            [model setDict:dict];
            [list addObject:model];
        }
    }
    return list;
}
@end
