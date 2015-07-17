//
//  MyPointContentView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/17.
//
//

#import "MyPointContentView.h"

@implementation MyPointContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.contentLabel];
        [self addSubview:self.imageView];
    }
    return self;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 60)];
        _contentLabel.numberOfLines = 4;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
        _contentLabel.text = @"testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest";
    }
    return _contentLabel;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(31, 75, 258, 90)];
        _imageView.image = [GetImagePath getImagePath:@"我的积分_介绍图"];
    }
    return _imageView;
}
@end
