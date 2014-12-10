//
//  ProjectSqlite.h
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/9.
//
//

#import <Foundation/Foundation.h>

@interface ProjectSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;

+(void)InsertData:(NSDictionary *)dic;
+(NSMutableArray *)loadList;
+(void)deleteAll;
@end
