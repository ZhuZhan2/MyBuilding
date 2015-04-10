//
//  ChatSqlite.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/12.
//
//

#import "ChatSqlite.h"
#import "SqliteHelper.h"
@implementation ChatSqlite
+(void)opensql{
    sqlite3 *zhuZhanDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zhuZhanDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Chat (chatId Text,name Text,avatarUrl Text,message Text,time Text, userId Text, hasChatId Text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE Chat";
        
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
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Chat"]];
    }
}

+(void)InsertData:(ChatMessageModel *)model{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
    if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"INSERT INTO Chat(chatId,name,avatarUrl,message,time,userId) VALUES (?,?,?,?,?,?);",
         model.a_id,model.a_name,model.a_avatarUrl,model.a_message,model.a_time,model.a_userId];
    }
}
@end
