//
//  ChatImageSqlite.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/8.
//
//

#import <Foundation/Foundation.h>

@interface ChatImageSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;
+(void)InsertData:(NSData *)data imageId:(NSString *)imageId;
+(NSData *)loadList:(NSString *)imageId;
@end
