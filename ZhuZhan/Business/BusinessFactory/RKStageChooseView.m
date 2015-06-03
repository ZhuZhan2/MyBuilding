//
//  RKStageChooseView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "RKStageChooseView.h"
#import "RKShadowView.h"
#import "RKStageAndNumberView.h"
@interface RKStageChooseView ()
@property(nonatomic,strong)NSArray* stages;
@property(nonatomic,strong)NSArray* numbers;

@property(nonatomic,strong)UIView* underLineView;
@property(nonatomic,strong)NSMutableArray* labels;
@property(nonatomic,strong)UIView* seperatorLine;

@property(nonatomic,weak)id<RKStageChooseViewDelegate>delegate;

@property(nonatomic)BOOL underLineIsWhole;
@property(nonatomic,strong)UIColor* normalColor;
@property(nonatomic,strong)UIColor* highlightColor;
@end

#define kChooseViewHeight 46
#define kChooseViewWidth kScreenWidth
#define StageFont [UIFont systemFontOfSize:16]

@implementation RKStageChooseView
+(RKStageChooseView*)stageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers delegate:(id<RKStageChooseViewDelegate>)delegate underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor*)normalColor highlightColor:(UIColor*)highlightColor{
    RKStageChooseView* stageChooseView = [[RKStageChooseView alloc] initWithFrame:CGRectMake(0, 0, kChooseViewWidth, kChooseViewHeight)];
    stageChooseView.delegate = delegate;
    stageChooseView.stages = stages;
    stageChooseView.numbers = numbers;
    stageChooseView.underLineIsWhole = underLineIsWhole;
    stageChooseView.normalColor = normalColor;
    stageChooseView.highlightColor = highlightColor;
    [stageChooseView setUp];
    return stageChooseView;
}

-(void)changeNumbers:(NSArray *)numbers{
    [self.labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(RKStageAndNumberView*)obj changeNumber:[numbers[idx] integerValue]];
    }];
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[RKShadowView seperatorLineInThemeView];
        CGRect frame=_seperatorLine.frame;
        frame.origin.y=CGRectGetHeight(self.frame);
        _seperatorLine.frame=frame;
    }
    return _seperatorLine;
}

-(NSMutableArray *)labels{
    if (!_labels) {
        _labels=[NSMutableArray array];
    }
    return _labels;
}

-(UIView *)underLineView{
    if (!_underLineView) {
        CGFloat height=3;
        CGFloat y=CGRectGetHeight(self.frame)-height;
        _underLineView=[[UIView alloc]initWithFrame:CGRectMake(0, y, 0, height)];
        _underLineView.backgroundColor=BlueColor;
    }
    return _underLineView;
}

-(void)setUp{
    self.backgroundColor=AllBackMiddleGrayColor;
    NSInteger count=self.stages.count;
    for (int i=0; i<count; i++) {
        RKStageAndNumberView* singleStageLabel=[self getSingleStageLabelWithText:self.stages[i] sequence:i];
        
        CGFloat width=kChooseViewWidth/count;
        CGFloat x=width*(0.5+i);
        CGFloat y=kChooseViewHeight*0.5;
        singleStageLabel.center=CGPointMake(x, y);
        
        [self addSubview:singleStageLabel];
        [self.labels addObject:singleStageLabel];
    }
    [self addSubview:self.seperatorLine];
    [self addSubview:self.underLineView];
    [self stageLabelClickedWithSequence:0];
}

-(RKStageAndNumberView*)getSingleStageLabelWithText:(NSString*)text sequence:(NSInteger)sequence{
    RKStageAndNumberView* stageLabel=self.numbers.count?[RKStageAndNumberView stageAndNumberViewWithStage:text number:[self.numbers[sequence] integerValue]]:[RKStageAndNumberView stageAndNumberViewWithStage:text];
    stageLabel.tag=sequence;
        
//    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stageLabelClicked:)];
//    [stageLabel addGestureRecognizer:tap];
    return stageLabel;
}

-(void)stageLabelClicked:(UIGestureRecognizer*)gesture{
    [self stageLabelClickedWithSequence:gesture.view.tag];
}

-(void)stageLabelClickedWithSequence:(NSInteger)sequence{
    BOOL canChange = YES;
    if ([self.delegate respondsToSelector:@selector(shouldChangeStageToNumber:)]) {
        canChange = [self.delegate shouldChangeStageToNumber:sequence];
    }
    if (!canChange) return;

    
    self.nowStageNumber=sequence;
    
    [self.labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(RKStageAndNumberView*)obj changeColor:idx==sequence?self.highlightColor:self.normalColor];
    }];
    RKStageAndNumberView* stageLabel=self.labels[sequence];
    
    CGRect frame=self.underLineView.frame;
    if (self.underLineIsWhole) {
        frame.size.width=kScreenWidth/self.stages.count;
        frame.origin.x=sequence*kScreenWidth/self.stages.count;
    }else{
        frame.origin.x=CGRectGetMinX(stageLabel.frame)+[stageLabel stageLabelOriginX];
        frame.size.width=[stageLabel stageLabelWidth];
    }

    [UIView animateWithDuration:CGRectGetWidth(self.underLineView.frame)?0.3:0 animations:^{
        self.underLineView.frame=frame;
    }];
    
    if ([self.delegate respondsToSelector:@selector(stageBtnClickedWithNumber:)]) {
        [self.delegate stageBtnClickedWithNumber:sequence];
    }
}

-(void)setNowStageNumber:(NSInteger)nowStageNumber{
    _nowStageNumber=nowStageNumber;
}

- (UIColor *)normalColor{
    if (!_normalColor) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}

- (UIColor *)highlightColor{
    if (!_highlightColor) {
        _highlightColor = BlueColor;
    }
    return _highlightColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject] ;
    CGPoint point = [touch locationInView:self];
    [self stageLabelClickedWithSequence:point.x / (kChooseViewWidth/self.stages.count)];
}
@end
