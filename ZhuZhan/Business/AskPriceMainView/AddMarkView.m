//
//  AddMarkView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import "AddMarkView.h"
#import "EndEditingGesture.h"
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

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _cutLine;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 22, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"需求描述";
    }
    return _titleLabel;
}

-(UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(26, 42, 280, 200)];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}

-(UILabel *)placeLabel{
    if(!_placeLabel){
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 51, 280, 15)];
        _placeLabel.font = [UIFont systemFontOfSize:15];
        _placeLabel.textColor = AllNoDataColor;
        _placeLabel.text = @"请输入需求描述 (限500字)";
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
    NSArray *array = [UITextInputMode activeInputModes];
    if (array.count > 0) {
        UITextInputMode *textInputMode = [array firstObject];
        NSString *lang = [textInputMode primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            if (textView.text.length != 0) {
                int a = [textView.text characterAtIndex:textView.text.length - 1];
                if( a > 0x4e00 && a < 0x9fff) { // PINYIN 手写的时候 才做处理
                    if (textView.text.length >= strCount) {
                        textView.text = [textView.text substringToIndex:strCount];
                    }
                }
            }
        } else {
            if (textView.text.length >= strCount) {
                textView.text = [textView.text substringToIndex:strCount];
            }
        }
    }
    
    self.placeLabel.alpha=!textView.text.length;
}
@end
