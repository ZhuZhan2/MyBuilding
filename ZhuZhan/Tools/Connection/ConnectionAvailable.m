//
//  ConnectionAvailable.m
//  MUCH
//
//  Created by 汪洋 on 14-8-20.
//  Copyright (c) 2014年 lanjr. All rights reserved.
//

#import "ConnectionAvailable.h"
#import "Reachability.h"
@implementation ConnectionAvailable
+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"121.40.127.189"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    return isExistenceNetwork;
}
@end
