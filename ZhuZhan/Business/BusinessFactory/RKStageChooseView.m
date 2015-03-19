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
@end

#define kChooseViewHeight 46
#define kChooseViewWidth kScreenWidth
#define SelectedColor BlueColor
#define NoSeletedFourStageColor [UIColor blackColor]
#define NoSeletedTwoStageColor AllLightGrayColor
#define StageFont [UIFont systemFontOfSize:16]

@implementation RKStageChooseView
+(RKStageChooseView*)stageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers delegate:(id<RKStageChooseViewDelegate>)delegate{
    RKStageChooseView* stageChooseView=[[RKStageChooseView alloc]initWithFrame:CGRectMake(0, 0, kChooseViewWidth, kChooseViewHeight)];
    stageChooseView.delegate=delegate;
    stageChooseView.stages=stages;
    stageChooseView.numbers=numbers;
    [stageChooseView setUp];
    return stageChooseView;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[RKShadowView seperatorLineInThemeView];
        CGRect frame=_seperatorLine.frame;
        frame.origin.y=CGRectGetMaxY(self.frame);
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
        _underLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.stages.count==4?28:kScreenWidth/2, 3)];
        _underLineView.backgroundColor=BlueColor;
        _underLineView.center=CGPointMake(kChooseViewWidth/4/2, kChooseViewHeight-CGRectGetHeight(_underLineView.frame)*0.5);
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
        
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stageLabelClicked:)];
    [stageLabel addGestureRecognizer:tap];
    return stageLabel;
}

-(void)stageLabelClicked:(UIGestureRecognizer*)gesture{
    [self stageLabelClickedWithSequence:gesture.view.tag];
}

-(void)stageLabelClickedWithSequence:(NSInteger)sequence{
    [self.labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(RKStageAndNumberView*)obj changeColor:idx==sequence?SelectedColor:(self.stages.count==4?NoSeletedFourStageColor:NoSeletedTwoStageColor)];
    }];
    UIView* stageLabel=self.labels[sequence];
    CGPoint center=self.underLineView.center;
    center.x=stageLabel.center.x;
    [UIView animateWithDuration:.3 animations:^{
        self.underLineView.center=center;
    }];
    
    if ([self.delegate respondsToSelector:@selector(stageBtnClickedWithNumber:)]) {
        [self.delegate stageBtnClickedWithNumber:sequence];
    }
}
@end
