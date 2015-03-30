//
//  StartManView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "StartManView.h"

@implementation StartManView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"发起者";
    }
    return _titleLabel;
}

-(void)GetHeightWithBlock:(void (^)(double))block str:(NSString *)str{
    __block int height = 0;
    if(str != nil){
        CGRect bounds=[str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 42, 240, bounds.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines =0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:16];
        label.text = str;
        [self addSubview:label];
        height = 52+bounds.size.height;
    }
    if(block){
        block(height);
    }
}
@end
