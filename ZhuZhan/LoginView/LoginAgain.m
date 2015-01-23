//
//  LoginAgain.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/1/8.
//
//

#import "LoginAgain.h"

@implementation LoginAgain
+(void)AddLoginView:(BOOL)isContactView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"账号已在其他地方登录，请重新登录"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
    [alert show];
    NSString *flag = nil;
    if(isContactView){
        flag = @"1";
    }else{
        flag = @"0";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginAgain" object:nil userInfo:@{@"isContactView":flag}];
}
@end
