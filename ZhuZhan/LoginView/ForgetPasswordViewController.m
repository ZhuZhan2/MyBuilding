//
//  ForgetPasswordViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/24.
//
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>

@end

@implementation ForgetPasswordViewController
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
    self.title = @"密码找回";
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


-(void)loadRegisterBtn{
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(22, 500, 276, 42);
    [registerBtn setBackgroundImage:[GetImagePath getImagePath:@"注册_07"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag =2014072401;
    [self.view addSubview:registerBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
