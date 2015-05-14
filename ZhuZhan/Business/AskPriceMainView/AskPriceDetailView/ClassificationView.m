//
//  ClassificationView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/23.
//
//

#import "ClassificationView.h"

@implementation ClassificationView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLabel];
        [self addSubview:self.shadowView];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _cutLine;
}

-(UIView *)shadowView{
    if(!_shadowView){
        _shadowView = [RKShadowView seperatorLineShadowViewWithHeight:10];
    }
    return _shadowView;
}

-(void)GetHeightWithBlock:(void (^)(double))block str:(NSString *)str name:(NSString *)name{
    self.titleLabel.text = name;
    __block int height = 60;
    if(![str isEqualToString:@""]){
        CGRect bounds=[str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 42, 280, bounds.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines =0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:16];
        label.text = str;
        [self addSubview:label];
        height = 60+bounds.size.height;
    }
    self.shadowView.center = CGPointMake(160, height-5);
    if(block){
        block(height);
    }
}

-(void)setIsNeedCutLine:(BOOL)isNeedCutLine{
    if(isNeedCutLine){
        [self addSubview:self.cutLine];
    }
}
@end
