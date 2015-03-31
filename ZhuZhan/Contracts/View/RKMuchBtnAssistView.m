//
//  RKMuchBtnAssistView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "RKMuchBtnAssistView.h"

@interface RKMuchBtnAssistView ()
@property (nonatomic, strong)NSMutableArray* stageLines;
@property (nonatomic, strong)NSMutableArray* stageRounds;
@property (nonatomic)NSInteger maxStageCount;

@property (nonatomic, strong)UILabel* stageLabel;
@end
#define StageLineWidth 295
#define HasDataColor AllGreenColor
#define CloseDataColor RGBCOLOR(175, 175, 175)
#define NoDataColor RGBCOLOR(222, 222, 222)

@implementation RKMuchBtnAssistView
+(RKMuchBtnAssistView*)muchBtnAssistViewWithMaxStageCount:(NSInteger)maxStageCount size:(CGSize)size{
    RKMuchBtnAssistView* muchBtnAssistView=[[RKMuchBtnAssistView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    muchBtnAssistView.backgroundColor=AllBackMiddleGrayColor;
    muchBtnAssistView.maxStageCount=maxStageCount;
    [muchBtnAssistView setUp];
    return muchBtnAssistView;
}

-(void)setUp{
    CGFloat minX=(CGRectGetWidth(self.frame)-StageLineWidth)/2;
    [self.stageLines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* stageLine=self.stageLines[idx];
        CGRect frame=stageLine.frame;
        CGFloat x= minX+idx*CGRectGetWidth(frame);
        CGFloat y=(CGRectGetHeight(self.frame)-CGRectGetHeight(frame))/2;
        frame.origin=CGPointMake(x, y);
        stageLine.frame=frame;
        [self addSubview:stageLine];
    }];
    
    [self.stageRounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* stageRound=self.stageRounds[idx];
        CGFloat y=CGRectGetHeight(self.frame)/2;
        CGFloat x;
        if (idx==0) {
            x=minX+CGRectGetWidth(stageRound.frame)/2;
        }else if (idx<=self.stageRounds.count-2){
            UIView* stageLine=self.stageLines[idx];
            x=CGRectGetMinX(stageLine.frame);
        }else{
            UIView* stageLine=self.stageLines.lastObject;
            x=CGRectGetMaxX(stageLine.frame)-CGRectGetWidth(stageRound.frame)/2;
        }
        stageRound.center=CGPointMake(x, y);
        [self addSubview:stageRound];
    }];
    
    [self addSubview:self.stageLabel];
}

-(void)setContent:(NSString*)content stageNumber:(NSInteger)stageNumber{
    BOOL isClose=[content isEqualToString:@"已关闭"];
    UIColor* hasDataColor=isClose?CloseDataColor:HasDataColor;
    UIColor* noDataColor=isClose?CloseDataColor:NoDataColor;
    [self.stageLines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* stageLine=self.stageLines[idx];
        stageLine.backgroundColor=idx<stageNumber?hasDataColor:noDataColor;
    }];
    
    [self.stageRounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* stageRound=self.stageRounds[idx];
        stageRound.backgroundColor=idx<stageNumber?hasDataColor:noDataColor;
    }];
    
    
    CGRect frame=self.stageLabel.frame;
    UIView* stageRound=self.stageRounds[stageNumber];
    CGRect roundFrame=stageRound.frame;
    CGFloat y=stageRound.center.y;
    CGFloat x=stageRound.center.x;
    if (stageNumber==0) {
        x+=CGRectGetWidth(frame)/2-CGRectGetWidth(roundFrame)/2;
    }else if (stageNumber==self.stageRounds.count-1){
        x+=CGRectGetWidth(roundFrame)/2-CGRectGetWidth(frame)/2;
    }
    self.stageLabel.center=CGPointMake(x, y);
    self.stageLabel.textColor=isClose?noDataColor:hasDataColor;
    self.stageLabel.layer.borderColor=self.stageLabel.textColor.CGColor;
    self.stageLabel.text=content;

}

-(UILabel *)stageLabel{
    if (!_stageLabel) {
        _stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        _stageLabel.layer.borderWidth=1;
        _stageLabel.layer.cornerRadius=CGRectGetHeight(_stageLabel.frame)/2;
        _stageLabel.textAlignment=NSTextAlignmentCenter;
        _stageLabel.backgroundColor=self.backgroundColor;
        _stageLabel.font=[UIFont systemFontOfSize:14];
    }
    return _stageLabel;
}

-(NSMutableArray *)stageLines{
    if (!_stageLines) {
        _stageLines=[NSMutableArray array];
        NSInteger const lineCount=self.maxStageCount-1;
        for (int i=0;i<lineCount;i++) {
            CGFloat width=StageLineWidth/lineCount;
            UIView* singleStageLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 1)];
            [_stageLines addObject:singleStageLine];
        }
    }
    return _stageLines;
}

-(NSMutableArray *)stageRounds{
    if (!_stageRounds) {
        _stageRounds=[NSMutableArray array];
        for (int i=0;i<self.maxStageCount;i++) {
            UIView* round=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            round.layer.cornerRadius=CGRectGetWidth(round.frame)/2;
            [_stageRounds addObject:round];
        }
    }
    return _stageRounds;
}
@end
