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
#import "RemindView.h"
#import "RecommendProjectViewController.h"
@interface RegistViewController ()
@property(nonatomic,strong)UIFont* font;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic)BOOL isSelect;
@property(nonatomic)int timeCount;
@property(nonatomic,strong)UIButton *getCodeBtn;
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
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
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
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getCodeBtn.frame = CGRectMake(208,57,91,28);
    [self.getCodeBtn setBackgroundImage:[GetImagePath getImagePath:@"密码找回_15"] forState:UIControlStateNormal];
    [self.getCodeBtn addTarget:self action:@selector(getVerifitionCode:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:self.getCodeBtn];

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
    passWordField.placeholder=@"填写密码6-24位";
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:accountField];
}

-(void)endEdit{
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isSelect = YES;
    [self endEdit];
    [self initNavi];
    self.view.backgroundColor=RGBCOLOR(245, 246, 248);
    [self loadFirstView];
    [self loadSecondView];
    [self loadRegisterBtn];
    [self loadClauseView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(errorCode:) name:@"register" object:nil];
}

-(void)errorCode:(NSNotification*)noti{
    [self remindErrorView:noti.object];
}

-(void)loadClauseView{
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(65, 470, 320, 18);
    [self.selectBtn setImage:[GetImagePath getImagePath:@"注册_05"] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:self.selectBtn];
    
    UIButton* button=[[UIButton alloc]init];
    button.frame=CGRectMake(208, 470, 30, 20);
    [button addTarget:self action:@selector(chooseClause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)selectBtnAction:(UIButton *)button{
    if(self.isSelect){
        [self.selectBtn setImage:[GetImagePath getImagePath:@"注册_03"] forState:UIControlStateNormal];
        self.isSelect = NO;
    }else{
        [self.selectBtn setImage:[GetImagePath getImagePath:@"注册_05"] forState:UIControlStateNormal];
        self.isSelect = YES;
    }
}

-(void)chooseClause{
    ClauseViewController* vc=[[ClauseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadRegisterBtn{
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(22, 500, 276, 42);
    [self.registerBtn setBackgroundImage:[GetImagePath getImagePath:@"注册_07"] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.tag =2014072401;
    [self.view addSubview:self.registerBtn];
}

-(BOOL)phoneNoErr:(NSString *)phone//正则表达式来判断是否是手机号码
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\b(1)[23458][0-9]{9}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches!=1) {
        [self remindErrorView:@"手机号码不正确，请重新输入"];
        return NO;
    }
    return YES;
}


-(void)getVerifitionCode:(UIButton*)btn{
    NSLog(@"用户申请发送验证码");
    [self.view endEditing:YES];

    if (![self phoneNoErr:_phoneNumberTextField.text]) {
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_phoneNumberTextField.text forKey:@"cellPhone"];
    [dic setValue:@"UserRegister" forKey:@"type"];
    [LoginModel GetIsExistWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            if ([[NSString stringWithFormat:@"%@",posts[0][@"status"][@"statusCode"]] isEqualToString:@"1300"]) {
                [self remindErrorView:@"手机号/用户名已存在请登陆"];
            }else if ([[NSString stringWithFormat:@"%@",posts[0][@"status"][@"statusCode"]] isEqualToString:@"1308"]){
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
                } dic:dic noNetWork:^{
                    [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
                }];
            }
        }
    } userName:_phoneNumberTextField.text noNetWork:^{
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
    }];
   
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

#pragma mark  开始注册－－－－－－－－－－
//点击注册按钮触发的事件
-(void)beginToCollect{
    if(self.isSelect){
        [self commomRegister];
    }else{
        [self remindErrorView:@"请先阅读条款，并同意"];
    }
}

-(void)remindErrorView:(NSString*)content{
    [RemindView remindViewWithContent:content superView:self.view centerY:375];
}

- (void)commomRegister//账号密码的注册
{
    NSLog(@"共同注册部分");
    RecommendProjectViewController *recProjectView = [[RecommendProjectViewController alloc] init];
    [self.navigationController pushViewController:recProjectView animated:YES];
    return;
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if (![self phoneNoErr:_phoneNumberTextField.text]) {
        return;
    }
    
    if([_yzmTextField.text isEqualToString:@""]){
        [self remindErrorView:@"请输入验证码！"];
        return;
    }
    
    if (!accountField.text.length) {
        [self remindErrorView:@"请输入用户名"];
        return;
    }
    
    NSRange accountFieldRange = [accountField.text rangeOfString:@" "];
    if (accountFieldRange.location != NSNotFound) {
        //有空格
        [self remindErrorView:@"用户名不能包含空格"];
        return;
    }
    
    if ([self isAllNumber:accountField.text]) {
        return;
    }
    
    if([self isContainsEmoji:accountField.text]){
        [self remindErrorView:@"用户名不能有表情"];
        return;
    }
    
    if (![self isRule2:accountField.text]) {
        [self remindErrorView:@"用户名不能有特殊字符"];
        return;
    }
    
    if(passWordField.text.length<6||passWordField.text.length>20){
        [self remindErrorView:@"密码需要在6-20位之间"];
        return;
    }
    
    NSRange passWordFieldRange = [passWordField.text rangeOfString:@" "];
    if (passWordFieldRange.location != NSNotFound) {
        //有空格
        [self remindErrorView:@"密码不能包含空格"];
        return;
    }
    
//    if (![self isRule:passWordField.text]) {
//        return;
//    }
//    
//    if(![self LetterNoErr:passWordField.text]){
//        return;
//    }
//    
//    if(![self NumberNoErr:passWordField.text]){
//        return;
//    }
//    
//    if (![self SymbolNoErr:passWordField.text]) {
//        return;
//    }
    
    if([passWordField.text isEqualToString:@""]||[_phoneNumberTextField.text isEqualToString:@""]||[verifyPassWordField.text isEqualToString:@""])
    {
        [self remindErrorView:@"输入不完整请检查你的输入！"];
        return;
    }
    
    if (![passWordField.text isEqualToString:verifyPassWordField.text]) {
        [self remindErrorView:@"密码输入不一致，请重新输入"];
        return;
    }
    
    
    self.registerBtn.enabled=NO;
    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] initWithObjectsAndKeys:_phoneNumberTextField.text,@"cellPhone",[MD5 md5HexDigest:passWordField.text],@"password",@"mobile",@"deviceType",_yzmTextField.text,@"barCode",accountField.text,@"userName",nil];
    NSLog(@"parameters==%@",parameters);
    
    [LoginModel RegisterWithBlock:^(NSMutableArray *posts, NSError *error) {
        self.registerBtn.enabled=YES;
        if (!error) {
            if(posts.count !=0){
                NSDictionary *item = posts[0];
                [LoginSqlite insertData:[item objectForKey:@"userId"] datakey:@"userId"];
                [LoginSqlite insertData:[item objectForKey:@"deviceToken"] datakey:@"deviceToken"];
                [LoginSqlite insertData:item[@"userName"] datakey:@"userName"];
                [LoginSqlite insertData:@"Personal" datakey:@"userType"];
                RecommendProjectViewController *recProjectView = [[RecommendProjectViewController alloc] init];
                [self.navigationController pushViewController:recProjectView animated:YES];
            }
        }
    } dic:parameters noNetWork:^{
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)isRule:(NSString*)phone{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9@_-]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches ==phone.length) {
        return YES;
    }else{
        [self remindErrorView:@"密码不符合规则"];
        return NO;
    }
}

//判断用户名是否含有特殊字符
-(BOOL)isRule2:(NSString*)phone{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches ==phone.length) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)isAllNumber:(NSString*)numbers{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:numbers options:0 range:NSMakeRange(0, [numbers length])];
    NSLog(@"===%d",numberOfMatches);
    if (numberOfMatches) {
        return NO;
    }else{
        [self remindErrorView:@"用户名不能为纯数字"];
        return YES;
    }
}

-(BOOL)LetterNoErr:(NSString *)phone
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches ==phone.length) {
        [self remindErrorView:@"密码不能为全英文"];
        return NO;
    }
    return YES;
}

-(BOOL)NumberNoErr:(NSString *)phone
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches ==phone.length) {
        [self remindErrorView:@"密码不能为全数字"];
        return NO;
    }
    return YES;
}

-(BOOL)SymbolNoErr:(NSString *)phone
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[-@_]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches ==phone.length) {
        [self remindErrorView:@"密码不能为全符号"];
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if(textField == passWordField){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 20) {
            passWordField.text = [toBeString substringToIndex:20];
            return NO;
        }
        return YES;
    }else if (textField == verifyPassWordField){
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 20) {
            verifyPassWordField.text = [toBeString substringToIndex:20];
            return NO;
        }
        return YES;
    }else{
        return YES;
    }
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 20) {
                textField.text = [toBeString substringToIndex:20];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > 20) {
            textField.text = [toBeString substringToIndex:20];
        }
    }
}

//判断是否是表情
- (BOOL)isContainsEmoji:(NSString *)string {
    NSLog(@"%@",string);
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    NSLog(@"注册dealloc");
}


@end
