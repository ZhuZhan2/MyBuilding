//
//  ChatNetAPIClient.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import "ChatNetAPIClient.h"
#import "LoginSqlite.h"
@implementation ChatNetAPIClient
//static NSString * const AFAppDotNetAPIBaseURLString = @socketHttp;

+ (instancetype)sharedClient {
    static ChatNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ChatNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"socketHttp"]]];
        //_sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    [_sharedClient.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    return _sharedClient;
}

+(ChatNetAPIClient *)sharedNewClient{
    ChatNetAPIClient *_sharedNewClient = [ChatNetAPIClient sharedClient];
    NSLog(@"%@",_sharedNewClient);
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        [_sharedNewClient.requestSerializer setValue:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forHTTPHeaderField:@"Authorization"];
    }else{
        [_sharedNewClient.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"＊＊＊＊＊%@",_sharedNewClient.requestSerializer.HTTPRequestHeaders);
    return _sharedNewClient;
}
@end
