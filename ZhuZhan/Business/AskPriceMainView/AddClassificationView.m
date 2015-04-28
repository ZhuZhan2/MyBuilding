//
//  AddClassificationView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/18.
//
//

#import "AddClassificationView.h"
#import "RKShadowView.h"
@implementation AddClassificationView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.cutLine];
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrowImageView];
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"请选择产品分类";
    }
    return _titleLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 20, 9, 15)];
        _arrowImageView.image = [GetImagePath getImagePath:@"交易_箭头"];
    }
    return _arrowImageView;
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
        self.arrowImageView.frame = CGRectMake(287, (32+label.frame.size.height)/2, 7, 15);
    }
    if(block){
        block(height);
    }
}

@end
