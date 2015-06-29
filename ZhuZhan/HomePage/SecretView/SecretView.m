//
//  SecretView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/26.
//
//

#import "SecretView.h"
@interface SecretView()<UITextFieldDelegate>
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UITextField *textFiled;
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UIButton *testBtn;//测试
@property(nonatomic,strong)UIButton *productionBtn;//生产
@property(nonatomic,strong)UIButton *predictBtn;//预生产
@property(nonatomic,strong)UIButton *developerBtn;//开发
@end

@implementation SecretView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.closeBtn];
        [self addSubview:self.textFiled];
        [self addSubview:self.saveBtn];
        [self addSubview:self.testBtn];
        [self addSubview:self.predictBtn];
        [self addSubview:self.productionBtn];
        [self addSubview:self.developerBtn];
    }
    return self;
}

-(UITextField *)textFiled{
    if(!_textFiled){
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
        _textFiled.delegate = self;
        _textFiled.placeholder = @"输入服务器地址";
        _textFiled.returnKeyType = UIReturnKeyDone;
    }
    return _textFiled;
}

-(UIButton *)saveBtn{
    if(!_saveBtn){
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(40, 100, 260, 30);
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.backgroundColor = [UIColor greenColor];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(40, 300, 260, 30);
        _closeBtn.backgroundColor = [UIColor greenColor];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UIButton *)testBtn{
    if(!_testBtn){
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _testBtn.frame = CGRectMake(40, 140, 60, 40);
        _testBtn.backgroundColor = [UIColor greenColor];
        [_testBtn setTitle:@"测试" forState:UIControlStateNormal];
        [_testBtn addTarget:self action:@selector(testBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}

-(UIButton *)predictBtn{
    if(!_predictBtn){
        _predictBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _predictBtn.frame = CGRectMake(120, 140, 60, 40);
        _predictBtn.backgroundColor = [UIColor greenColor];
        [_predictBtn setTitle:@"预生产" forState:UIControlStateNormal];
        [_predictBtn addTarget:self action:@selector(predictBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _predictBtn;
}

-(UIButton *)productionBtn{
    if(!_productionBtn){
        _productionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _productionBtn.frame = CGRectMake(200, 140, 60, 40);
        _productionBtn.backgroundColor = [UIColor greenColor];
        [_productionBtn setTitle:@"生产" forState:UIControlStateNormal];
        [_productionBtn addTarget:self action:@selector(productionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productionBtn;
}

-(UIButton *)developerBtn{
    if(!_developerBtn){
        _developerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _developerBtn.frame = CGRectMake(40, 200, 60, 40);
        _developerBtn.backgroundColor = [UIColor greenColor];
        [_developerBtn setTitle:@"开发" forState:UIControlStateNormal];
        [_developerBtn addTarget:self action:@selector(developerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _developerBtn;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textFiled resignFirstResponder];
    return YES;
}

-(void)closeBtnAction{
    if([self.delegate respondsToSelector:@selector(closeView)]){
        [self.delegate closeView];
    }
}

-(void)saveBtnAction{
    NSLog(@"%@",self.textFiled.text);
    if(![self.textFiled.text isEqualToString:@""]){

    }
}

-(void)testBtnAction{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"切换到测试服" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"http://10.1.5.104:9090/server" forKey:@"serverAddress"];
    [userDefaults setObject:@"10.1.5.104" forKey:@"socketServer"];
    [userDefaults setInteger:54455 forKey:@"socketPort"];
    [userDefaults setObject:@"http://10.1.5.104:9090/im" forKey:@"socketHttp"];
    [userDefaults synchronize];
    NSLog(@"%@",[userDefaults objectForKey:@"serverAddress"]);
}

-(void)predictBtnAction{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"切换到预生产服" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"http://apis.shenjigroup.com:15427/WebService" forKey:@"serverAddress"];
    [userDefaults setObject:@"apis.shenjigroup.com" forKey:@"socketServer"];
    [userDefaults setInteger:1428 forKey:@"socketPort"];
    [userDefaults setObject:@"http://apis.shenjigroup.com:15428/ImService" forKey:@"socketHttp"];
    [userDefaults synchronize];
    NSLog(@"%@",[userDefaults objectForKey:@"serverAddress"]);
}

-(void)productionBtnAction{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"切换到正式服" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"http://apis.mybuilding.cn:15427/WebService" forKey:@"serverAddress"];
    [userDefaults setObject:@"apis.mybuilding.cn" forKey:@"socketServer"];
    [userDefaults setInteger:1428 forKey:@"socketPort"];
    [userDefaults setObject:@"http://apis.mybuilding.cn:15428/ImService" forKey:@"socketHttp"];
    [userDefaults synchronize];
    NSLog(@"%@",[userDefaults objectForKey:@"serverAddress"]);
}

-(void)developerBtnAction{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"切换到开发服" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"http://10.1.5.104:8080/server" forKey:@"serverAddress"];
    [userDefaults setObject:@"10.1.5.104" forKey:@"socketServer"];
    [userDefaults setInteger:44455 forKey:@"socketPort"];
    [userDefaults setObject:@"http://10.1.5.104:8080/im" forKey:@"socketHttp"];
    [userDefaults synchronize];
    NSLog(@"%@",[userDefaults objectForKey:@"serverAddress"]);
}
@end
