//
//  SqliteHelper.h
//  reader
//
//  Created by 夏军 on 12-10-15.
//  Copyright (c) 2012年 夏军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


static NSString *const DataBaseName = @"ZhuZhan.sqlite";


@interface SqliteHelper : NSObject {
	NSInteger busyRetryTimeout;
	NSString *filePath;
	sqlite3 *_db;
}

@property (readwrite) NSInteger busyRetryTimeout;
@property (readonly) NSString *filePath;


+ (NSString *)createUuid;
+ (NSString *)version;

- (id)initWithFile: (NSString *)filePath;
- (BOOL)open:(NSString *)filename;
- (void)close;

- (NSInteger)errorCode;
- (NSString *)errorMessage;

- (NSArray *)executeQuery: (NSString *)sql, ...;
- (NSArray *)executeQuery: (NSString *)sql arguments: (NSArray *)args;

- (BOOL)executeNonQuery: (NSString *)sql, ...;
- (BOOL)executeNonQuery: (NSString *)sql arguments: (NSArray *)args;

- (BOOL)commit;
- (BOOL)rollback;
- (BOOL)beginTransaction;
- (BOOL)beginDeferredTransaction;


@end
