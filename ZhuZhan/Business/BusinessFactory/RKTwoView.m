//
//  RKTwoView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "RKTwoView.h"

@interface RKTwoView ()
@property(nonatomic,strong)UILabel* leftLabel;
@property(nonatomic,copy)NSString* leftContent;

@property(nonatomic,strong)UILabel* rightLabel;
@property(nonatomic,copy)NSString* rightContent;
@property(nonatomic)BOOL needAuto;
@end

#define kTotalHeight 24
#define leftLabelColor BlueColor
#define rightLabelColor AllDeepGrayColor
#define ContentFont [UIFont systemFontOfSize:15]

@implementation RKTwoView
+(CGFloat)carculateTotalHeightWithContents:(NSArray*)array{
    CGFloat height=[self carculateTotalHeightWithContent:array[3] width:kScreenWidth*0.75 maxNumberOfLines:2];
    return height+72;
}

+(CGFloat)carculateTotalHeightWithContent:(NSString*)content width:(CGFloat)width maxNumberOfLines:(NSInteger)maxNumberOfLines{
    CGFloat height=[content boundingRectWithSize:CGSizeMake(width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ContentFont} context:nil].size.height;
    NSInteger number=height/ContentFont.lineHeight;
    return kTotalHeight+(maxNumberOfLines-1)*height/number;
}

+(RKTwoView *)twoViewWithViewMode:(RKTwoViewWidthMode)viewMode assistMode:(RKTwoViewAssistViewMode)assistMode leftContent:(NSString *)leftContent rightContent:(NSString *)rightContent needAuto:(BOOL)needAuto{
    RKTwoView* twoView=[[RKTwoView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/viewMode, kTotalHeight)];
    twoView.leftContent=leftContent;
    twoView.rightContent=rightContent;
    twoView.needAuto=needAuto;
    [twoView setUp];
    return twoView;
}

-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, kTotalHeight)];
        _leftLabel.text=self.leftContent;
        _leftLabel.font=ContentFont;
        //_leftLabel.backgroundColor=[UIColor grayColor];
        _leftLabel.textAlignment=NSTextAlignmentCenter;
        _leftLabel.textColor=leftLabelColor;
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (!_rightLabel) {
        CGFloat width=CGRectGetWidth(self.frame)-CGRectGetMaxX(self.leftLabel.frame);
        _rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, width, kTotalHeight)];
        _rightLabel.text=self.rightContent;
        _rightLabel.numberOfLines=0;
        _rightLabel.font=ContentFont;
        _rightLabel.textColor=rightLabelColor;
    }
    return _rightLabel;
}

-(void)setRightLabelHeight{
    CGRect frame=self.rightLabel.frame;
    CGFloat height=[RKTwoView carculateTotalHeightWithContent:self.rightContent width:frame.size.width maxNumberOfLines:2];
    frame.size.height=height;
    self.rightLabel.frame=frame;
}

-(void)setUp{
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    if (self.needAuto) {
        [self setRightLabelHeight];
        CGRect frame=self.frame;
        frame.size.height=CGRectGetHeight(self.rightLabel.frame);
        self.frame=frame;
    }
    NSLog(@"frame.height==%lf",self.frame.size.height);
}
@end
