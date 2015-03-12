//
//  ForgetPasswordFirstController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/15.
//
//

#import "ForgetPasswordFirstController.h"
#import "ForgetPasswordSecondController.h"
#import "PooCodeView.h"
#import "RemindView.h"
#import "LoginModel.h"
#import "MBProgressHUD.h"
@interface ForgetPasswordFirstController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIFont* font;
@property(nonatomic,strong)UIButton* registerBtn;
@property (nonatomic, retain) PooCodeView *codeView;
@end

@implementation ForgetPasswordFirstController

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
    _phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,5,276,47)];
    _phoneNumberTextField.delegate = self;
    _phoneNumberTextField.font=self.font;
    _phoneNumberTextField.textAlignment=NSTextAlignmentLeft;
    _phoneNumberTextField.placeholder=@"填写手机号/用户名";
    _phoneNumberTextField.returnKeyType=UIReturnKeyDone;
    _phoneNumberTextField.clearButtonMode =YES;
    _phoneNumberTextField.tag = 0;
    [firstView addSubview:_phoneNumberTextField];
    
    //新建验证码文本框
    _yzmTextField = [[UITextField alloc] initWithFrame:CGRectMake(22,52,170,47)];
    _yzmTextField.delegate = self;
    _yzmTextField.font=self.font;
    _yzmTextField.textAlignment=NSTextAlignmentLeft;
    _yzmTextField.placeholder=@"验证码";
    _yzmTextField.returnKeyType=UIReturnKeyDone;
    _yzmTextField.clearButtonMode =YES;
    _yzmTextField.tag = 1;
    [firstView addSubview:_yzmTextField];
    
//    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    getCodeBtn.frame = CGRectMake(208,57,91,28);
//    [getCodeBtn setImage:[GetImagePath getImagePath:@"密码找回_15"] forState:UIControlStateNormal];
//    [getCodeBtn addTarget:self action:@selector(getVerifitionCode) forControlEvents:UIControlEventTouchUpInside];
    //[firstView addSubview:getCodeBtn];
    self.codeView = [[PooCodeView alloc] initWithFrame:CGRectMake(208,62,91,28)];
    [firstView addSubview:self.codeView];
}

-(void)getVerifitionCode{
    NSLog(@"用户申请发送验证码");
    if (![self phoneNoErr:_phoneNumberTextField.text]) {
        return;
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
    [self companyRemindView];
    [self getCallPhoneBtn];
}

-(void)companyRemindView{
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"密码找回_03"]];
    imageView.center=CGPointMake(30, 200.5);
    [self.view addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(43, 193, 150, 15)];
    label.textColor=RGBCOLOR(135, 135, 135);
    label.font=[UIFont systemFontOfSize:13.5];
    label.text=@"公司账户请联系客服";
    [self.view addSubview:label];
}

-(void)getCallPhoneBtn{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"拨打电话" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR(88, 198, 143) forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13.5];
    btn.frame=CGRectMake(210, 193, 100, 15);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(callPhoneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)callPhoneBtnClicked{
    //NSString* str=@"tel://65383309";//前台
    //NSString* str=@"tel://13641672889";//gll
    //NSString* str=@"tel://18755481541";//wxp
    NSString* str=@"tel://4006697262";//客服电话
    NSString* deviceType=[UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPhone"]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    }else{
        [RemindView remindViewWithContent:@"此设备不支持拨打电话" superView:self.view centerY:240];
    }
}

-(void)loadRegisterBtn{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 470, 320, 30)];
//    label.text = @"公司账户请联系客服";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = GrayColor;
//    label.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:label];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(22, 500, 276, 42);
    [self.registerBtn setBackgroundImage:[GetImagePath getImagePath:@"注册_08"] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.tag =2014072401;
    [self.view addSubview:self.registerBtn];
}

-(void)beginToCollect{
    NSLog(@"用户确认");
//    ForgetPasswordSecondController *forgetSecondView = [[ForgetPasswordSecondController alloc] init];
//    [self.navigationController pushViewController:forgetSecondView animated:YES];
//    return;
    NSString* originStr=self.codeView.changeString;
    [self.codeView change];
    [self.codeView setNeedsDisplay];
    
    if (!_phoneNumberTextField.text.length) {
        [RemindView remindViewWithContent:@"请填写手机号/用户名" superView:self.view centerY:240];
        return;
    }
    
    NSLog(@"%@,%@",_yzmTextField.text,originStr);
    if(!([_yzmTextField.text compare:originStr options:NSCaseInsensitiveSearch|NSNumericSearch]==0)){
        [RemindView remindViewWithContent:@"验证码错误" superView:self.view centerY:240];
        return;
    }
    
    [LoginModel GetPhoneWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            if ([[NSString stringWithFormat:@"%@",posts[0][@"status"][@"statusCode"]] isEqualToString:@"200"]) {
                if ([posts[0][@"data"][@"userType"] isEqualToString:@"02"]) {
                    [RemindView remindViewWithContent:@"公司账户请联系客服" superView:self.view centerY:240];
                }else{
                    ForgetPasswordSecondController *forgetSecondView = [[ForgetPasswordSecondController alloc] init];
                    //forgetSecondView.userId = posts[0][@"data"][@"userId"];
                    forgetSecondView.cellPhone = posts[0][@"data"][@"cellPhone"];
                    [self.navigationController pushViewController:forgetSecondView animated:YES];
                }
            }else if ([[NSString stringWithFormat:@"%@",posts[0][@"status"][@"statusCode"]] isEqualToString:@"11018"]){
                [RemindView remindViewWithContent:@"该手机号/用户名未注册" superView:self.view centerY:240];
            }
        }
    } userName:_phoneNumberTextField.text noNetWork:^{
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
    }];
    
}

-(BOOL)isAllNumber:(NSString*)numbers{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\D" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:numbers options:0 range:NSMakeRange(0, [numbers length])];
    return !numberOfMatches;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag)
    {
        if ([toBeString length] > 4) {
            _yzmTextField.text = [toBeString substringToIndex:4];
            return NO;
        }
    }
    return YES;
}
@end
