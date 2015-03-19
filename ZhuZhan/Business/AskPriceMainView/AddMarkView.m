//
//  AddMarkView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/19.
//
//

#import "AddMarkView.h"

@implementation AddMarkView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.cutLine];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textView];
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 180, 15)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"需求描述";
    }
    return _titleLabel;
}

-(UITextView *)textView{
    if(!_textView){
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 45, 280, 280)];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _textView;
}
@end
