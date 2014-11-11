//
//  ForgetSubViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/11.
//
//

#import "ForgetSubViewController.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "RemindView.h"
@interface ForgetSubViewController ()
@property(nonatomic,strong)UIFont* font;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UIView *errorView;
@end

@implementation ForgetSubViewController
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
    self.title = @"密码找回";
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
    passWordField.placeholder=@"填写新密码";
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

-(void)loadRegisterBtn{
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame = CGRectMake(22, 500, 276, 42);
    [self.registerBtn setBackgroundImage:[GetImagePath getImagePath:@"密码找回_23"] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.tag =2014072401;
    [self.view addSubview:self.registerBtn];
}

-(void)beginToCollect{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
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
    
    
}
@end
