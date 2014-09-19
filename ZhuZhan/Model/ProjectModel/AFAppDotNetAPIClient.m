// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"
#import "LoginSqlite.h"
static NSString * const AFAppDotNetAPIBaseURLString = @serverAddress;
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.222.95:801/";

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return _sharedClient;
}

+(AFAppDotNetAPIClient *)sharedNewClient{
    AFAppDotNetAPIClient *_sharedNewClient = [AFAppDotNetAPIClient sharedClient];
    NSLog(@"%@",_sharedNewClient);
    if(![[LoginSqlite getdata:@"deviceToken" defaultdata:@""] isEqualToString:@""]){
        //NSLog(@"=====>%@",[LoginSqlite getdata:@"deviceToken" defaultdata:@""]);
        [_sharedNewClient.requestSerializer setValue:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId" defaultdata:@""],[LoginSqlite getdata:@"deviceToken" defaultdata:@""]] forHTTPHeaderField:@"Authorization"];
    }
    NSLog(@"%@",_sharedNewClient.requestSerializer.HTTPRequestHeaders);
    return _sharedNewClient;
}

@end
