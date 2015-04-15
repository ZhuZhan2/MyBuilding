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
        _textView.placeHolder = @"请输入合同主要条款";
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
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
@end
