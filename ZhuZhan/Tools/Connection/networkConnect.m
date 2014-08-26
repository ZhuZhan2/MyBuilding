//
//  networkConnect.m
//  testNetworkConnect
//
//  Created by y on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>
#import "networkConnect.h"

@implementation networkConnect

+ (networkConnect *)sharedInstance
{
    static dispatch_once_t  onceToken;
    static networkConnect * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[networkConnect alloc] init];
    });
    return sSharedInstance;
}

- (BOOL) connectedToNetwork
{
    
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) 
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
    
    //return YES;
}



@end
