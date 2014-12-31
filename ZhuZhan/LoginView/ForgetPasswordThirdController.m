//
//  ForgetPasswordThirdController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/15.
//
//

#import "ForgetPasswordThirdController.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "RemindView.h"
#import "LoginModel.h"
#import "MD5.h"
@interface ForgetPasswordThirdController ()
@property(nonatomic,strong)UIFont* font;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UIView *errorView;
@end

@implementation ForgetPasswordThirdController
-(UIFont *)font{
    return [UIFont systemFontOfSize:15];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=RGBCOLOR(245, 246, 248);
    //navi的影藏和颜色
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
    //返还按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    //标题和标题设置
    self.title = @"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    [self endEdit];
    [self loadSecondView];
    [self loadRegisterBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadSecondView{
    UIView* secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 94)];
    secondView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:secondView];
    UIImageView* backView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"注册_02"]];
    [secondView addSubview:backView];
    
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(20, 47, 280, 1)];
    separatorLine.backgroundColor=RGBCOLOR(222, 222, 222);
    [secondView addSubview:separatorLine];
    
    //新建密码文本框
    passWordField = [[UITextField alloc] initWithFrame:CGRectMake(22,0,276,47)];
    passWordField.delegate = self;
    passWordField.font=self.font;
    passWordField.textAlignment=NSTextAlignmentLeft;
    passWordField.placeholder=@"填写新密码6-24位";
    passWordField.returnKeyType=UIReturnKeyDone;
    passWordField.clearButtonMode =YES;
    passWordField.secureTextEntry = YES;
    [secondView addSubview:passWordField];
    
    //确认密码的文本框
    verifyPassWordField = [[UITextField alloc] initWithFrame:CGRectMake(22,47,276,47)];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(void)loadRegisterBtn{
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(22, 500, 276, 42);
    [self.registerBtn setBackgroundImage:[GetImagePath getImagePath:@"密码找回z"] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.tag =2014072401;
    [self.view addSubview:self.registerBtn];
}

-(void)beginToCollect{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if(passWordField.text.length<6){
        [RemindView remindViewWithContent:@"密码大于6位！" superView:self.view centerY:210];
        return;
    }
    
    if(![self LetterNoErr:passWordField.text]){
        return;
    }
    
    if(![self NumberNoErr:passWordField.text]){
        return;
    }
    
    if (![passWordField.text isEqualToString:verifyPassWordField.text]) {
        [RemindView remindViewWithContent:@"密码输入不一致，请重新输入" superView:self.view centerY:210];
        return;
    }
    
    if([passWordField.text isEqualToString:@""])
    {
        [RemindView remindViewWithContent:@"密码不能为空" superView:self.view centerY:210];
        return;
    }
    
    if([verifyPassWordField.text isEqualToString:@""]){
        [RemindView remindViewWithContent:@"重复密码不能为空" superView:self.view centerY:210];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.userId forKey:@"userId"];
    [dic setValue:self.barCode forKey:@"barCode"];
    [dic setValue:[MD5 md5HexDigest:passWordField.text] forKey:@"password"];
    [dic setValue:self.cellPhone forKey:@"cellphone"];
    [LoginModel FindPasswordWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.navigationController.navigationBar.hidden=YES;
            [self.navigationController popToRootViewControllerAnimated:YES];

            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } dic:dic noNetWork:nil];
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

-(BOOL)LetterNoErr:(NSString *)phone
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    NSLog(@"%d",numberOfMatches);
    if (numberOfMatches ==20) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码不能为全英文" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

-(BOOL)NumberNoErr:(NSString *)phone
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    NSLog(@"%d",numberOfMatches);
    if (numberOfMatches ==20) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码不能为全数字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}
@end

