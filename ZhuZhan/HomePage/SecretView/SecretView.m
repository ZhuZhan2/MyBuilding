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
@end

@implementation SecretView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.closeBtn];
        [self addSubview:self.textFiled];
        [self addSubview:self.saveBtn];
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
        exit(0);
    }
}
@end
