//
//  RKUpAndDownView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "RKUpAndDownView.h"

@interface RKUpAndDownView()
@property(nonatomic,strong)UILabel* upLabel;
@property(nonatomic,strong)UILabel* downLabel;

@property(nonatomic)CGFloat topDistance;
@property(nonatomic)CGFloat bottomDistance;
@property(nonatomic)CGFloat maxWidth;

@property(nonatomic,copy)NSString* upContent;
@property(nonatomic,copy)NSString* downContent;
@end
#define ContentFont [UIFont systemFontOfSize:15]
@implementation RKUpAndDownView
+(RKUpAndDownView*)upAndDownViewWithUpContent:(NSString*)upContent downContent:(NSString*)downContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth{
    RKUpAndDownView* view=[[RKUpAndDownView alloc]init];
    view.topDistance=topDistance;
    view.bottomDistance=bottomDistance;
    view.maxWidth=maxWidth;
    
    view.upContent=upContent;
    view.downContent=downContent;
    [view setUp];
    return view;
}

-(void)setUp{
    self.upLabel.text=self.upContent;
    self.downLabel.text=self.downContent;
    
    [self addSubview:self.upLabel];
    [self addSubview:self.downLabel];

    
    CGFloat height=self.topDistance;
    
    CGSize size=[self carculateSizeWithLabel:self.upLabel];
    CGRect frame=self.upLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    self.upLabel.frame=frame;
    height+=CGRectGetHeight(self.upLabel.frame);
    
    height+=9;
    size=[self carculateSizeWithLabel:self.downLabel];
    frame=self.downLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    self.downLabel.frame=frame;
    height+=CGRectGetHeight(self.downLabel.frame);
    
    height+=self.bottomDistance;
    
    self.frame=CGRectMake(0, 0, self.maxWidth, height);
}

-(CGSize)carculateSizeWithLabel:(UILabel*)label{
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(self.maxWidth, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return size;
}

-(UILabel *)upLabel{
    if (!_upLabel) {
        _upLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _upLabel.font=ContentFont;
        _upLabel.numberOfLines=0;
        _upLabel.textColor=BlueColor;
    }
    return _upLabel;
}

-(UILabel *)downLabel{
    if (!_downLabel) {
        _downLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _downLabel.font=ContentFont;
        _downLabel.numberOfLines=0;
        _downLabel.textColor=AllDeepGrayColor;
    }
    return _downLabel;
}
@end
