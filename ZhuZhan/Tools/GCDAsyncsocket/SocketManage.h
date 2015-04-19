//
//  SocketManage.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/12.
//
//

#import <Foundation/Foundation.h>

@interface SocketManage : NSObject
+ (instancetype)sharedManager;
- (void)connectToServer:(NSString *)host withPort:(uint16_t)port;
- (void)writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;
- (BOOL)isConnected;
@end
