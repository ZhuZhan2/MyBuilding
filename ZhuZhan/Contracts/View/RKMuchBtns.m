//
//  RKMuchBtns.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/27.
//
//

#import "RKMuchBtns.h"

#define NormalTextColor [UIColor whiteColor]
#define NormalBackColor AllBackDeepGrayColor
#define HighlightTextColor AllDeepGrayColor
#define HighlightBackColor AllBackLightGratColor

@interface RKMuchBtns()

@property (nonatomic,strong) NSArray* contents;
@property (nonatomic,strong) NSMutableArray* contentLabels;

@property (nonatomic) CGFloat singleWidth;
@property (nonatomic) CGFloat singleHeight;

@property (nonatomic,strong) UIColor* normalTextColor;
@property (nonatomic,strong) UIColor* normalBackColor;
@property (nonatomic,strong) UIColor* highlightTextColor;
@property (nonatomic,strong) UIColor* highlightBackColor;

@end

@implementation RKMuchBtns
+(RKMuchBtns*)getMuchBtnsWithContents:(NSArray*)contents size:(CGSize)size{
    RKMuchBtns* btns=[[RKMuchBtns alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    btns.contents=contents;
    [btns setUp];
    return btns;
}

-(void)setUp{
    [self.contentLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel* label=obj;
        [self addSubview:label];
    }];
    
    
}

-(NSMutableArray *)contentLabels{
    if (!_contentLabels) {
        _contentLabels=[NSMutableArray array];
        [self.contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UILabel* singleLabel=[[UILabel alloc]initWithFrame:CGRectMake(idx*self.singleWidth, 0, self.singleWidth, self.singleHeight)];
            singleLabel.text=self.contents[idx];
            singleLabel.font=[UIFont systemFontOfSize:15];
            singleLabel.textColor=NormalTextColor;
            singleLabel.backgroundColor=NormalBackColor;
            [_contentLabels addObject:singleLabel];
        }];
    }
    return _contentLabels;
}

-(CGFloat)singleWidth{
    return CGRectGetWidth(self.frame)/self.contents.count;
}

-(CGFloat)singleHeight{
    return CGRectGetHeight(self.frame);
}

-(UIColor *)normalTextColor{
    if (!_normalTextColor) {
        
    }
    return _normalTextColor;
}
-(UIColor *)normalBackColor{
    if (!_normalBackColor) {
        
    }
    return _normalBackColor;
}
-(UIColor *)highlightTextColor{
    if (!_highlightTextColor) {
        
    }
    return _highlightTextColor;
}
-(UIColor *)highlightBackColor{
    if (!_highlightBackColor) {
        
    }
    return _highlightBackColor;
}
-(void)setNormalTextColor:(UIColor*)normalTextColor normalBackColor:(UIColor*)normalBackColor highlightTextColor:(UIColor*)highlightTextColor highlightBackColor:(UIColor*)highlightBackColor{

}
@end
