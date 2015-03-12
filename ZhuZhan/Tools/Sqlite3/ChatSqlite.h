//
//  ChatSqlite.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/12.
//
//

#import <Foundation/Foundation.h>
#import "ChatMessageModel.h"
@interface ChatSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;

+(void)InsertData:(ChatMessageModel *)model;
@end
