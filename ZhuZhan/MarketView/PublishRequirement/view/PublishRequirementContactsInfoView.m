//
//  PublishRequirementContactsInfoView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "PublishRequirementContactsInfoView.h"
#import "PublishRequirementTitleView.h"
#import "RKShadowView.h"
#import "RKViewFactory.h"
@interface PublishRequirementContactsInfoView()
@property (nonatomic, strong)UITextField* publishNameField;
@property (nonatomic, strong)UITextField* realNameField;
@property (nonatomic, strong)UITextField* phoneNumberField;

@property (nonatomic, strong)UIButton* allUserBtn;
@property (nonatomic, strong)UIButton* onlyPlatformUserBtn;
@end

@implementation PublishRequirementContactsInfoView
@synthesize publishUserName = _publishUserName;
@synthesize realName = _realName;
@synthesize phoneNumber = _phoneNumber;

+ (PublishRequirementContactsInfoView *)infoView{
    PublishRequirementContactsInfoView* infoView = [[PublishRequirementContactsInfoView alloc] init];
    [infoView setUp];
    return infoView;
}

- (void)setUp{
    UIView* view1 = [PublishRequirementTitleView titleViewWithImageName:@"需求_标题_联系信息" title:@"联系信息"];
    UIView* view2 = [self publishUserView];
    UIView* view3 = [self realNameView];
    UIView* view4 = [self phoneNumberView];
    UIView* view5 = [self allUserSeeView];
    [self addSubview:[RKShadowView seperatorLineInViews:@[view1,view2,view3,view4,view5]]];
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(view5.frame));
    
    self.allUserSee = YES;
}

- (void)setPublishUserName:(NSString *)publishUserName{
    _publishUserName = publishUserName;
    self.publishNameField.text = publishUserName;
}

- (NSString *)publishUserName{
    return self.publishNameField.text;
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

- (UIView*)publishUserView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"发布人" assistContent:nil]];
    self.publishNameField = [self fieldWithContent:self.publishUserName placeholderStr:nil contentColor:RGBCOLOR(150, 150, 150) placeholderStrColor:RGBCOLOR(150, 150, 150)];
    self.publishNameField.userInteractionEnabled = NO;
    [view addSubview:self.publishNameField];
    return view;
}

- (UIView*)realNameView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"真实姓名" assistContent:nil]];
    self.realNameField = [self fieldWithContent:self.realName placeholderStr:@"输入姓名，提高联系可能性" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187)];
    [view addSubview:self.realNameField];
    return view;
}

- (UIView*)phoneNumberView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [view addSubview:[self labelWithContent:@"联系电话" assistContent:@"必填"]];
    self.phoneNumberField = [self fieldWithContent:self.phoneNumber placeholderStr:@"输入联系电话" contentColor:RGBCOLOR(51, 51, 51) placeholderStrColor:RGBCOLOR(187, 187, 187)];
    [view addSubview:self.phoneNumberField];
    return view;
}

- (UIView*)allUserSeeView{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [view addSubview:[self labelWithContent:@"开放需求内容" assistContent:nil]];

    [view addSubview:self.allUserBtn];
    [view addSubview:self.onlyPlatformUserBtn];
    
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 43, 200, 21)];
    label1.text = @"平台所有用户可见";
    label1.textColor = RGBCOLOR(51, 51, 51);
    label1.font = [UIFont systemFontOfSize:16];
    [view addSubview:label1];
    
    UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 68, 200, 21)];
    label2.text = @"仅平台客服可见";
    label2.textColor = RGBCOLOR(51, 51, 51);
    label2.font = [UIFont systemFontOfSize:16];
    [view addSubview:label2];
    return view;
}

- (void)setAllUserSee:(BOOL)allUserSee{
    _allUserSee = allUserSee;
    
    [self.allUserBtn setBackgroundImage:[GetImagePath getImagePath:allUserSee?@"需求_选择框_已选":@"需求_选择框_未选"] forState:UIControlStateNormal];
    [self.onlyPlatformUserBtn setBackgroundImage:[GetImagePath getImagePath:allUserSee?@"需求_选择框_未选":@"需求_选择框_已选"] forState:UIControlStateNormal];

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



- (UIButton *)allUserBtn{
    if (!_allUserBtn) {
        _allUserBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 45, 17, 17)];
        [_allUserBtn setBackgroundImage:[GetImagePath getImagePath:@"需求_选择框_未选"] forState:UIControlStateNormal];
        [_allUserBtn addTarget:self action:@selector(allUserBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allUserBtn;
}

- (UIButton *)onlyPlatformUserBtn{
    if (!_onlyPlatformUserBtn) {
        _onlyPlatformUserBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 70, 17, 17)];
        [_onlyPlatformUserBtn setBackgroundImage:[GetImagePath getImagePath:@"需求_选择框_未选"] forState:UIControlStateNormal];
        [_onlyPlatformUserBtn addTarget:self action:@selector(allUserBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _onlyPlatformUserBtn;
}

- (void)allUserBtnClicked:(UIButton*)btn{
    self.allUserSee = btn == self.allUserBtn;
}
@end
