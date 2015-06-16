//
//  RequirementContactsInfoView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementContactsInfoView.h"
#import "PublishRequirementTitleView.h"
#import "RKShadowView.h"
#import "RKViewFactory.h"
@interface RequirementContactsInfoView()

@end

@implementation RequirementContactsInfoView
@synthesize realName = _realName;
@synthesize phoneNumber = _phoneNumber;

+ (RequirementContactsInfoView *)infoView{
    RequirementContactsInfoView* infoView = [[RequirementContactsInfoView alloc] init];
    [infoView setUp];
    return infoView;
}

- (void)setUp{
    UIView* view1 = [PublishRequirementTitleView titleViewWithImageName:@"需求_标题_联系信息" title:@"联系信息"];
    UIView* view2 = [self realNameView];
    UIView* view3 = [self phoneNumberView];
    [self addSubview:[RKShadowView seperatorLineInViews:@[view1,view2,view3]]];
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(view3.frame));
}

- (void)setRealName:(NSString *)realName{
    _realName = realName;
    self.realNameField.text = realName;
}

- (NSString *)realName{
    return self.realNameField.text;
}

- (void)setPhoneNumber:(NSString *)phoneNumber{
    _phoneNumber = phoneNumber;
    self.phoneNumberField.text = phoneNumber;
}

- (NSString *)phoneNumber{
    return self.phoneNumberField.text;
}

- (UIView*)realNameView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"真实姓名" assistContent:nil]];
    self.realNameField = [self fieldWithContent:self.realName placeholderStr:Heng contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:AllNoDataColor];
    [view addSubview:self.realNameField];
    return view;
}

- (UIView*)phoneNumberView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"联系电话" assistContent:nil]];
    self.phoneNumberField = [self fieldWithContent:self.phoneNumber placeholderStr:@"输入联系电话" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187)];
    [view addSubview:self.phoneNumberField];
    return view;
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
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(18, 40, kScreenWidth-36, 20)];
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
@end

