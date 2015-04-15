//
//  ContractsMainClauseView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/15.
//
//

#import "ContractsMainClauseView.h"
#import "RKShadowView.h"
@interface ContractsMainClauseView()
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* contentLabel;

@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* content;
@end
#define titleFont [UIFont systemFontOfSize:15]
#define contentFont titleFont
#define titleLabelColor RGBCOLOR(0, 0, 0)
#define contentLabelColor RGBCOLOR(0, 0, 0)

#define sideDistance 12
#define topDistance 10
@implementation ContractsMainClauseView
+(ContractsMainClauseView *)mainClauseViewWithTitle:(NSString *)title content:(NSString *)content{
    ContractsMainClauseView* mainClauseView=[[ContractsMainClauseView alloc]init];
    mainClauseView.title=title;
    mainClauseView.content=content;
    [mainClauseView setUp];
    return mainClauseView;
}

-(void)setUp{
    UIView* view1=[[UIView alloc]init];
    {
        UIView* line1=[RKShadowView seperatorLine];
        [view1 addSubview:line1];
        [view1 addSubview:self.titleLabel];
        [self addSubview:view1];
    }
    view1.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(self.titleLabel.frame)+topDistance);
    
    
    UIView* view2=[[UIView alloc]init];
    {
        UIView* line2=[RKShadowView seperatorLine];
        [view2 addSubview:line2];
        [view2 addSubview:self.contentLabel];
        [self addSubview:view2];
    }
    view2.frame=CGRectMake(0, CGRectGetMaxY(view1.frame), kScreenWidth, CGRectGetMaxY(self.contentLabel.frame)+topDistance);
    
    UIView* line=[RKShadowView seperatorLineShadowViewWithHeight:10];
    {
        [self addSubview:line];
        CGRect frame=line.frame;
        frame.origin.y=CGRectGetMaxY(view2.frame);
        line.frame=frame;
        [self addSubview:line];
    }
    
    self.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(line.frame));
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel* label=[[UILabel alloc]init];
        label.text=self.title;
        label.font=titleFont;
        label.textColor=titleLabelColor;
        CGPoint origin=CGPointMake(sideDistance, topDistance);
        CGFloat maxWidth=kScreenWidth-origin.x*2;
        [self accommodateLabel:label originPoint:origin maxWidth:maxWidth];
        _titleLabel=label;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel* label=[[UILabel alloc]init];
        label.text=self.content;
        label.font=contentFont;
        label.textColor=contentLabelColor;
        CGPoint origin=CGPointMake(sideDistance, topDistance);
        CGFloat maxWidth=kScreenWidth-origin.x*2;
        [self accommodateLabel:label originPoint:origin maxWidth:maxWidth];
        _contentLabel=label;
    }
    return _contentLabel;
}

-(void)accommodateLabel:(UILabel*)label originPoint:(CGPoint)originPoint maxWidth:(CGFloat)maxWidth{
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    CGRect frame;
    frame.origin=originPoint;
    frame.size=size;
    label.frame=frame;
    label.numberOfLines=0;
}
@end
