//
//  MoneyView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "MoneyView.h"
#import "EndEditingGesture.h"
@implementation MoneyView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLabel];
        [self addSubview:self.cutLine];
        [self addSubview:self.imageView];
        [self addSubview:self.textFied];
        [EndEditingGesture addGestureToView:self];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"金额（人民币）";
    }
    return _titleLabel;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 18, 6, 6)];
        _imageView.image = [GetImagePath getImagePath:@"star"];
    }
    return _imageView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _cutLine;
}

-(UITextField *)textFied{
    if(!_textFied){
        _textFied = [[UITextField alloc] initWithFrame:CGRectMake(26, 42, 280, 30)];
        _textFied.delegate = self;
        _textFied.placeholder = @"请输入金额";
        [_textFied setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    }
    return _textFied;
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
