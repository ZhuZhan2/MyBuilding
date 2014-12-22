//
//  LoginViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistViewController.h"
@protocol LoginViewDelegate <NSObject>
-(void)loginCompleteWithDelayBlock:(void(^)())block;
-(void)loginComplete;
@end

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,registViewDelegate>{
    UITextField *_userNameTextField;
    UITextField *_passWordTextField;
}
@property(nonatomic,weak)id<LoginViewDelegate>delegate;
@property(nonatomic)BOOL needDelayCancel;
@end
