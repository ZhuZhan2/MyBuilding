//
//  ErrorCode.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/21.
//
//

#import "ErrorCode.h"

@implementation ErrorCode
+(int)errorCode:(NSError *)error{
    int obj = 0;
    NSLog(@"%@",error.localizedDescription);
    if([error.localizedDescription isEqualToString:@"Request failed: forbidden (403)"]||[error.localizedDescription isEqualToString:@"Request failed: 已禁止 (403)"]){
        obj = 403;
    }
    return obj;
}

+(void)alert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"服务器连接错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
