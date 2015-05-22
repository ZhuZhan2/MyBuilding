//
//  RKStageAndNumberView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "RKStageAndNumberView.h"

#define StageFont [UIFont systemFontOfSize:16]
#define Font(size) [UIFont systemFontOfSize:size]

@interface RKStageAndNumberView ()
@property(nonatomic)BOOL needNumberLabel;

@property(nonatomic,strong)UILabel* stageLabel;
@property(nonatomic,strong)UILabel* numberLabel;

@property(nonatomic,copy)NSString* stageStr;
@property(nonatomic)NSInteger number;

@property(nonatomic,strong)UIColor* normalColor;
@property(nonatomic,strong)UIColor* highlightColor;
@end

@implementation RKStageAndNumberView
+(RKStageAndNumberView*)stageAndNumberViewWithStage:(NSString*)stage number:(NSInteger)number{
    RKStageAndNumberView* view=[[RKStageAndNumberView alloc]initWithFrame:CGRectZero];
    view.stageStr=stage;
    view.number=number;
    view.needNumberLabel=YES;
    [view setUp];
    return view;
}

-(CGFloat)stageLabelOriginX{
    return CGRectGetMinX(self.stageLabel.frame);
}

-(CGFloat)stageLabelWidth{
    return CGRectGetWidth(self.stageLabel.frame);
}

+(RKStageAndNumberView*)stageAndNumberViewWithStage:(NSString*)stage{
    RKStageAndNumberView* view=[[RKStageAndNumberView alloc]initWithFrame:CGRectZero];
    view.stageStr=stage;
    [view setUp];
    return view;
}

-(void)changeNumber:(NSInteger)number{
    BOOL isOverMax=number>99;
    number=MIN(number, 99);
    self.numberLabel.text=isOverMax?@"···":[NSString stringWithFormat:@"%d",(int)number];
    self.numberLabel.font=[UIFont systemFontOfSize:isOverMax?12:11];
    self.numberLabel.backgroundColor = RGBCOLOR(175, 175, 175);
}

-(void)changeColor:(UIColor *)color{
    self.stageLabel.textColor=color;
}

-(void)setUp{
    [self addSubview:self.stageLabel];
    [self changeNumber:self.number];
    if (self.needNumberLabel) {
        [self addSubview:self.numberLabel];
        CGFloat x=CGRectGetMaxX(self.stageLabel.frame)+CGRectGetWidth(self.numberLabel.frame)*0.5+3;
        CGFloat y=self.stageLabel.center.y;
        self.numberLabel.center=CGPointMake(x, y);
        [self addSubview:self.numberLabel];
    }
    self.frame=CGRectMake(0, 0, CGRectGetMaxX(self.needNumberLabel?self.numberLabel.frame:self.stageLabel.frame), 20);
}

-(UILabel *)stageLabel{
    if (!_stageLabel) {
        CGSize size=[self.stageStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:StageFont} context:nil].size;
        _stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _stageLabel.text=self.stageStr;
        _stageLabel.font=StageFont;
        _stageLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _stageLabel;
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        _numberLabel.textColor=[UIColor whiteColor];
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        _numberLabel.backgroundColor=[UIColor redColor];
        _numberLabel.layer.cornerRadius=CGRectGetWidth(_numberLabel.frame)*0.5;
        _numberLabel.layer.masksToBounds=YES;
    }
    return _numberLabel;
}
@end
