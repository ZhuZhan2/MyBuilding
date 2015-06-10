//
//  RequirementInfoPorjectView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementInfoPorjectView.h"
#import "RKViewFactory.h"
#import "PublishRequirementTitleView.h"
#import "RKShadowView.h"
@interface RequirementInfoPorjectView ()<UITextViewDelegate>

@end

@implementation RequirementInfoPorjectView
@synthesize minMoney = _minMoney;
@synthesize maxMoney = _maxMoney;
@synthesize requirementDescribe = _requirementDescribe;

+ (RequirementInfoPorjectView *)projectViewWithRequirementDescribe:(NSString *)requirementDescribe{
    RequirementInfoPorjectView* projectView = [[RequirementInfoPorjectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 375)];
    projectView.requirementDescribe = requirementDescribe;
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
    [view addSubview:[self labelWithContent:@"需求所在地" assistContent:nil]];
    
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
    self.minMoneyField = field1;
    
    UITextField* field2 = [self fieldWithContent:nil placeholderStr:@"请输入最高金额" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187) width:120];
    frame = field2.frame;
    frame.origin.x = 184;
    field2.frame = frame;
    [view addSubview:field2];
    self.maxMoneyField = field2;
    
    UIView* sepe = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 1)];
    sepe.backgroundColor = RGBCOLOR(187, 187, 187);
    sepe.center = CGPointMake(kScreenWidth/2, field1.center.y);
    [view addSubview:sepe];
    self.sepe = sepe;
    
    return view;
}

- (UIView*)requirementView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    [view addSubview:[self labelWithContent:@"需求描述" assistContent:nil]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(18, 40, kScreenWidth-36, 20)];
    label.text = _requirementDescribe;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = RGBCOLOR(51, 51, 51);
    NSLog(@"req=%@",label.text);
    if ([label.text isEqualToString:@""]||!label.text) {
        label.text = Heng;
        label.textColor = AllNoDataColor;
    }else{
        [RKViewFactory autoLabel:label maxWidth:CGRectGetWidth(label.frame)];
    }
    
    
    self.requirementDescribeLabel = label;
    [view addSubview:label];
    
    CGRect frame = view.frame;
    frame.size.height = CGRectGetMaxY(label.frame)+10;
    view.frame = frame;
    
    return view;
}

- (void)textViewDidChange:(UITextView *)textView{
    UIView* view = [textView viewWithTag:1];
    view.hidden = textView.text.length;
}

- (UIView*)labelWithContent:(NSString*)content assistContent:(NSString*)assistContent{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 0, 20)];
    label1.font = [UIFont systemFontOfSize:16];
    label1.textColor = RGBCOLOR(132, 132, 132);
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
    textField.font = [UIFont systemFontOfSize:17];
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

- (NSString *)minMoney{
    return self.minMoneyField.text;
}

- (void)setMinMoney:(NSString *)minMoney{
    _minMoney = minMoney;
    self.minMoneyField.text = minMoney;
    
    CGFloat width = [RKViewFactory autoLabelWithFont:self.minMoneyField.font content:self.minMoneyField.text];
    CGRect frame = self.minMoneyField.frame;
    frame.size.width = width;
    self.minMoneyField.frame = frame;
    
    frame = self.sepe.frame;
    frame.origin.x = CGRectGetMaxX(self.minMoneyField.frame)+5;
    self.sepe.frame = frame;
    
    frame = self.maxMoneyField.frame;
    frame.origin.x = CGRectGetMaxX(self.sepe.frame)+5;
    self.maxMoneyField.frame = frame;
}

- (NSString *)maxMoney{
    return self.maxMoneyField.text;
}

- (void)setMaxMoney:(NSString *)maxMoney{
    _maxMoney = maxMoney;
    self.maxMoneyField.text = maxMoney;
}

- (NSString *)requirementDescribe{
    return self.requirementDescribeLabel.text;
}

- (void)setRequirementDescribe:(NSString *)requirementDescribe{
    _requirementDescribe = requirementDescribe;
}
@end
