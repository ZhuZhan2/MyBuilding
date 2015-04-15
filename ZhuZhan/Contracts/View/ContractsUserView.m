//
//  ContractsUserView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/15.
//
//

#import "ContractsUserView.h"
#import "RKShadowView.h"
@interface ContractsUserView ()
@property (nonatomic, strong)UILabel* userNameLabel;
@property (nonatomic, strong)UILabel* userCategoryLabel;
@property (nonatomic, strong)UILabel* companyNameLabel;
@property (nonatomic, strong)UILabel* remarkContentLabel;

@property (nonatomic, copy)NSString* userName;
@property (nonatomic, copy)NSString* userCategory;
@property (nonatomic, copy)NSString* companyName;
@property (nonatomic, copy)NSString* remarkContent;
@end
#define userNameLabelFont [UIFont systemFontOfSize:15]
#define userCategoryLabelFont userNameLabelFont
#define companyNameLabelFont userNameLabelFont
#define remarkContentLabelFont [UIFont systemFontOfSize:12]

#define userNameLabelColor RGBCOLOR(0, 0, 0)
#define userCategoryLabelColor BlueColor
#define companyNameLabelColor RGBCOLOR(0, 0, 0)
#define remarkContentLabelColor [UIColor redColor]

#define sideDistance 12
#define topDistance 10
@implementation ContractsUserView
+(ContractsUserView *)contractsUserViewWithUserName:(NSString *)userName userCategory:(NSString *)userCategory companyName:(NSString *)companyName remarkContent:(NSString *)remarkContent{
    ContractsUserView* contractUserView=[[ContractsUserView alloc]initWithFrame:CGRectZero];
    contractUserView.userName=userName;
    contractUserView.userCategory=userCategory;
    contractUserView.companyName=companyName;
    contractUserView.remarkContent=remarkContent;
    
    [contractUserView setUp];
    return contractUserView;
}

-(void)setUp{
    UIView* view1=[[UIView alloc]init];
    {
        UIView* line1=[RKShadowView seperatorLine];
        [view1 addSubview:line1];
        [view1 addSubview:self.userNameLabel];
        [self addSubview:view1];
    }
    view1.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(self.userNameLabel.frame)+topDistance);
    
    
    UIView* view2=[[UIView alloc]init];
    {
        UIView* line2=[RKShadowView seperatorLine];
        [view2 addSubview:line2];
        [view2 addSubview:self.userCategoryLabel];
        [self addSubview:view2];
    }
    view2.frame=CGRectMake(0, CGRectGetMaxY(view1.frame), kScreenWidth, CGRectGetMaxY(self.userCategoryLabel.frame)+topDistance);
    
    UIView* view3=[[UIView alloc]init];
    {
        UIView* line3=[RKShadowView seperatorLine];
        [view3 addSubview:line3];
        [view3 addSubview:self.companyNameLabel];
        
        [view3 addSubview:self.remarkContentLabel];
        CGRect frame=self.remarkContentLabel.frame;
        frame.origin.y=CGRectGetMaxY(self.companyNameLabel.frame)+3;
        self.remarkContentLabel.frame=frame;
        
        [self addSubview:view3];
    }
    view3.frame=CGRectMake(0, CGRectGetMaxY(view2.frame), kScreenWidth, CGRectGetMaxY(self.remarkContentLabel.frame)+topDistance);
    
    UIView* line=[RKShadowView seperatorLineShadowViewWithHeight:10];
    {
        [self addSubview:line];
        CGRect frame=line.frame;
        frame.origin.y=CGRectGetMaxY(view3.frame);
        line.frame=frame;
        [self addSubview:line];
    }
    
    self.frame=CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(line.frame));
}
/*
 @property (nonatomic, strong)UILabel* userNameLabel;
 @property (nonatomic, strong)UILabel* userCategoryLabel;
 @property (nonatomic, strong)UILabel* companyNameLabel;
 @property (nonatomic, strong)UILabel* remarkContentLabel;
 */
-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        UILabel* label=[[UILabel alloc]init];
        label.text=self.userName;
        label.font=userNameLabelFont;
        label.textColor=userNameLabelColor;
        CGPoint origin=CGPointMake(sideDistance, topDistance);
        CGFloat maxWidth=kScreenWidth-origin.x*2;
        [self accommodateLabel:label originPoint:origin maxWidth:maxWidth];
        _userNameLabel=label;
    }
    return _userNameLabel;
}

-(UILabel *)userCategoryLabel{
    if (!_userCategoryLabel) {
        UILabel* label=[[UILabel alloc]init];
        label.text=self.userCategory;
        label.font=userCategoryLabelFont;
        label.textColor=userCategoryLabelColor;
        CGPoint origin=CGPointMake(sideDistance, topDistance);
        CGFloat maxWidth=kScreenWidth-origin.x*2;
        [self accommodateLabel:label originPoint:origin maxWidth:maxWidth];
        _userCategoryLabel=label;
    }
    return _userCategoryLabel;
}

-(UILabel *)companyNameLabel{
    if (!_companyNameLabel) {
        UILabel* label=[[UILabel alloc]init];
        label.text=self.companyName;
        label.font=companyNameLabelFont;
        label.textColor=companyNameLabelColor;
        CGPoint origin=CGPointMake(sideDistance, topDistance);
        CGFloat maxWidth=kScreenWidth-origin.x*2;
        [self accommodateLabel:label originPoint:origin maxWidth:maxWidth];
        _companyNameLabel=label;
    }
    return _companyNameLabel;
}

-(UILabel *)remarkContentLabel{
    if (!_remarkContentLabel) {
        UILabel* label=[[UILabel alloc]init];
        label.text=self.remarkContent;
        label.font=remarkContentLabelFont;
        label.textColor=remarkContentLabelColor;
        CGPoint origin=CGPointMake(sideDistance, topDistance+20);
        CGFloat maxWidth=kScreenWidth-origin.x*2;
        [self accommodateLabel:label originPoint:origin maxWidth:maxWidth];
        _remarkContentLabel=label;
    }
    return _remarkContentLabel;
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
