//
//  RecordSqlite.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-22.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;

+(void)InsertData:(NSDictionary *)dic;
+(NSMutableArray *)loadList;
@end
