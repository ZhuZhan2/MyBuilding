//
//  ForgetPasswordSecondController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/15.
//
//

#import "ForgetPasswordSecondController.h"
#import "ForgetPasswordThirdController.h"
#import "LoginModel.h"
@interface ForgetPasswordSecondController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIFont* font;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UIButton* getCodeBtn;
@property(nonatomic)int timeCount;
@end

@implementation ForgetPasswordSecondController

-(UIFont *)font{
    return [UIFont systemFontOfSize:16];
}

-(void)initNavi{
    //navi的影藏和颜色
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
    //返还按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    //标题和标题设置
    self.title = @"密码找回";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    //self.navigationController.navigationBar.hidden=YES;
}

-(void)loadFirstView{
    UIView* firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 94)];
    firstView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:firstView];
    UIImageView* backView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"注册_02"]];
    [firstView addSubview:backView];
    
    [self addSeparatorLineInView:firstView];
    //新建电话号码文本框
    _phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,5,170,47)];
    _phoneNumberTextField.delegate = self;
    _phoneNumberTextField.font=self.font;
    _phoneNumberTextField.textAlignment=NSTextAlignmentLeft;
    _phoneNumberTextField.placeholder=@"填写手机号";
    _phoneNumberTextField.text = self.cellPhone;
    _phoneNumberTextField.returnKeyType=UIReturnKeyDone;
    _phoneNumberTextField.keyboardType =UIKeyboardTypePhonePad;
    _phoneNumberTextField.clearButtonMode =YES;
    _phoneNumberTextField.enabled = NO;
    [firstView addSubview:_phoneNumberTextField];
    
    //新建验证码文本框
    _yzmTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,52,276,47)];
    _yzmTextField.delegate = self;
    _yzmTextField.font=self.font;
    _yzmTextField.textAlignment=NSTextAlignmentLeft;
    _yzmTextField.placeholder=@"填写验证码";
    _yzmTextField.returnKeyType=UIReturnKeyDone;
    _yzmTextField.clearButtonMode =YES;
    [firstView addSubview:_yzmTextField];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCodeBtn.frame = CGRectMake(208,14,91,28);
    self.getCodeBtn.titleLabel.font=[UIFont systemFontOfSize:13.5f];
    [self.getCodeBtn setBackgroundImage:[GetImagePath getImagePath:@"密码找回_15"] forState:UIControlStateNormal];
    [self.getCodeBtn addTarget:self action:@selector(getVerifitionCode:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:self.getCodeBtn];
}

-(void)getVerifitionCode:(UIButton*)btn{
    NSLog(@"用户申请发送验证码");
    if (![self phoneNoErr:_phoneNumberTextField.text]) {
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_phoneNumberTextField.text forKey:@"cellPhone"];
    [dic setValue:@"01" forKey:@"codeType"];
    [LoginModel GenerateWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            btn.enabled=NO;
            self.timeCount=0;
            [btn setBackgroundImage:[GetImagePath getImagePath:@"密码找回_03z"] forState:UIControlStateNormal];
            [btn setTitle:@"60秒" forState:UIControlStateNormal];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTime:) userInfo:nil repeats:YES];
            
        }
    } dic:dic noNetWork:nil];
}

-(void)countDownTime:(NSTimer*)timer{
    self.timeCount++;
    if (self.timeCount==60) {
        [self.getCodeBtn setBackgroundImage:[GetImagePath getImagePath:@"密码找回_15"] forState:UIControlStateNormal];
        [self.getCodeBtn setTitle:nil forState:UIControlStateNormal];
        self.getCodeBtn.enabled=YES;
        [timer invalidate];
    }else{
        NSString* surplusTime=[NSString stringWithFormat:@"%d秒",60-self.timeCount];
        [self.getCodeBtn setTitle:surplusTime forState:UIControlStateNormal];
    }
}

-(void)addSeparatorLineInView:(UIView*)view{
    NSInteger number=view.frame.size.height/47-1;
    for (int i=0; i<number; i++) {
        UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(20, 47*(i+1)+4, 280, 1)];
        separatorLine.backgroundColor=RGBCOLOR(222, 222, 222);
        [view addSubview:separatorLine];
    }
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
    [self loadRegisterBtn];
    NSLog(@"%@",self.userId);
}

-(void)loadRegisterBtn{
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(22.5, kScreenHeight-68, 275, 42);
    [self.registerBtn setBackgroundImage:[GetImagePath getImagePath:@"验-----证"] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.tag =2014072401;
    [self.view addSubview:self.registerBtn];
}

-(void)beginToCollect{
//    ForgetPasswordThirdController *forgetSubView = [[ForgetPasswordThirdController alloc] init];
//    [self.navigationController pushViewController:forgetSubView animated:YES];
//    return;
    
    NSLog(@"用户确认");
    if([_phoneNumberTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请填写手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if([_yzmTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请填写验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_phoneNumberTextField.text forKey:@"cellPhone"];
    [dic setValue:_yzmTextField.text forKey:@"code"];
    [LoginModel VerifyCodeWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ForgetPasswordThirdController *forgetSubView = [[ForgetPasswordThirdController alloc] init];
            forgetSubView.userId = self.userId;
            forgetSubView.cellPhone = _phoneNumberTextField.text;
            forgetSubView.barCode = _yzmTextField.text;
            [self.navigationController pushViewController:forgetSubView animated:YES];
        }
    } dic:dic noNetWork:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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

@end
