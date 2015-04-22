//
//  ErrorCode.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ErrorCode : NSObject
+(int)errorCode:(NSError *)error;
+(void)alert;
@end
