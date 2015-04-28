//
//  AddCategoriesView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/18.
//
//

#import "AddCategoriesView.h"
#import "RKShadowView.h"
@implementation AddCategoriesView
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
        _titleLabel.text = @"请选择产品大类";
    }
    return _titleLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 16, 9, 15)];
        _arrowImageView.image = [GetImagePath getImagePath:@"交易_箭头"];
    }
    return _arrowImageView;
}

-(void)GetHeightWithBlock:(void (^)(double))block str:(NSString *)str{
    __block int height = 0;
    if(str != nil){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 42, 180, 16)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        label.text = str;
        [self addSubview:label];
        height = 72;
        self.arrowImageView.frame = CGRectMake(287, 33, 7, 15);
    }
    if(block){
        block(height);
    }
}
@end
