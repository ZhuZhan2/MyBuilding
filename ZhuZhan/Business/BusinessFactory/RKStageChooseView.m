//
//  RKStageChooseView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "RKStageChooseView.h"

@interface RKStageChooseView ()
@property(nonatomic,strong)NSArray* stages;

@property(nonatomic,strong)UIView* underLineView;
@property(nonatomic,strong)NSMutableArray* labels;
@end

#define kChooseViewHeight 48
#define kChooseViewWidth kScreenWidth
#define SelectedColor BlueColor
#define NoSeletedColor [UIColor blackColor]
#define StageFont [UIFont systemFontOfSize:16]

@implementation RKStageChooseView
+(RKStageChooseView *)stageChooseViewWithStages:(NSArray *)stages{
    RKStageChooseView* stageChooseView=[[RKStageChooseView alloc]initWithFrame:CGRectMake(0, 0, kChooseViewWidth, kChooseViewHeight)];
    stageChooseView.stages=stages;
    [stageChooseView setUp];
    return stageChooseView;
}

-(NSMutableArray *)labels{
    if (!_labels) {
        _labels=[NSMutableArray array];
    }
    return _labels;
}

-(UIView *)underLineView{
    if (!_underLineView) {
        _underLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 3)];
        _underLineView.backgroundColor=BlueColor;
    }
    return _underLineView;
}

-(void)setUp{
    self.backgroundColor=[UIColor whiteColor];
    
    for (int i=0; i<self.stages.count; i++) {
        UIView* singleStageLabel=[self getSingleStageLabelWithText:self.stages[i] sequence:i];
        CGFloat width=kChooseViewWidth/4;
        CGFloat x=width*(0.5+i);
        CGFloat y=kChooseViewHeight*0.5;
        singleStageLabel.center=CGPointMake(x, y);
        
        [self addSubview:singleStageLabel];
        [self.labels addObject:singleStageLabel];
    }
    self.underLineView.center=CGPointMake(kChooseViewWidth/4/2, kChooseViewHeight-CGRectGetHeight(self.underLineView.frame)*0.5);
    [self addSubview:self.underLineView];
}

-(UILabel*)getSingleStageLabelWithText:(NSString*)text sequence:(NSInteger)sequence{
    UILabel* stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kChooseViewWidth/self.stages.count, kChooseViewHeight)];
    stageLabel.text=text;
    stageLabel.tag=sequence;
    stageLabel.textAlignment=NSTextAlignmentCenter;
    stageLabel.textColor=NoSeletedColor;
    stageLabel.font=StageFont;
    stageLabel.userInteractionEnabled=YES;
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stageLabelClicked:)];
    [stageLabel addGestureRecognizer:tap];
    return stageLabel;
}

-(void)stageLabelClicked:(UIGestureRecognizer*)gesture{
    [self.labels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UILabel*)obj setTextColor:idx==gesture.view.tag?SelectedColor:NoSeletedColor];
    }];
    CGPoint center=self.underLineView.center;
    center.x=gesture.view.center.x;
    [UIView animateWithDuration:.3 animations:^{
        self.underLineView.center=center;
    }];
}
@end
