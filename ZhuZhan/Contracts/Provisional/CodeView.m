//
//  CodeView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/31.
//
//

#import "CodeView.h"

@implementation CodeView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLabel];
        [self addSubview:self.codeLabel];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = AllLightGrayColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"创建时间：";
    }
    return _titleLabel;
}

-(UILabel *)codeLabel{
    if(!_codeLabel){
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 42, 180, 16)];
        _codeLabel.textColor = AllLightGrayColor;
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.font = [UIFont systemFontOfSize:16];
        _codeLabel.text = @"流水号：";
    }
    return _codeLabel;
}
@end
