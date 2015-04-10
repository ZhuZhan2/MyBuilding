//
//  SocketManage.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/12.
//
//

#import "SocketManage.h"
#import "GCDAsyncSocket.h"
#import "JSONKit.h"
#import "ChatMessageModel.h"
@interface SocketManage ()
@property (nonatomic, strong) GCDAsyncSocket * socket;
@end

@implementation SocketManage
+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (GCDAsyncSocket *)socket {
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _socket;
}

- (void)connectToServer:(NSString *)host withPort:(uint16_t)port{
    NSError *error;
    if(![self.socket connectToHost:host onPort:port withTimeout:-1 error:&error]){
        NSLog(@"Error: %@", error);
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"did connect to host");
    [self.socket performBlock:^{
        [self.socket enableBackgroundingOnSocket];
    }];
}

- (void)writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag;{
    [self.socket writeData:data withTimeout:timeout tag:tag];
}

- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag{
    [self.socket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock{
    NSLog(@"socketDidSecure:%p", sock);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"socket:%p didReadData:withTag:%ld", sock, tag);
    [self.socket readDataWithTimeout:-1 tag:0];
    NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [httpResponse objectFromJSONString];
    NSLog(@"HTTP Response:\n%@", dic);
    if([dic[@"msgType"] isEqualToString:@"user"]){
        if([dic[@"event"] isEqualToString:@"text"]){
            ChatMessageModel *model = [[ChatMessageModel alloc] init];
            [model setDict:dic[@"chatlog"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newMessage" object:nil userInfo:@{@"message":model}];
        }
    }else if ([dic[@"msgType"] isEqualToString:@"group"]){
    
    }else{
    
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"%@",err);
}
@end
