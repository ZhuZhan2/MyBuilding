//
//  LoginSqlite.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteHelper.h"
@interface LoginSqlite : NSObject
+(void)opensql;
+(NSString *)getdata:(NSString *)datakey;
+(NSArray *)loadKey:(NSString *)datakey;
+(void)insertData:(NSString *)data datakey:(NSString *)datakey;
+(void)dropTable;
+(void)deleteAll;
@end
