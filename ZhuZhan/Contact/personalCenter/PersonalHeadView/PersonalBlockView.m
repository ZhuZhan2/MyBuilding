//
//  PersonalBlockView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/17.
//
//

#import "PersonalBlockView.h"
@interface PersonalBlockView()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *blockBtn;
@end
@implementation PersonalBlockView

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.blockBtn];
    }
    return self;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _titleLabel;
}

-(UIButton *)blockBtn{
    if(!_blockBtn){
        _blockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _blockBtn.frame = CGRectMake(0, 0, 60, 60);
        [_blockBtn addTarget:self action:@selector(blockBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blockBtn;
}

-(void)setImage:(UIImage *)image{
    self.imageView.image = image;
}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

-(void)setIndex:(int)index{
    self.blockBtn.tag = index;
}

-(void)blockBtnAction:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(clickButton:)]){
        [self.delegate clickButton:(int)button.tag];
    }
}
@end
