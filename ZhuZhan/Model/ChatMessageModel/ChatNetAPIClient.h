//
//  ChatNetAPIClient.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface ChatNetAPIClient : AFHTTPSessionManager
+(instancetype)sharedClient;
+(ChatNetAPIClient *)sharedNewClient;
@end
