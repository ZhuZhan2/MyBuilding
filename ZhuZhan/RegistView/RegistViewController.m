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
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface RegistViewController ()
@property(nonatomic,strong)UIFont* font;
@end

@implementation RegistViewController
-(UIFont *)font{
    return [UIFont systemFontOfSize:15];
}
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
    _phoneNumberTextField.font=self.font;
    _phoneNumberTextField.textAlignment=NSTextAlignmentLeft;
    _phoneNumberTextField.placeholder=@"填写手机号";
    _phoneNumberTextField.returnKeyType=UIReturnKeyDone;
    _phoneNumberTextField.keyboardType =UIKeyboardTypePhonePad;
    _phoneNumberTextField.clearButtonMode =YES;
    [firstView addSubview:_phoneNumberTextField];
    
    //新建验证码文本框
    _yzmTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,47,170,47)];
    _yzmTextField.delegate = self;
    _yzmTextField.font=self.font;
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
    accountField.font=self.font;
    accountField.textAlignment=NSTextAlignmentLeft;
    accountField.placeholder=@"填写用户名";
    accountField.returnKeyType=UIReturnKeyDone;
    accountField.clearButtonMode =YES;
    [secondView addSubview:accountField];
    
    //新建密码文本框
    passWordField = [[UITextField alloc] initWithFrame:CGRectMake(22,47,276,47)];
    passWordField.delegate = self;
    passWordField.font=self.font;
    passWordField.textAlignment=NSTextAlignmentLeft;
    passWordField.placeholder=@"填写密码";
    passWordField.returnKeyType=UIReturnKeyDone;
    passWordField.clearButtonMode =YES;
    passWordField.secureTextEntry = YES;
    [secondView addSubview:passWordField];
    
    //确认密码的文本框
    verifyPassWordField = [[UITextField alloc] initWithFrame:CGRectMake(22,94,276,47)];
    verifyPassWordField.delegate = self;
    verifyPassWordField.font=self.font;
    verifyPassWordField.textAlignment=NSTextAlignmentLeft;
    verifyPassWordField.placeholder=@"确认密码";
    verifyPassWordField.returnKeyType=UIReturnKeyDone;
    verifyPassWordField.clearButtonMode =YES;
    verifyPassWordField.secureTextEntry = YES;
    [secondView addSubview:verifyPassWordField];
}

-(void)endEdit{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self endEdit];
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
    NSLog(@"用户申请发送验证码");
}

#pragma mark  开始注册－－－－－－－－－－
//点击注册按钮触发的事件
-(void)beginToCollect{
    [self commomRegister];
}

- (void)commomRegister//账号密码的注册

{
    NSLog(@"共同注册部分");
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if (![self phoneNoErr:_phoneNumberTextField.text]) {
        return;
    }
    
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
    
    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] initWithObjectsAndKeys:_phoneNumberTextField.text,@"cellPhone",[MD5 md5HexDigest:passWordField.text],@"password",@"mobile",@"deviceType",_yzmTextField.text,@"barCode",nil];
    NSLog(@"parameters==%@",parameters);
    
    [LoginModel RegisterWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            NSDictionary *item = posts[0];
            [LoginSqlite insertData:[item objectForKey:@"userId"] datakey:@"userId"];
            [LoginSqlite insertData:[item objectForKey:@"deviceToken"] datakey:@"deviceToken"];
            [self.navigationController.viewControllers[0] dismissViewControllerAnimated:YES completion:nil];
        }
    } dic:parameters noNetWork:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    NSLog(@"注册dealloc");
}
@end
