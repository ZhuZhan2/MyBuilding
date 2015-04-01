//
//  CodeView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/31.
//
//

#import "CodeView.h"
#import "RKShadowView.h"
@implementation CodeView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLabel];
        [self addSubview:self.codeLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.tradCodeLabel];
        [self addSubview:self.cutLine];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 10, 180, 16)];
        _titleLabel.textColor = AllLightGrayColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"创建时间：";
    }
    return _titleLabel;
}

-(UILabel *)codeLabel{
    if(!_codeLabel){
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 36, 180, 16)];
        _codeLabel.textColor = AllLightGrayColor;
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.font = [UIFont systemFontOfSize:16];
        _codeLabel.text = @"流水号：";
    }
    return _codeLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 10, 195, 16)];
        _timeLabel.textColor = AllLightGrayColor;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:16];
    }
    return _timeLabel;
}

-(UILabel *)tradCodeLabel{
    if(!_tradCodeLabel){
        _tradCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 36, 200, 16)];
        _tradCodeLabel.textColor = AllLightGrayColor;
        _tradCodeLabel.textAlignment = NSTextAlignmentLeft;
        _tradCodeLabel.font = [UIFont systemFontOfSize:16];
    }
    return _tradCodeLabel;
}

-(UIView *)cutLine{
    if(!_cutLine){
        _cutLine = [RKShadowView seperatorLine];
        _cutLine.frame = CGRectMake(0, 63, 320, 2);
    }
    return _cutLine;
}
@end
