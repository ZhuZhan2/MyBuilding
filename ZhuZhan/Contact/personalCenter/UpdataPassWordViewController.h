//
//  UpdataPassWordViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-10-10.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UpdataPassWordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    UITextField *oldPassWordTextField;
    UITextField *newPassWordTextField;
    UITextField *newAgainPassWordTextField;
    UIButton *confirmBtn;
}

@end
