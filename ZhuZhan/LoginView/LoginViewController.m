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
#import "RegistViewController.h"
#import "PanViewController.h"
#import "HomePageViewController.h"
#import "LoginModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userToken;
//static bool FirstLogin = NO;
//static int j =0;
//static int alertShowCount = 0;
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
    _isLogin = NO;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 321, 568)];
    [bgImgView setImage:[UIImage imageNamed:@"注册.png"]];
    [self.view addSubview:bgImgView];
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(111, 80, 98.5, 98.5)];
    [headerImgView setImage:[UIImage imageNamed:@"登录_03.png"]];
    UIImageView *roundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 89, 89)];
    roundView.layer.masksToBounds = YES;
    roundView.layer.cornerRadius = 45;
    [roundView setImage:nil];
    [headerImgView addSubview:roundView];
    [self.view addSubview:headerImgView];
    

    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(25,240,264,87)];
    UIImageView *bgImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,264,87)];
    [bgImgView2 setImage:[UIImage imageNamed:@"登录_07.png"]];
    [textView addSubview:bgImgView2];
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,0,254,43)];
    _userNameTextField.delegate = self;
    _userNameTextField.textAlignment=NSTextAlignmentLeft;
    _userNameTextField.placeholder=@"请填写用户名/手机号";
    _userNameTextField.returnKeyType=UIReturnKeyDone;
    _userNameTextField.font =  [UIFont systemFontOfSize:15];
    [_userNameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textView addSubview:_userNameTextField];
    _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,43,254,43)];
    _passWordTextField.delegate = self;
    _passWordTextField.textAlignment=NSTextAlignmentLeft;
    _passWordTextField.placeholder=@"请填写密码";
    _passWordTextField.returnKeyType=UIReturnKeyDone;
    _passWordTextField.secureTextEntry = YES;
    _passWordTextField.font =  [UIFont systemFontOfSize:15];
    [_passWordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textView addSubview:_passWordTextField];
    [self.view addSubview:textView];
    
    UIButton *loginBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(25, 340, 264, 36);
    loginBtn.tag = 20140801;
    [loginBtn setTitle:@"登    录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"登录_11.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *restPasswordBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    restPasswordBtn.frame = CGRectMake(175, 386, 160, 36);
    [restPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    restPasswordBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    //[restPasswordBtn addTarget:self action:@selector(restPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restPasswordBtn];
    
    UIButton *rememberBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    rememberBtn.frame = CGRectMake(17, 386, 160, 36);
    [rememberBtn setTitle:@"记住我的密码" forState:UIControlStateNormal];
    rememberBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    [rememberBtn addTarget:self action:@selector(rememberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rememberBtn];
    
    rememberView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 396, 13, 13)];
    [rememberView setImage:[UIImage imageNamed:@"登录_15.png"]];
    [self.view addSubview:rememberView];
    
    UIButton *registBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(70, 420, 200, 36);//y为500
    [registBtn setTitle:@"没有账户，去注册！" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rememberBtnClick{   //记住密码
    if(!_isSelect){
        [rememberView setImage:[UIImage imageNamed:@"登录1_07.png"]];
        _isSelect = YES;
    }else{
        [rememberView setImage:[UIImage imageNamed:@"登录_15.png"]];
        _isSelect = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgBtn setFrame:CGRectMake(0, 0, 320, 352)];
    [bgBtn addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
}

-(void)closeKeyBoard{
    [bgBtn removeFromSuperview];
    bgBtn = nil;
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
}

#pragma mark   开始登录－－－－－－－－
-(void)loginBtnClick{//注册按钮激发的事件
    //测试账号:zm 密码:123
    //登录接口
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_userNameTextField.text,@"cellPhone",_passWordTextField.text,@"password" ,@"mobile",@"deviceType",nil];
    NSLog(@"%@",parameters);
    [LoginModel LoginWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSLog(@"JSON: %@", posts);
        NSDictionary *responseObject = [posts objectAtIndex:0];
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]){
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                self.userToken = [item objectForKey:@"userToken"];
                NSString *isFaceRegister = [item objectForKey:@"isFaceRegister"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",isFaceRegister]forKey:@"isFaceRegister"];
                [[NSUserDefaults standardUserDefaults] setObject:[item objectForKey:@"faceCount"] forKey:@"currentFaceCount"];
                [[NSUserDefaults standardUserDefaults] setObject:_userNameTextField.text forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:self.userToken forKey:@"UserToken"];
                [[NSUserDefaults standardUserDefaults] setObject:[item objectForKey:@"userId"] forKey:@"userId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSLog(@",l,ll,l,l,l%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstPassWordLogin"]);
                if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstPassWordLogin"]==nil&&![[NSString stringWithFormat:@"%@",isFaceRegister] isEqualToString:@"1"]){//判断用户是否是第一次登陆并判断用户脸部识别的状态
                    [[NSUserDefaults standardUserDefaults] setObject:@"firstLogin" forKey:@"firstPassWordLogin"];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要进行脸部识别的注册" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
                    
                    [alert show];
                }else{
                    NSLog(@"登录成功！");
                    [self loginSuccess];
                }
            }
        }else{
            NSLog(@"登录失败！");
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 1;
            [alert show];
        }

    } dic:parameters];

}

-(void)loginSuccess{//登录成功后进行的跳转
    NSLog(@"sid === > %@",self.userToken);
    [[NSUserDefaults standardUserDefaults]setObject:_userNameTextField.text forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults]setObject:_passWordTextField.text forKey:@"passWord"];
    [[NSUserDefaults standardUserDefaults]setObject:self.userToken forKey:@"UserToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 20140731;
    [alert show];
}

#pragma mark  开始注册－－－－－－－－－
-(void)registBtnClick{//注册
    NSLog(@"registBtnClick");
    RegistViewController *registView = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registView animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        NSLog(@"mlmlmll %ld",(long)alertView.tag);
    if(alertView.tag ==20140731){ //此时进行登录的跳转

        HomePageViewController *homepage = [[HomePageViewController alloc] init];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[[AppDelegate instance] window] cache:YES];
        NSUInteger tview1 = [[self.view subviews] indexOfObject:[[AppDelegate instance] window]];
        NSUInteger tview2 = [[self.view subviews] indexOfObject:homepage.view];
        [self.view exchangeSubviewAtIndex:tview2 withSubviewAtIndex:tview1];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];

        [[AppDelegate instance] window].rootViewController = homepage;
        [[[AppDelegate instance] window] makeKeyAndVisible];
        
    }
    else{
        if (buttonIndex ==0) {//选择进行脸部识别注册的时候进入到这里
            
            PanViewController *panVC = [[PanViewController alloc] init];
            [self.navigationController pushViewController:panVC animated:NO];
            
        }
        else if (buttonIndex ==1)//选择否，不进行脸部识别注册
        {
            //跳过直接进行登录
            [self loginSuccess];
        }

    }
    
}

@end
