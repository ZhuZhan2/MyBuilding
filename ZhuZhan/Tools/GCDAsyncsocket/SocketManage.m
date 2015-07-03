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
    [self.socket readDataWithTimeout:timeout tag:0];
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock{
    NSLog(@"socketDidSecure:%p", sock);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
}

- (BOOL)isConnected{
    return self.socket.isConnected;
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"socket:%p didReadData:withTag:%ld", sock, tag);
    [self.socket readDataWithTimeout:-1 tag:0];
    NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [httpResponse objectFromJSONString];
    NSLog(@"HTTP Response:\n%@", dic);
    if([dic[@"msgType"] isEqualToString:@"user"]){
        if([dic[@"event"] isEqualToString:@"text"]||[dic[@"event"] isEqualToString:@"image"]){
            [self snedUserMessage:dic[@"chatlog"]];
        }else{
            [self alertError:dic[@"event"]];
        }
    }else if ([dic[@"msgType"] isEqualToString:@"group"]){
        if([dic[@"event"] isEqualToString:@"text"]||[dic[@"event"] isEqualToString:@"image"]){
            if([dic[@"event"] isEqualToString:@"text"]||[dic[@"event"] isEqualToString:@"image"]){
                [self snedUserMessage:dic[@"chatlog"]];
            }else{
                [self alertError:dic[@"event"]];
            }
        }else{
            [self alertError:dic[@"event"]];
        }
    }else if([dic[@"msgType"] isEqualToString:@"error"]){
        [self alertError:dic[@"event"]];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"%@",err);
}

-(void)snedUserMessage:(NSDictionary *)dic{
    ChatMessageModel *model = [[ChatMessageModel alloc] init];
    [model setDict:dic];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newMessage" object:nil userInfo:@{@"message":model}];
}

-(void)alertError:(NSString *)errorCode{
    if([errorCode isEqualToString:@"403"]){
        [LoginAgain AddLoginView:NO];
    }else if ([errorCode isEqualToString:@"604"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"你们不是好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if ([errorCode isEqualToString:@"605"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"不是群成员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else if ([errorCode isEqualToString:@"606"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"服务器异常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"errorMessage" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadList" object:nil];
}
@end
