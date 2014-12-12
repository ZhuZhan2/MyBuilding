//
//  LoginViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "LoginModel.h"
#import "MD5.h"
#import "ForgetPasswordViewController.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()
@property(nonatomic,strong)UIButton* loginBtn;
@end

@implementation LoginViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGBCOLOR(85, 103, 166);
    UIButton *closeKeyBoard = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeKeyBoard setFrame:self.view.frame];
    [closeKeyBoard addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeKeyBoard];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:[GetImagePath getImagePath:@"登录_03"] forState:UIControlStateNormal];
    [cancelBtn setFrame:CGRectMake(20, 30, 26, 26)];
    [cancelBtn addTarget:self action:@selector(cancelSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(50.5, 110, 219, 77)];
    [bgImage setImage:[GetImagePath getImagePath:@"登录_07"]];
    [self.view addSubview:bgImage];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(21.5, 230, 277, 200)];
    [self.view addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 277, 41)];
    [imageView setImage:[GetImagePath getImagePath:@"登录_19"]];
    [bgView addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 277, 41)];
    [imageView2 setImage:[GetImagePath getImagePath:@"登录_19"]];
    [bgView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(7, 11, 19, 19)];
    [imageView3 setImage:[GetImagePath getImagePath:@"登录_14"]];
    [bgView addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 52, 15, 20)];
    [imageView4 setImage:[GetImagePath getImagePath:@"登录_11"]];
    [bgView addSubview:imageView4];
    
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, 240, 41)];
    _userNameTextField.delegate = self;
    _userNameTextField.textAlignment=NSTextAlignmentLeft;
    _userNameTextField.placeholder=@"用户名";
    _userNameTextField.returnKeyType=UIReturnKeyDone;
    _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [bgView addSubview:_userNameTextField];
    
    _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 42, 240, 41)];
    _passWordTextField.delegate = self;
    _passWordTextField.textAlignment=NSTextAlignmentLeft;
    _passWordTextField.placeholder=@"密码";
    _passWordTextField.returnKeyType=UIReturnKeyDone;
    _passWordTextField.secureTextEntry = YES;
    _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [bgView addSubview:_passWordTextField];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setBackgroundImage:[GetImagePath getImagePath:@"登录_22"] forState:UIControlStateNormal];
    [self.loginBtn setFrame:CGRectMake(0, 100, 277, 42)];
    [self.loginBtn addTarget:self action:@selector(gotoLogin) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.loginBtn];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registBtn setBackgroundImage:[GetImagePath getImagePath:@"登录_24"] forState:UIControlStateNormal];
    [registBtn setFrame:CGRectMake(0, 150, 277, 42)];
    [registBtn addTarget:self action:@selector(gotoRegist) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:registBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 530, 100, 30)];
    label.text = @"忘记密码了吗？";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.alpha = 0.5;
    [self.view addSubview:label];
    
    UIButton *findPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [findPassWordBtn setFrame:CGRectMake(160, 530, 100, 30)];
    [findPassWordBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    findPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [findPassWordBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPassWordBtn];
}

-(void)forgetPassword{
    ForgetPasswordViewController* vc=[[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelClick{
    if (!self.needDelayCancel) {
        [self cancelSelf];
    }
}

-(void)cancelSelf{
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)closeKeyBoard{
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)gotoRegist{
    RegistViewController *registView = [[RegistViewController alloc] init];
    registView.delegate = self;
    [self.navigationController pushViewController:registView animated:YES];
}

-(void)gotoLogin{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    self.loginBtn.enabled=NO;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_userNameTextField.text forKey:@"userName"];
    [dic setValue:[MD5 md5HexDigest:_passWordTextField.text] forKey:@"password"];
    [dic setValue:@"mobile" forKey:@"deviceType"];
    [LoginModel LoginWithBlock:^(NSMutableArray *posts, NSError *error) {
        self.loginBtn.enabled=YES;
        if(!error){
            if(posts.count !=0){
                LoginModel *model = posts[0];
                NSLog(@"%@",model.a_deviceToken);
                [LoginSqlite insertData:model.a_deviceToken datakey:@"deviceToken"];
                [LoginSqlite insertData:model.a_userId datakey:@"userId"];
                [LoginSqlite insertData:model.a_userName datakey:@"userName"];
                [LoginSqlite insertData:model.a_userImage datakey:@"userImage"];
                [LoginSqlite insertData:model.a_backgroundImage datakey:@"backgroundImage"];
                [LoginSqlite insertData:model.a_userType datakey:@"userType"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
                if (self.needDelayCancel) {
                    if([self.delegate respondsToSelector:@selector(loginCompleteWithDelayBlock:)]){
                        [self.delegate loginCompleteWithDelayBlock:^{
                            [self cancelSelf];
                        }];
                    }
                }else{
                    [self dismissViewControllerAnimated:YES completion:nil];
                    if([self.delegate respondsToSelector:@selector(loginComplete)]){
                        [self.delegate loginComplete];
                    }
                }
                
            }
        }
    } dic:dic noNetWork:nil];
}

-(void)registComplete{
    if([self.delegate respondsToSelector:@selector(loginCompleteWithDelayBlock:)]){
        [self.delegate loginCompleteWithDelayBlock:^{
            [self cancelSelf];
        }];
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
//    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
//    return YES;
//}
@end
