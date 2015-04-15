//
//  MoneyView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "MoneyView.h"
#import "EndEditingGesture.h"
#import "RKShadowView.h"
@implementation MoneyView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.textFied];
        [self addSubview:self.cutLine];
        [EndEditingGesture addGestureToView:self];
    }
    return self;
}

-(UITextField *)textFied{
    if(!_textFied){
        _textFied = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        _textFied.delegate = self;
        _textFied.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _textFied.leftView.userInteractionEnabled = NO;
        _textFied.leftViewMode = UITextFieldViewModeAlways;
        _textFied.placeholder = @"请输入金额";
        _textFied.font = [UIFont systemFontOfSize:15];
        _textFied.returnKeyType = UIReturnKeyDone;
        [_textFied setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    }
    return _textFied;
}

-(UIView *)cutLine{
    if(!_cutLine){
        _cutLine = [RKShadowView seperatorLine];
        _cutLine.frame = CGRectMake(0, 47, 320, 1);
    }
    return _cutLine;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(textFiedDidBegin)]){
        [self.delegate textFiedDidBegin];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(textFiedDidEnd:)]){
        [self.delegate textFiedDidEnd:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textFied resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(textFiedDidEnd:)]){
        [self.delegate textFiedDidEnd:textField.text];
    }
    return YES;
}
@end
