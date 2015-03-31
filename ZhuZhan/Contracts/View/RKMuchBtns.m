//
//  RKMuchBtns.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/27.
//
//

#import "RKMuchBtns.h"
#import "RKMuchBtnAssistView.h"
#import "RKShadowView.h"
#define NormalTextColor [UIColor whiteColor]
#define NormalBackColor RGBCOLOR(222, 222, 222)
#define HighlightTextColor AllDeepGrayColor
#define HighlightBackColor AllBackMiddleGrayColor

@interface RKMuchBtns()

@property (nonatomic,strong) NSArray* contents;
@property (nonatomic,strong) NSMutableArray* contentLabels;
@property (nonatomic)CGSize mainSize;

@property (nonatomic, strong)NSMutableArray* assistViews;
@property (nonatomic)CGSize assistSize;
@property (nonatomic, strong)NSArray* assistStageCounts;

@property (nonatomic, strong)NSMutableArray* seperatorLines;

@property (nonatomic, strong)UIView* shadowView;

@property (nonatomic,weak) id<RKMuchBtnsDelegate>delegate;

@property (nonatomic) CGFloat singleWidth;
@property (nonatomic) CGFloat singleHeight;

@property (nonatomic,strong) UIColor* normalTextColor;
@property (nonatomic,strong) UIColor* normalBackColor;
@property (nonatomic,strong) UIColor* highlightTextColor;
@property (nonatomic,strong) UIColor* highlightBackColor;

@end

@implementation RKMuchBtns
+(RKMuchBtns*)muchBtnsWithContents:(NSArray*)contents mainSize:(CGSize)mainSize assistSize:(CGSize)assistSize assistStageCounts:(NSArray *)assistStageCounts delegate:(id<RKMuchBtnsDelegate>)delegate{
    RKMuchBtns* btns=[[RKMuchBtns alloc]initWithFrame:CGRectMake(0, 0, mainSize.width, mainSize.height+assistSize.height)];
    btns.contents=contents;
    btns.mainSize=mainSize;
    btns.assistStageCounts=assistStageCounts;
    btns.assistSize=assistSize;
    btns.delegate=delegate;
    [btns setUp];
    return btns;
}

-(void)setUp{
    [self.contentLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview:obj];
    }];
    
    [self.seperatorLines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview:obj];
    }];
    
    if (self.assistSize.height) {
        [self.assistViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView* assistView=obj;
            [self addSubview:assistView];
            CGRect frame=assistView.frame;
            frame.origin.y=self.mainSize.height;
            assistView.frame=frame;
        }];
    }
    
    [self addSubview:self.shadowView];
    
    //[self contentBtnsClickedWithNumber:0];
}

-(void)contentBtnsClickedWithBtn:(UIButton*)btn{
    [self contentBtnsClickedWithNumber:btn.tag];
}

-(void)contentBtnsClickedWithNumber:(NSInteger)number{
    if ([self.delegate respondsToSelector:@selector(muchBtnsClickedWithNumber:)]) {
        [self.delegate muchBtnsClickedWithNumber:number];
    }
    

    [self.contentLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL isSelected=idx==number;
        UIButton* btn=self.contentLabels[idx];
        UIColor* titleColor=isSelected?self.highlightTextColor:self.normalTextColor;
        UIColor* backColor=isSelected?self.highlightBackColor:self.normalBackColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        btn.backgroundColor=backColor;
    }];
    
//    [self.assistView setContent:@[@"已完成",@"已关闭"][arc4random()%2] stageNumber:number];
    [self.assistViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* assistView=obj;
        assistView.hidden=idx!=number;
    }];
}

-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView=[RKShadowView seperatorLineInThemeView];
        CGRect frame=_shadowView.frame;
        frame.origin.y=CGRectGetMaxY(self.frame);
        _shadowView.frame=frame;
    }
    return _shadowView;
}

-(NSMutableArray *)seperatorLines{
    if (!_seperatorLines) {
        _seperatorLines=[NSMutableArray array];
        [self.contentLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx==self.contentLabels.count-1) *stop=YES;
            CGRect frame=[obj frame];
            CGFloat width=1;
            CGFloat height=CGRectGetHeight(frame);
            CGFloat x=(idx+1)*CGRectGetWidth(frame)-width/2;
            UIView* seperatorLine=[[UIView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
            seperatorLine.backgroundColor=self.highlightBackColor;
            [_seperatorLines addObject:seperatorLine];
        }];
    }
    return _seperatorLines;
}

-(NSMutableArray *)assistViews{
    if (!_assistViews&&self.assistSize.height) {
        _assistViews=[NSMutableArray array];
        for (int i=0;i<self.contentLabels.count;i++) {
            RKMuchBtnAssistView* assistView=[RKMuchBtnAssistView muchBtnAssistViewWithMaxStageCount:[self.assistStageCounts[i] integerValue] size:self.assistSize];
            [_assistViews addObject:assistView];
            
            [assistView setContent:@[@"已完成",@"已关闭"][arc4random()%2] stageNumber:arc4random()%2];
        }
    }
    return _assistViews;
}

-(NSMutableArray *)contentLabels{
    if (!_contentLabels) {
        _contentLabels=[NSMutableArray array];
        [self.contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton* singleLabel=[[UIButton alloc]initWithFrame:CGRectMake(idx*self.singleWidth, 0, self.singleWidth, self.singleHeight)];
            [singleLabel setTitle:self.contents[idx] forState:UIControlStateNormal];
            singleLabel.titleLabel.font=[UIFont systemFontOfSize:14];
            [singleLabel setTitleColor:NormalTextColor forState:UIControlStateNormal];
            singleLabel.backgroundColor=NormalBackColor;
            singleLabel.tag=idx;
            [_contentLabels addObject:singleLabel];
            [singleLabel addTarget:self action:@selector(contentBtnsClickedWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
    return _contentLabels;
}

-(void)setContentLabelWithNumber:(NSInteger)number enabled:(BOOL)enabled{
    UIButton* btn=self.contentLabels[number];
    btn.enabled=enabled;
}

-(CGFloat)singleWidth{
    return CGRectGetWidth(self.frame)/self.contents.count;
}

-(CGFloat)singleHeight{
    return self.mainSize.height;
}

-(UIColor *)normalTextColor{
    if (!_normalTextColor) {
        _normalTextColor=NormalTextColor;
    }
    return _normalTextColor;
}
-(UIColor *)normalBackColor{
    if (!_normalBackColor) {
        _normalBackColor=NormalBackColor;
    }
    return _normalBackColor;
}
-(UIColor *)highlightTextColor{
    if (!_highlightTextColor) {
        _highlightTextColor=HighlightTextColor;
    }
    return _highlightTextColor;
}
-(UIColor *)highlightBackColor{
    if (!_highlightBackColor) {
        _highlightBackColor=HighlightBackColor;
    }
    return _highlightBackColor;
}
-(void)setNormalTextColor:(UIColor*)normalTextColor normalBackColor:(UIColor*)normalBackColor highlightTextColor:(UIColor*)highlightTextColor highlightBackColor:(UIColor*)highlightBackColor{

}
@end
