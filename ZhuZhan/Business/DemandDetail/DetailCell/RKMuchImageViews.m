//
//  RKMuchImageViews.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "RKMuchImageViews.h"
#import "RKSingleImageView.h"
#import "RKPointKit.h"
@interface RKMuchImageViews()
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* noDataLabel;
@property(nonatomic)CGFloat contentWidth;
@property(nonatomic,copy)NSString* title;

@property(nonatomic,strong)NSMutableArray* singleImageViews;
@end
#define Font(size) [UIFont systemFontOfSize:size]
//#define kLineWidth 10
#define kLineHeight 10
#define OneLineAllowNumber 3
#define SingleImageViewWidth 80
#define SingleImageViewHeight 80
#define ContentFont Font(13)
@implementation RKMuchImageViews
+(CGSize)carculateTotalHeightWithModels:(NSArray *)models width:(CGFloat)width{
    CGFloat height=0;
    height+=[self carculateLabelWithText:@"报价附件" font:ContentFont width:width].height;
    height+=7;
    if (models.count){
        CGFloat verticalHeight=SingleImageViewHeight+kLineHeight;
        height+=(SingleImageViewHeight+(models.count-1)/3*verticalHeight);
    }else{
        CGSize size=[RKMuchImageViews carculateLabelWithText:@"-" font:ContentFont width:width];
        height+=size.height;
    }
    return CGSizeMake(width, height);
}

-(NSArray*)editCenters{
    NSMutableArray* points=[NSMutableArray array];
    NSMutableArray* subPoints=[NSMutableArray array];
    for (RKSingleImageView* singleImageView in self.singleImageViews) {
        [points addObject:[NSValue valueWithCGPoint: singleImageView.frame.origin]];
        [subPoints addObject:[NSValue valueWithCGPoint:[singleImageView editCenter]]];
    }
    NSArray* newPoints=[RKPointKit points:points addSubPoints:subPoints];
//    NSLog(@"newPoints=%@",newPoints);
    return newPoints;
}

+(RKMuchImageViews*)muchImageViewsWithWidth:(CGFloat)width title:(NSString*)title{
    RKMuchImageViews* muchImageViews=[[RKMuchImageViews alloc]initWithFrame:CGRectZero];
    muchImageViews.contentWidth=width;
    muchImageViews.title=title;
    [muchImageViews addSubview:muchImageViews.titleLabel];
    return muchImageViews;
}

-(void)setModels:(NSArray *)models{
    _models=models;
    [self setUp];
}

-(void)setUp{
    CGFloat height=0;
    CGRect frame;
    CGSize size;
    
    self.titleLabel.text=self.title;
    self.titleLabel.textColor=self.models.count?[UIColor blackColor]:AllNoDataColor;
    size=[RKMuchImageViews carculateLabel:self.titleLabel width:self.contentWidth];
    frame=CGRectMake(0, height, size.width, size.height);
    self.titleLabel.frame=frame;

    height+=CGRectGetHeight(self.titleLabel.frame);
    
    height+=7;
    if (self.models.count) {
        [self addMuchImageViewsWithY:height];
    }else{
        size=[RKMuchImageViews carculateLabel:self.noDataLabel width:self.contentWidth];
        frame=CGRectMake(0, height, size.width, size.height);
        self.noDataLabel.frame=frame;
        [self addSubview:self.noDataLabel];
    }
    UIView* lastView=self.subviews.lastObject;
    height=CGRectGetMaxY(lastView.frame);
    
    self.frame=CGRectMake(0, 0, self.contentWidth, height);
}

-(void)addMuchImageViewsWithY:(CGFloat)Y{
    CGFloat space=(self.contentWidth-OneLineAllowNumber*SingleImageViewWidth)/(OneLineAllowNumber-1);
    CGFloat horizontalWidth=SingleImageViewWidth+space;
    CGFloat verticalHeight=SingleImageViewHeight+kLineHeight;
    for (int i=0; i<self.models.count; i++) {
        CGRect frame=CGRectMake(i%3*horizontalWidth, Y+i/3*verticalHeight, SingleImageViewWidth, SingleImageViewHeight);
        RKSingleImageView* singleImageView=[RKSingleImageView singleImageViewWithImageSize:frame.size model:self.models[i]];
        singleImageView.frame=frame;
        [self addSubview:singleImageView];
        [self.singleImageViews addObject:singleImageView];
    }
}

-(NSMutableArray *)singleImageViews{
    if (!_singleImageViews) {
        _singleImageViews=[NSMutableArray array];
    }
    return _singleImageViews;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.text=@"-";
        _titleLabel.font=ContentFont;
    }
    return _titleLabel;
}

-(UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _noDataLabel.text=@"—";
        _noDataLabel.font=ContentFont;
        _noDataLabel.textColor=AllNoDataColor;
    }
    return _noDataLabel;
}

+(CGSize)carculateLabel:(UILabel*)label width:(CGFloat)width{
    return [self carculateLabelWithText:label.text font:label.font width:width];
}

+(CGSize)carculateLabelWithText:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end
