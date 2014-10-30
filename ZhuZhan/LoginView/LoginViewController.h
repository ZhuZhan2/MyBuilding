//
//  LoginViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>
-(void)loginComplete;
@end

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    UITextField *_userNameTextField;
    UITextField *_passWordTextField;
}
@property(nonatomic,weak)id<LoginViewDelegate>delegate;
@end
