//
//  RKLeftAndRightView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "RKLeftAndRightView.h"

@interface RKLeftAndRightView()
@property(nonatomic,strong)UILabel* leftLabel;
@property(nonatomic,strong)UILabel* rightLabel;

@property(nonatomic)CGFloat topDistance;
@property(nonatomic)CGFloat bottomDistance;
@property(nonatomic)CGFloat maxWidth;

@property(nonatomic,copy)NSString* leftContent;
@property(nonatomic,copy)NSString* rightContent;
@end
#define ContentFont [UIFont systemFontOfSize:15]
#define kContentMaxWidth 196
@implementation RKLeftAndRightView
+(RKLeftAndRightView*)upAndDownViewWithUpContent:(NSString*)upContent downContent:(NSString*)downContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth{
    RKLeftAndRightView* view=[[RKLeftAndRightView alloc]init];
    view.topDistance=topDistance;
    view.bottomDistance=bottomDistance;
    view.maxWidth=maxWidth;
    
    view.leftContent=upContent;
    view.rightContent=downContent;
    [view setUp];
    return view;
}

-(void)setUp{
    self.leftLabel.text=self.leftContent;
    self.rightLabel.text=self.rightContent;
    
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    
    CGFloat height=self.topDistance;
    
    CGSize size=[self carculateSizeWithLabel:self.leftLabel];
    CGRect frame=self.leftLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    self.leftLabel.frame=frame;

    size=[self carculateSizeWithLabel:self.rightLabel];
    frame=self.rightLabel.frame;
    frame.size=size;
    frame.origin.y=height;
    frame.origin.x=self.maxWidth-kContentMaxWidth;
    self.rightLabel.frame=frame;
    height+=CGRectGetHeight(self.rightLabel.frame);
    
    height+=self.bottomDistance;
    self.frame=CGRectMake(0, 0, self.maxWidth, height);
}

-(CGSize)carculateSizeWithLabel:(UILabel*)label{
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(kContentMaxWidth, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return size;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _leftLabel.font=ContentFont;
        _leftLabel.numberOfLines=0;
        _leftLabel.textColor=BlueColor;
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _rightLabel.font=ContentFont;
        _rightLabel.numberOfLines=0;
        _rightLabel.textColor=AllDeepGrayColor;
    }
    return _rightLabel;
}
@end
