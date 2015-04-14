//
//  ImageSqlite.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/14.
//
//

#import <Foundation/Foundation.h>

@interface ImageSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;
+(void)InsertData:(NSData *)data type:(NSString *)type;
+(NSMutableArray *)loadList:(NSString *)type;
@end
