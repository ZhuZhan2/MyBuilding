//
//  ReceiveView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "ReceiveView.h"

@implementation ReceiveView
-(id)initWithFrame:(CGRect)frame isOver:(BOOL)isOver{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.titleLabel];
        [self addSubview:self.cutLine];
        if(!isOver){
            [self addSubview:self.imageView];
            [self addSubview:self.addView];
        }
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"接收者";
    }
    return _titleLabel;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 18, 6, 6)];
        _imageView.image = [GetImagePath getImagePath:@"star"];
    }
    return _imageView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _cutLine;
}

-(UIView *)addView{
    if(!_addView){
        _addView = [[UIView alloc] initWithFrame:CGRectMake(26, 38, 180, 22)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 22)];
        imageView.image = [GetImagePath getImagePath:@"交易_添加"];
        [_addView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27, 3, 50, 16)];
        label.textColor = AllGreenColor;
        label.text = @"添加";
        label.font = [UIFont systemFontOfSize:16];
        [_addView addSubview:label];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(0, 0, 180, 22);
        [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_addView addSubview:addBtn];
    }
    return _addView;
}

-(void)GetHeightWithBlock:(void (^)(double))block str:(NSString *)str{
    __block int height = 0;
    if(str != nil){
        CGRect bounds=[str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 37, 240, bounds.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines =0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont systemFontOfSize:16];
        label.text = str;
        [self addSubview:label];
        [self.addView setFrame:CGRectMake(26, bounds.size.height+44, 180, 22)];
        height = 75+bounds.size.height;
    }
    if(block){
        block(height);
    }
}

-(void)GetHeightOverWithBlock:(void (^)(double height))block str:(NSString *)str{
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
        height = 42+bounds.size.height;
    }
    if(block){
        block(height);
    }
}

-(void)addBtnAction{
    NSLog(@"addBtnAction");
}
@end
