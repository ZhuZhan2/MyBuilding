//
//  RKContractsStagesView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/9.
//
//

#import "RKContractsStagesView.h"
#import "RKShadowView.h"
@interface RKContractsStagesView ()
@property (nonatomic, strong)NSMutableArray* bigStageLabels;//一维
@property (nonatomic, strong)NSMutableArray* smallStageLabels;//二维

@property (nonatomic, strong)NSArray* bigStageNames;//一维
@property (nonatomic, strong)NSArray* smallStageNames;//二维

@property (nonatomic, strong)NSArray* smallStageStyles;//二维

@property (nonatomic, strong)NSMutableArray* smallStageRounds;//二维

@property (nonatomic, strong)NSMutableArray* smallStageLines;//二维

@property (nonatomic)BOOL isClosed;
@end

#define roundWidth 15

@implementation RKContractsStagesView
+(instancetype)contractsStagesViewWithBigStageNames:(NSArray *)bigStageNames smallStageNames:(NSArray *)smallStageNames smallStageStyles:(NSArray *)smallStageStyles isClosed:(BOOL)isClosed{
    return [[self alloc]initWithBigStageNames:bigStageNames smallStageNames:smallStageNames smallStageStyles:smallStageStyles isClosed:isClosed];
}

-(instancetype)initWithBigStageNames:(NSArray *)bigStageNames smallStageNames:(NSArray *)smallStageNames smallStageStyles:(NSArray *)smallStageStyles isClosed:(BOOL)isClosed{
    if (self=[super init]) {
        self.bigStageNames=bigStageNames;
        self.smallStageNames=smallStageNames;
        self.smallStageStyles=smallStageStyles;
        self.isClosed=isClosed;
        self.showsHorizontalScrollIndicator=NO;
        [self setUp];
        self.backgroundColor=AllBackMiddleGrayColor;
    }
    return self;
}

-(NSString*)getRoundImageNameWithStage:(RKContractsSmallStageStyle)contractsSmallStage{
    NSArray* images=@[@"word",@"star",@"xlsx"];
    return images[contractsSmallStage];
}

-(UIColor*)getSmallStageLabelTextColorStage:(RKContractsSmallStageStyle)contractsSmallStage{
    NSArray* colors=@[[UIColor blackColor],AllNoDataColor,[UIColor blackColor]];
    return colors[contractsSmallStage];
}

-(void)setUp{
    const   CGFloat orginCenterX=19;
    const   CGFloat orginCenterY=32;
    const   CGFloat width=133;
    
    __block CGFloat maxWidth=orginCenterX;
    const   CGFloat maxHeight=66;
    
    __block CGFloat nowCenterX=19;
    
    [self.bigStageLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel* singleStageLabel=obj;
        CGPoint center=CGPointMake(nowCenterX, 11);
        if (idx==0) {
            center.x+=CGRectGetWidth(singleStageLabel.frame)*0.5-roundWidth*0.5;
        }else if (idx==self.bigStageLabels.count-1&&[self.smallStageNames[idx] count]==1){
            center.x-=CGRectGetWidth(singleStageLabel.frame)*0.5-roundWidth*0.5;
        }
        singleStageLabel.center=center;
        
        [self addSubview:singleStageLabel];
        
        
        [self.smallStageRounds[idx] enumerateObjectsUsingBlock:^(id tmpObj, NSUInteger tmpIdx, BOOL *tmpStop) {

            
            UILabel* singleSmallStageLabel=self.smallStageLabels[idx][tmpIdx];
            CGPoint tmpCenter=CGPointMake(nowCenterX, 54);
            if (idx==0&&tmpIdx==0) {
                tmpCenter.x+=CGRectGetWidth(singleSmallStageLabel.frame)*0.5-roundWidth*0.5;
            }else if (idx==self.bigStageLabels.count-1&&tmpIdx==[self.smallStageLabels[idx] count]-1){
                tmpCenter.x-=CGRectGetWidth(singleSmallStageLabel.frame)*0.5-roundWidth*0.5;
            }
            singleSmallStageLabel.center=tmpCenter;
            [self addSubview:singleSmallStageLabel];
            
            
            UIView* singleStageRound=tmpObj;
            singleStageRound.center=CGPointMake(nowCenterX, orginCenterY);
            [self addSubview:singleStageRound];
            
            if (idx!=0||tmpIdx!=0) {
                CGPoint tmpCenter=singleStageRound.center;
                UIView* view=self.smallStageLines[idx][tmpIdx];
                tmpCenter.x-=CGRectGetWidth(view.frame)*0.5;
                view.center=tmpCenter;
                [self addSubview:view];
            }
            
            nowCenterX+=width;
            maxWidth+=width;
        }];

    }];
    nowCenterX-=width;
    maxWidth-=width;
    
    maxWidth+=orginCenterX;
    self.frame=CGRectMake(0, 0, kScreenWidth, maxHeight);
    self.contentSize=CGSizeMake(maxWidth, maxHeight);
    self.clipsToBounds=NO;
    UIView* seperatorLine=[RKShadowView seperatorLineInThemeView];
    CGRect frame=seperatorLine.frame;
    frame.origin.y=CGRectGetHeight(self.frame);
    frame.origin.x-=600;
    frame.size.width=maxWidth+1200;
    seperatorLine.frame=frame;
    [self addSubview:seperatorLine];
}

-(NSMutableArray *)smallStageRounds{
    if (!_smallStageRounds) {
        NSMutableArray* rounds=[NSMutableArray array];
        [self.smallStageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSMutableArray* singleStageRounds=[NSMutableArray array];
            
            NSArray* singleStageNames=obj;
            [singleStageNames enumerateObjectsUsingBlock:^(id tmpObj, NSUInteger tmpIdx, BOOL *tmpStop) {
                NSString* imageName=[self getRoundImageNameWithStage:(RKContractsSmallStageStyle)[self.smallStageStyles[idx][tmpIdx] integerValue]];
                UIImage* image=[GetImagePath getImagePath:imageName];
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, roundWidth, roundWidth)];
                imageView.image=image;
                [singleStageRounds addObject:imageView];
            }];
            [rounds addObject:singleStageRounds];
        }];
        _smallStageRounds=rounds;
    }
    return _smallStageRounds;
}

-(NSMutableArray *)smallStageLines{
    if (!_smallStageLines) {
        NSMutableArray* allLines=[NSMutableArray array];
        [self.smallStageRounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray* stageRounds=obj;
            NSMutableArray* singleLines=[NSMutableArray array];
            [stageRounds enumerateObjectsUsingBlock:^(id tmpObj, NSUInteger tmpIdx, BOOL *tmpStop) {
                UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 134, 2)];
                NSString* imageName=[self getRoundImageNameWithStage:(RKContractsSmallStageStyle)[self.smallStageStyles[idx][tmpIdx] integerValue]];
                imageView.image=[GetImagePath getImagePath:imageName];
                [singleLines addObject:imageView];
            }];
            [allLines addObject:singleLines];
        }];
        _smallStageLines=allLines;
    }
    return _smallStageLines;
}

-(NSMutableArray *)bigStageLabels{
    if (!_bigStageLabels) {
        NSMutableArray* stageLabels=[NSMutableArray array];
        [self.bigStageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UILabel* label=[self getLabelWithText:obj style:RKContractsSmallStagesStyleCompleted];
            [stageLabels addObject:label];
        }];
        _bigStageLabels=stageLabels;
    }
    return _bigStageLabels;
}

-(NSMutableArray *)smallStageLabels{
    if (!_smallStageLabels) {
        NSMutableArray* stageLabels=[NSMutableArray array];
        [self.smallStageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSMutableArray* singleStageLabels=[NSMutableArray array];
            
            NSArray* singleStageNames=obj;
            [singleStageNames enumerateObjectsUsingBlock:^(id tempObj, NSUInteger tempIdx, BOOL *tempStop) {
                UILabel* label=[self getLabelWithText:tempObj style:(RKContractsSmallStageStyle)[self.smallStageStyles[idx][tempIdx] integerValue]];
                [singleStageLabels addObject:label];
            }];
            [stageLabels addObject:singleStageLabels];
        }];
        _smallStageLabels=stageLabels;
    }
    return _smallStageLabels;
}

-(UILabel*)getLabelWithText:(NSString*)text style:(RKContractsSmallStageStyle)style{
    UILabel* label=[[UILabel alloc]init];
    label.text=text;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[self getSmallStageLabelTextColorStage:style];

    CGRect frame=[text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    label.frame=frame;
    return label;
}
@end
