//
//  AddClassificationView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/18.
//
//

#import "AddClassificationView.h"

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
        _titleLabel.text = @"请选择产品分类";
    }
    return _titleLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 20, 15, 15)];
        _arrowImageView.backgroundColor = [UIColor redColor];
    }
    return _arrowImageView;
}

-(void)GetHeightWithBlock:(void (^)(double))block str:(NSString *)str{
    __block int height = 0;
    if(str != nil){
        CGRect bounds=[str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 180, bounds.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.text = str;
        label.backgroundColor = [UIColor yellowColor];
        [self addSubview:label];
        height = 80;
        self.arrowImageView.frame = CGRectMake(280, (30+label.frame.size.height)/2, 15, 15);
    }
    if(block){
        block(height);
    }
}

@end
