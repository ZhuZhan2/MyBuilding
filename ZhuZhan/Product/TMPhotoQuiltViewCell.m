//
//  TMQuiltView
//
//  Created by Bruno Virlet on 7/20/12.
//
//  Copyright (c) 2012 1000memories

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//


#import "TMPhotoQuiltViewCell.h"

const CGFloat kTMPhotoQuiltViewMargin = 5;

@interface TMPhotoQuiltViewCell ()
@property(nonatomic,strong)UIImageView* commentIcon;
@property(nonatomic,strong)UIView* separatorLine;
@end

@implementation TMPhotoQuiltViewCell

- (void)dealloc {
     NSLog(@"TMPhotoQuiltViewCell dealloc");
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = RGBCOLOR(215, 216, 215);
        _photoView.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = nameFont;
        _nameLabel.textColor=BlueColor;
       // _nameLabel.backgroundColor=[UIColor greenColor];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines=2;
        _titleLabel.font=titleFont;
        _titleLabel.textColor=GrayColor;
       // _titleLabel.backgroundColor=[UIColor blueColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.textColor=BlueColor;
        _commentCountLabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_commentCountLabel];
    }
    return _commentCountLabel;
}

-(UIImageView *)commentIcon{
    if (!_commentIcon) {
        UIImage* image=[GetImagePath getImagePath:@"产品－列表_06a"];
        _commentIcon=[[UIImageView alloc]initWithImage:image];
        _commentIcon.image=image;
        [self addSubview:_commentIcon];
    }
    return _commentIcon;
}

-(UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-20, 1)];
        _separatorLine.backgroundColor=RGBCOLOR(206, 206, 206);
        [self addSubview:_separatorLine];
    }
    return _separatorLine;
}

CGFloat returnOriginY(CGRect frame){
    return frame.origin.y+frame.size.height;
}

- (void)layoutSubviews {
    //产品描述内容是否存在
    BOOL productContentExist=![self.titleLabel.text isEqualToString:@""];

    //产品图片
    self.photoView.frame = CGRectMake(0, 0, self.bounds.size.width, [self.model.a_imageUrl isEqualToString:@""]?113:[self.model.a_imageHeight floatValue]*self.bounds.size.width/[self.model.a_imageWidth floatValue]);
    //self.photoView.frame = CGRectMake(0, 0, self.bounds.size.width, 113);


    if ([self.model.a_imageUrl isEqualToString:@""]) {
        self.photoView.image=[GetImagePath getImagePath:@"product_ default_list"];
    }
    
    NSString* name=@"产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称";
    name=@"产品名称";
    CGFloat height=[name boundingRectWithSize:CGSizeMake(self.bounds.size.width-10, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.nameLabel.font} context:nil].size.height;
    CGFloat tempHeight=[name boundingRectWithSize:CGSizeMake(self.bounds.size.width-10, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nameFont} context:nil].size.height;
    tempHeight=tempHeight>=20?40:20;
    self.nameLabel.frame=CGRectMake(5, returnOriginY(self.photoView.frame)+5, self.bounds.size.width-10, tempHeight);
    NSLog(@"height==%lf",height);
    
    
    //判断cell中是否包含产品描述内容
    tempHeight=[self.titleLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size.height;
    tempHeight=tempHeight>=18?36:18;
    BOOL isContainContent=[self.subviews containsObject:self.titleLabel];
    if (productContentExist) {
        if (!isContainContent) [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(5, returnOriginY(self.nameLabel.frame),self.bounds.size.width-10,tempHeight);
    }else{
        if (isContainContent) [self.titleLabel removeFromSuperview];
    }
    
    //评论数量
    self.commentCountLabel.frame =  CGRectMake(35, self.bounds.size.height - 27 ,self.bounds.size.width-40, 20);
    
    //评论图标
    self.commentIcon.center=CGPointMake(20, self.bounds.size.height-15);
    
    //判断cell是否包含分割线
    //BOOL isContainSeparatorLine=[self.subviews containsObject:self.separatorLine];
    //if (productContentExist) {
        //if (!isContainSeparatorLine) [self addSubview:self.separatorLine];
        self.separatorLine.center=CGPointMake(self.bounds.size.width*.5, self.bounds.size.height-30);
   // }else{
       // if (isContainSeparatorLine) [self.separatorLine removeFromSuperview];
    //}
  
    //cell的阴影
    self.layer.shadowColor=[[UIColor grayColor]CGColor];
    self.layer.shadowOffset=CGSizeMake(0, .1);//使阴影均匀
    self.layer.shadowOpacity=.5;//阴影的alpha

}

-(void)setImageSize:(CGSize)imageSize{
    _imageSize = imageSize;
}
@end
