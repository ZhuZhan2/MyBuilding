//
//  ContractView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "ContractView.h"
#import "EndEditingGesture.h"
#import "RKShadowView.h"
@implementation ContractView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.textView];
        [EndEditingGesture addGestureToView:self];
    }
    return self;
}

-(MessageTextView *)textView{
    if(!_textView){
        _textView = [[MessageTextView alloc] initWithFrame:CGRectMake(15, 0, 290, 290)];
        _textView.placeHolder = @"1.自乙方协助甲方签订供货合同 个工作日内，\n甲方向乙方支付销售服务费， 人民币 大写（ \n）。\n2.自甲方收到供货合同每笔货款之日起 个工作\n日内，甲方应向乙方支付该笔回款的 %作为销\n售服务费，直至乙方收取的销售服务费累计达\n到本协议约定的费用为止。";
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.returnKeyType  = UIReturnKeyDone;
    }
    return _textView;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.delegate respondsToSelector:@selector(beginTextView)]){
        [self.delegate beginTextView];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if([self.delegate respondsToSelector:@selector(endTextView:)]){
        [self.delegate endTextView:textView.text];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if([self.delegate respondsToSelector:@selector(endTextView:)]){
        [self.delegate endTextView:textView.text];
    }
    return YES;
}
@end
