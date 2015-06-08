//
//  PublishRequirementProjectView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "PublishRequirementProjectView.h"
#import "RKViewFactory.h"
#import "PublishRequirementTitleView.h"
#import "RKShadowView.h"
@interface PublishRequirementProjectView ()
@property (nonatomic, strong)UITextField* areaField;
@property (nonatomic, strong)UITextField* minMoneyField;
@property (nonatomic, strong)UITextField* maxMoneyField;
@property (nonatomic, strong)UITextField* requirementDescribeField;
@end

@implementation PublishRequirementProjectView
+ (PublishRequirementProjectView *)projectView{
    PublishRequirementProjectView* projectView = [[PublishRequirementProjectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 375)];
    [projectView setUp];
    return projectView;
}

- (void)setUp{
    UIView* view1 = [PublishRequirementTitleView titleViewWithImageName:@"需求_标题_需求信息" title:@"需求信息"];
    UIView* view2 = [self areaView];
    UIView* view3 = [self moneyView];
    UIView* view4 = [self requirementView];
    [self addSubview:[RKShadowView seperatorLineInViews:@[view1,view2,view3,view4]]];
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(view4.frame));
}

- (UIView*)areaView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"发布人" assistContent:@"必填"]];
    [view addSubview:[self fieldWithContent:nil placeholderStr:@"请选择" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187)]];
    
    return view;
}

- (UIView*)moneyView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"项目金额要求（百万）" assistContent:nil]];
    
    UITextField* field1 = [self fieldWithContent:nil placeholderStr:@"请输入最低金额" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187) width:120];
    CGRect frame = field1.frame;
    frame.origin.x = 18;
    field1.frame = frame;
    [view addSubview:field1];
    
    UITextField* field2 = [self fieldWithContent:nil placeholderStr:@"请输入最高金额" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187) width:120];
    frame = field2.frame;
    frame.origin.x = 184;
    field2.frame = frame;
    [view addSubview:field2];
    
    UIView* sepe = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 1)];
    sepe.backgroundColor = [UIColor blackColor];
    sepe.center = CGPointMake(kScreenWidth/2, field1.center.y);
    [view addSubview:sepe];
    
    return view;
}

- (UIView*)requirementView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"需求描述" assistContent:nil]];
    [view addSubview:[self fieldWithContent:nil placeholderStr:@"请把让我们帮你的事情输入" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187)]];
    return view;
}

- (UIView*)labelWithContent:(NSString*)content assistContent:(NSString*)assistContent{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 0, 20)];
    label1.font = [UIFont systemFontOfSize:16];
    label1.textColor = BlueColor;
    label1.text = content;
    [RKViewFactory autoLabel:label1];
    [view addSubview:label1];
    
    UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+5, 15, 200, 20)];
    label2.font = [UIFont systemFontOfSize:16];
    label2.textColor = AllRedColor;
    label2.text = assistContent;
    [view addSubview:label2];
    
    return view;
}

- (UITextField*)fieldWithContent:(NSString*)content placeholderStr:(NSString*)placeholderStr contentColor:(UIColor*)contentColor placeholderStrColor:(UIColor*)placeholderStrColor{
    return [self fieldWithContent:content placeholderStr:placeholderStr contentColor:contentColor placeholderStrColor:placeholderStrColor width:kScreenWidth-36];
}

- (UITextField*)fieldWithContent:(NSString*)content placeholderStr:(NSString*)placeholderStr contentColor:(UIColor*)contentColor placeholderStrColor:(UIColor*)placeholderStrColor width:(CGFloat)width{
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 40, width, 20)];
    textField.font = [UIFont systemFontOfSize:17.5];
    textField.text = content;
    textField.placeholder = placeholderStr;
    
    if (contentColor) {
        textField.textColor = contentColor;
    }
    
    if (placeholderStrColor) {
        UILabel* placeholderLabel = [textField valueForKeyPath:@"_placeholderLabel"];
        placeholderLabel.textColor = placeholderStrColor;
    }
    
    return textField;
}
@end
