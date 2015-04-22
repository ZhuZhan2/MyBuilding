//
//  StartManView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "StartManView.h"
#import "RKShadowView.h"
#import "LoginSqlite.h"
@implementation StartManView
-(id)initWithFrame:(CGRect)frame isModified:(BOOL)isModified{
    self = [super initWithFrame:frame];
    if(self){
        [self addCutLine];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contactBtn];
        [self.contactBtn addSubview:self.arrowImageView];
        [self.contactBtn addSubview:self.contactLabel];
        [self addSubview:self.textField];
        [self addSubview:self.messageLabel];
        [self addSubview:self.bottomView];
        if(isModified){
            self.contactBtn.enabled = NO;
            self.textField.enabled = NO;
        }
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, 180, 16)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = [LoginSqlite getdata:@"userName"];
    }
    return _titleLabel;
}

-(UIButton *)contactBtn{
    if(!_contactBtn){
        _contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contactBtn.frame = CGRectMake(0, 49, 320, 47);
        [_contactBtn addTarget:self action:@selector(contactBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contactBtn;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 16, 9, 15)];
        _arrowImageView.image = [GetImagePath getImagePath:@"交易_箭头"];
    }
    return _arrowImageView;
}

-(UILabel *)contactLabel{
    if(!_contactLabel){
        _contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16, 200, 16)];
        _contactLabel.text = @"选择合同角色";
        _contactLabel.textColor = BlueColor;
        _contactLabel.font = [UIFont systemFontOfSize:16];
    }
    return _contactLabel;
}

-(UITextField *)textField{
    if(!_textField){
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 97, 320, 47)];
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _textField.leftView.userInteractionEnabled = NO;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.placeholder = @"请输入公司全名";
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    }
    return _textField;
}

-(UILabel *)messageLabel{
    if(!_messageLabel){
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 145, 250, 16)];
        _messageLabel.textColor = [UIColor redColor];
        _messageLabel.text = @"这里输入的公司全称将用于合同和开票信息";
        _messageLabel.font = [UIFont systemFontOfSize:13];
    }
    return _messageLabel;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [RKShadowView seperatorLineShadowViewWithHeight:10];
        _bottomView.frame = CGRectMake(0, 170, 320, 10);
    }
    return _bottomView;
}

-(void)addCutLine{
    for(int i=0;i<2;i++){
        self.cutLine = [RKShadowView seperatorLine];
        self.cutLine.frame = CGRectMake(0, 48*i+48, 320, 1);
        [self addSubview:self.cutLine];
    }
}

-(void)contactBtnAction{
    if([self.delegate respondsToSelector:@selector(showActionSheet)]){
        [self.delegate showActionSheet];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(textFiedDidBegin:)]){
        [self.delegate textFiedDidBegin:textField];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(textFiedDidEnd:textField:)]){
        [self.delegate textFiedDidEnd:textField.text textField:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}
@end
