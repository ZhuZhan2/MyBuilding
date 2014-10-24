//
//  RegistViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "RegistViewController.h"

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "FaceViewController.h"
#import "PanViewController.h"
#import "LoginModel.h"
#import "LoginSqlite.h"

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MD5.h"
#import "ClauseViewController.h"
@interface RegistViewController ()

@end

@implementation RegistViewController

static bool IsVerify =NO;
-(void)initNavi{
    //navi的影藏和颜色
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
    //返还按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    //标题和标题设置
    self.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)loadFirstView{
    UIView* firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 94)];
    firstView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:firstView];
    UIImageView* backView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"注册_02"]];
    [firstView addSubview:backView];
    
    [self addSeparatorLineInView:firstView];
    //新建电话号码文本框
    _phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,0,276,47)];
    _phoneNumberTextField.delegate = self;
    _phoneNumberTextField.textAlignment=NSTextAlignmentLeft;
    _phoneNumberTextField.placeholder=@"填写手机号";
    _phoneNumberTextField.returnKeyType=UIReturnKeyDone;
    _phoneNumberTextField.keyboardType =UIKeyboardTypePhonePad;
    _phoneNumberTextField.clearButtonMode =YES;
    [firstView addSubview:_phoneNumberTextField];
    
    //新建验证码文本框
    _yzmTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,47,170,47)];
    _yzmTextField.delegate = self;
    _yzmTextField.textAlignment=NSTextAlignmentLeft;
    _yzmTextField.placeholder=@"填写验证码";
    _yzmTextField.returnKeyType=UIReturnKeyDone;
    _yzmTextField.clearButtonMode =YES;
    [firstView addSubview:_yzmTextField];
    
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.frame = CGRectMake(208,57,91,28);
    [getCodeBtn setImage:[GetImagePath getImagePath:@"密码找回_15"] forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getVerifitionCode) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:getCodeBtn];

}

-(void)addSeparatorLineInView:(UIView*)view{
    NSInteger number=view.frame.size.height/47-1;
    for (int i=0; i<number; i++) {
        NSLog(@"number==%d",number);
        UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(20, 47*(i+1), 280, 1)];
        separatorLine.backgroundColor=RGBCOLOR(222, 222, 222);
        [view addSubview:separatorLine];
    }
}

-(void)loadSecondView{
    UIView* secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 194, 320, 141)];
    secondView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:secondView];
    UIImageView* backView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"注册_04"]];
    [secondView addSubview:backView];
    
    [self addSeparatorLineInView:secondView];

    //账号文本框
    accountField = [[UITextField alloc] initWithFrame:CGRectMake(22,0,276,47)];
    accountField.delegate = self;
    accountField.textAlignment=NSTextAlignmentLeft;
    accountField.placeholder=@"填写用户名";
    accountField.returnKeyType=UIReturnKeyDone;
    accountField.clearButtonMode =YES;
    [secondView addSubview:accountField];
    
    //新建密码文本框
    passWordField = [[UITextField alloc] initWithFrame:CGRectMake(22,47,276,47)];
    passWordField.delegate = self;
    passWordField.textAlignment=NSTextAlignmentLeft;
    passWordField.placeholder=@"填写密码";
    passWordField.returnKeyType=UIReturnKeyDone;
    passWordField.clearButtonMode =YES;
    passWordField.secureTextEntry = YES;
    [secondView addSubview:passWordField];
    
    //确认密码的文本框
    verifyPassWordField = [[UITextField alloc] initWithFrame:CGRectMake(22,94,276,47)];
    verifyPassWordField.delegate = self;
    verifyPassWordField.textAlignment=NSTextAlignmentLeft;
    verifyPassWordField.placeholder=@"确认密码";
    verifyPassWordField.returnKeyType=UIReturnKeyDone;
    verifyPassWordField.clearButtonMode =YES;
    verifyPassWordField.secureTextEntry = YES;
    [secondView addSubview:verifyPassWordField];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavi];
    self.view.backgroundColor=RGBCOLOR(245, 246, 248);
    [self loadFirstView];
    [self loadSecondView];
    [self loadRegisterBtn];
    [self loadClauseView];
}

-(void)loadClauseView{
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 350, 320, 18)];
    imageView.image=[GetImagePath getImagePath:@"注册_05"];
    [self.view addSubview:imageView];
    
    UIButton* button=[[UIButton alloc]init];
    button.frame=CGRectMake(143, 350, 30, 20);
    [button addTarget:self action:@selector(chooseClause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)chooseClause{
    ClauseViewController* vc=[[ClauseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadRegisterBtn{
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(22, 500, 276, 42);
    [registerBtn setBackgroundImage:[GetImagePath getImagePath:@"注册_07"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag =2014072401;
    [self.view addSubview:registerBtn];
}

#pragma mark UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入不能为空"delegate:nil cancelButtonTitle:@"是"otherButtonTitles: nil];
        [alert show];
    }
    
    [textField resignFirstResponder];
    return YES;
}
#pragma mark UIResponder
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_phoneNumberTextField.isEditing) {//判断输入的内容是否为手机号
        [self phoneNoErr:_phoneNumberTextField.text];
        [_phoneNumberTextField resignFirstResponder];
    }
    
    [passWordField resignFirstResponder];
    [verifyPassWordField resignFirstResponder];
    [_yzmTextField resignFirstResponder];
    
}


-(BOOL)phoneNoErr:(NSString *)phone//正则表达式来判断是否是手机号码
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\b(1)[23458][0-9]{9}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches!=1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码不正确，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }
    return YES;
    
}


-(void)getVerifitionCode{
    
    //    NSLog(@"获取验证码！！");
    //    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] initWithObjectsAndKeys:_phoneNumberTextField.text,@"cellPhone",nil];
    //    NSLog(@"nininiiinmmmmmmmmmmmm%@",parameters);
    //
    //    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/api/code/generate",kAPIAdress] parameters:parameters error:nil];
    //
    //    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //    op.responseSerializer = [AFJSONResponseSerializer serializer];
    //    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"responseJSON12123%@",responseObject);
    //
    //        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
    //        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]) {
    //            IsVerify =YES;
    //            NSLog(@"手机号码提交成功");
    //
    //        }else{
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"系统错误" delegate:nil cancelButtonTitle: @"是" otherButtonTitles: nil];
    //            [alert show];
    //        }
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"kokokoko%@",error);
    //    }];
    //         [[NSOperationQueue mainQueue] addOperation:op];
    //
}

#pragma mark  开始注册－－－－－－－－－－
-(void)beginToCollect//点击注册按钮触发的事件
{
    
    [self commomRegister];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        [self faceCollect];//开始采集照片
        
    }
    else if (buttonIndex==1){//直接登录
        [self recognizeSuccess];
        
    }
    
}

-(void)faceCollect//进行脸部信息采集
{
    
    PanViewController *panVC = [[PanViewController alloc] init];
    [self.navigationController pushViewController:panVC animated:NO];
    
}

- (void)commomRegister//账号密码的注册

{
    NSLog(@"共同注册部分");
    if (![self phoneNoErr:_phoneNumberTextField.text]) {
        return;
    }
    
    //    if (!IsVerify) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请单击获取手机验证码" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil];
    //        [alert show];
    //        return;
    //    }
    //
    //    if ([_yzmTextField.text length]==0) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机验证码不能为空" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil];
    //        [alert show];
    //        return;
    //
    //    }
    
    if (![passWordField.text isEqualToString:verifyPassWordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入的密码不一致，请重新输入！" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if([passWordField.text isEqualToString:@""]||[_phoneNumberTextField.text isEqualToString:@""]||[verifyPassWordField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入不完整请检查你的输入！" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    
    //进行注册
    //**********************************
    
    
    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] initWithObjectsAndKeys:_phoneNumberTextField.text,@"cellPhone",[MD5 md5HexDigest:passWordField.text],@"password",@"mobile",@"deviceType",_yzmTextField.text,@"barCode",nil];
    NSLog(@"nininiiinmmmmmmmmmmmm%@",parameters);
    
    [LoginModel RegisterWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSDictionary *responseObject = [posts objectAtIndex:0];
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"])
        {
            NSLog(@"账号密码注册成功");
            
            IsVerify =NO;
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                
                
                [LoginSqlite opensql];
                [LoginSqlite insertData:[item objectForKey:@"isFaceRegister"] datakey:@"isFaceRegister"];
                [LoginSqlite insertData:[item objectForKey:@"faceCount"] datakey:@"faceCount"];
                NSLog(@"***********%@",[item objectForKey:@"userName"]);
                NSString *userName =[NSString stringWithFormat:@"%@",[item objectForKey:@"userName"]];
                if ([userName isEqualToString:@"(null)"]||[userName isEqualToString:@"<null>"]) {
                    userName = @"";
                }
                [LoginSqlite insertData:userName datakey:@"userName"];//待会跟岳志强沟通
                [LoginSqlite insertData:[item objectForKey:@"userId"] datakey:@"userId"];
                [LoginSqlite insertData:[item objectForKey:@"deviceToken"] datakey:@"deviceToken"];
                
                
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功，是否进行脸部识别的注册" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alert show];
            
        }else if([[NSString stringWithFormat:@"%@",statusCode]isEqualToString:@"1308"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码已存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else if([[NSString stringWithFormat:@"%@",statusCode]isEqualToString:@"1310"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"激活码无效" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:responseObject[@"d"][@"status"][@"errors"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } dic:parameters];
    
}



-(void)recognizeSuccess//开始进行登录跳转
{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
