//
//  NBLabel.m
//  图文混排,除第一行,末尾为...
//
//  Created by 孙元侃 on 14-9-29.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "NBLabel.h"

@interface NBLabel ()
@property(nonatomic)CGFloat labelWidth;
@property(nonatomic)CGSize imageSize;
@property(nonatomic,strong)UIFont* font;
@property(nonatomic)CGFloat lineHeight;

//放入label的属性字符串
@property(nonatomic,strong)NSMutableAttributedString* mutableAttributedString;
//用于计算长度的可变字符串
@property(nonatomic,strong)NSMutableString* mutableString;
@property(nonatomic)NSInteger surplusCount;
@property(nonatomic)CGFloat tempTextWidth;
@property(nonatomic)NSInteger charCount;
@end

@implementation NBLabel
+(NBLabel *)labelWithLabelWidth:(CGFloat)labelWidth imageSize:(CGSize)imageSize font:(UIFont*)font lineHeight:(CGFloat)lineHeight{
    return [[NBLabel alloc]initWithLabelWidth:labelWidth imageSize:imageSize font:font lineHeight:lineHeight];
}

-(instancetype)initWithLabelWidth:(CGFloat)labelWidth imageSize:(CGSize)imageSize font:(UIFont*)font lineHeight:(CGFloat)lineHeight{
    if (self=[super init]) {
        self.labelWidth=labelWidth;
        self.imageSize=imageSize;
        self.lineHeight=lineHeight;
        self.font=font;
    }
    return self;
}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    _attributedText=attributedText;
    self.mutableAttributedString=[attributedText mutableCopy];
    [self getLabel];
}

-(NSMutableString *)mutableString{
    return [[self.mutableAttributedString string]mutableCopy];
}

-(NSInteger)surplusCount{
    return self.mutableAttributedString.length;
}

-(void)getLabel{
    self.line=0;
    for (int i=0; i<3; i++) {
        [self caculatorCharCount];
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, self.lineHeight*i, self.labelWidth, self.lineHeight)];
        label.font=self.font;
        label.attributedText=[self.mutableAttributedString attributedSubstringFromRange:NSMakeRange(0, i!=2?self.charCount:self.surplusCount)];
        [self.mutableAttributedString deleteCharactersInRange:NSMakeRange(0, self.charCount)];
        [self addSubview:label];

        self.line++;
        if (self.surplusCount==0||self.line==3) {
            if (i) {
                CGRect frame=label.frame;
                frame.size.width-=self.imageSize.width;
                [self.subviews.lastObject setFrame:frame];
            }
            break;
        }
    }
    self.frame=CGRectMake(0,0, self.labelWidth, self.line*self.lineHeight+(self.line==1?self.imageSize.height:(self.imageSize.height-self.lineHeight)));
}

-(CGFloat)tempTextWidth{
    return [[self.mutableString substringToIndex:self.charCount] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,self.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.width;
}

-(void)caculatorCharCount{
    self.charCount=1;
    while (self.tempTextWidth<=self.labelWidth) {
        self.charCount++;
        if (self.charCount>self.surplusCount)break;
    }
    self.charCount--;
}
@end
