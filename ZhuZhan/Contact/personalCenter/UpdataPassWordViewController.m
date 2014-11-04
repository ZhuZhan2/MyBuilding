//
//  UpdataPassWordViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-10-10.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "UpdataPassWordViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface UpdataPassWordViewController ()

@end

@implementation UpdataPassWordViewController

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
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UILabel *oldPassWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 60, 30)];
    oldPassWord.textColor = BlueColor;
    oldPassWord.text = @"原密码";
    oldPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.view addSubview:oldPassWord];
    
    oldPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(92, 70, 200, 30)];
    oldPassWordTextField.placeholder = @"原密码";
    oldPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    oldPassWordTextField.delegate = self;
    oldPassWordTextField.secureTextEntry = YES;
    oldPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [oldPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:oldPassWordTextField];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 105, 290, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:lineImage];
    lineImage.alpha = 0.2;
    
    UILabel *newPassWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 115, 60, 30)];
    newPassWord.textColor = BlueColor;
    newPassWord.text = @"新密码";
    newPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.view addSubview:newPassWord];
    
    newPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(92, 115, 200, 30)];
    newPassWordTextField.placeholder = @"新密码";
    newPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    newPassWordTextField.delegate = self;
    newPassWordTextField.secureTextEntry = YES;
    newPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [newPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:newPassWordTextField];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 150, 290, 1)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:lineImage2];
    lineImage2.alpha = 0.2;
    
    UILabel *newAgainPassWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 60, 30)];
    newAgainPassWord.textColor = BlueColor;
    newAgainPassWord.text = @"重复密码";
    newAgainPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.view addSubview:newAgainPassWord];
    
    newAgainPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(92, 160, 200, 30)];
    newAgainPassWordTextField.placeholder = @"再次输入";
    newAgainPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    newAgainPassWordTextField.delegate = self;
    newAgainPassWordTextField.secureTextEntry = YES;
    newAgainPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [newAgainPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:newAgainPassWordTextField];
    
    UIImageView *lineImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 195, 290, 1)];
    [lineImage3 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:lineImage3];
    lineImage3.alpha = 0.2;
    
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(22, 205, 276, 42);
    [confirmBtn setImage:[GetImagePath getImagePath:@"用户条款_05"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(updataPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)leftBtnClick{//退出到前一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)updataPassWordAction{
    if(![newPassWordTextField.text isEqualToString:newAgainPassWordTextField.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"二次密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:oldPassWordTextField.text forKey:@"oldPassword"];
        [dic setValue:newPassWordTextField.text forKey:@"newPassword"];
        //[dic setValue:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"] forKey:@"token"];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
