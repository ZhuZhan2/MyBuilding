//
//  networkConnect.h
//  testNetworkConnect
//
//  Created by y on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface networkConnect : NSObject
+ (networkConnect *)sharedInstance;
- (BOOL) connectedToNetwork;

@end
