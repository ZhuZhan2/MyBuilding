//
//  AddMarkView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import "AddMarkView.h"
#import "EndEditingGesture.h"
#import "RKShadowView.h"
#define strCount 500
@implementation AddMarkView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.cutLine];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textView];
        [self addSubview:self.placeLabel];
        [EndEditingGesture addGestureToView:self];
    }
    return self;
}

-(UIView *)cutLine{
    if(!_cutLine){
        _cutLine = [RKShadowView seperatorLine];
    }
    return _cutLine;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 22, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"询价说明";
    }
    return _titleLabel;
}

-(UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(26-4, 42, 280, 200)];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}

-(UILabel *)placeLabel{
    if(!_placeLabel){
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 51, 280, 40)];
        _placeLabel.font = [UIFont systemFontOfSize:15];
        _placeLabel.textColor = AllNoDataColor;
        _placeLabel.numberOfLines = 2;
        _placeLabel.text = @"请输入询价说明 (限500字并且不能含有表情)";
    }
    return _placeLabel;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([@"\n" isEqualToString:text]){
        [textView resignFirstResponder];
        if([self.delegate respondsToSelector:@selector(endTextView:)]){
            [self.delegate endTextView:textView.text];
        }
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    NSInteger limitNumber=strCount;
    NSArray *array = [UITextInputMode activeInputModes];
    if (array.count > 0) {
        UITextInputMode *textInputMode = [array firstObject];
        NSString *lang = [textInputMode primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            if (textView.text.length != 0) {
                UITextRange *selectedRange = [textView markedTextRange];
                //获取高亮部分
                UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
                if (!position) {
                    if (textView.text.length > limitNumber) {
                        textView.text = [textView.text substringToIndex:limitNumber];
                    }
                }else{
                    
                }
            }
        } else {
            if (textView.text.length >= limitNumber) {
                textView.text = [textView.text substringToIndex:limitNumber];
            }
        }
    }

    NSLog(@"%lu",(unsigned long)self.textView.text.length);
    self.placeLabel.alpha=!textView.text.length;
}
@end
