//
//  AlertTextFieldView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "AlertTextFieldView.h"

@interface AlertTextFieldView ()
@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UITextField* contentField;
@property(nonatomic,strong)UIButton* sureBtn;
@property(nonatomic,strong)UIButton* cancelBtn;

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* sureBtnTitle;
@property(nonatomic,copy)NSString* cancelBtnTitle;

@property(nonatomic,weak)BlackView* backView;

@property(nonatomic,weak)id<AlertTextFieldViewDelegate>delegate;
@end

#define kAlertViewWidth 270
#define kAlertViewHeight 150
#define nameFont [UIFont systemFontOfSize:16]
#define contentFont [UIFont systemFontOfSize:14]
#define btnFont [UIFont systemFontOfSize:16]
#define sureBtnColor RGBCOLOR(0, 122, 255)
#define cancelBtnColor GrayColor
#define seperatorColor RGBCOLOR(155, 155, 155)
@implementation AlertTextFieldView
+(UIView *)alertTextFieldViewWithName:(NSString *)name sureBtnTitle:(NSString *)sureBtnTitle cancelBtnTitle:(NSString *)cancelBtnTitle originY:(CGFloat)originY delegate:(id<AlertTextFieldViewDelegate>)delegate{
    BlackView* blackView=[self blackView];
    
    CGFloat x=(kScreenWidth-kAlertViewWidth)*.5;
    AlertTextFieldView* alertView=[[AlertTextFieldView alloc]initWithFrame:CGRectMake(x, originY, kAlertViewWidth, kAlertViewHeight) name:name sureBtnTitle:sureBtnTitle cancelBtnTitle:cancelBtnTitle];
    alertView.delegate=delegate;
    [blackView addSubview:alertView];
    
    alertView.backView=blackView;
    return blackView;
}

-(instancetype)initWithFrame:(CGRect)frame name:(NSString*)name sureBtnTitle:(NSString*)sureBtnTitle cancelBtnTitle:(NSString*)cancelBtnTitle{
    if (self=[super initWithFrame:frame]) {
        self.name=name;
        self.sureBtnTitle=sureBtnTitle;
        self.cancelBtnTitle=cancelBtnTitle;
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=7;
        [self setUp];
    }
    return self;
}
/**
 @property(nonatomic,strong)UILabel* titleLabel;
 @property(nonatomic,strong)UITextField* contentField;
 @property(nonatomic,strong)UIButton* sureBtn;
 @property(nonatomic,strong)UIButton* cancelBtn;
 */

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kAlertViewWidth, 20)];
        _nameLabel.center=CGPointMake(kAlertViewWidth*.5, 32);
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.text=self.name;
        _nameLabel.font=nameFont;
    }
    return _nameLabel;
}

-(UITextField *)contentField{
    if (!_contentField) {
        _contentField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, kAlertViewWidth-28, 30)];
        _contentField.center=CGPointMake(kAlertViewWidth*0.5, 73);
        _contentField.font=contentFont;
        _contentField.layer.cornerRadius=4;
        _contentField.layer.borderColor=[UIColor grayColor].CGColor;
        _contentField.layer.borderWidth=1;
        _contentField.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, _contentField.frame.size.height)];
        _contentField.leftViewMode=UITextFieldViewModeAlways;
        _contentField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [_contentField becomeFirstResponder];
    }
    return _contentField;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_sureBtn setTitle:self.sureBtnTitle forState:UIControlStateNormal];
        _sureBtn.titleLabel.font=btnFont;
        [_sureBtn setTitleColor:sureBtnColor forState:UIControlStateNormal];
        _sureBtn.frame=CGRectMake(0, 0, kAlertViewWidth*0.5, 44);
        _sureBtn.center=CGPointMake(kAlertViewWidth*0.25, kAlertViewHeight-22);
        [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font=btnFont;
        _cancelBtn.frame=CGRectMake(0, 0, kAlertViewWidth*0.5, 44);
        _cancelBtn.center=CGPointMake(kAlertViewWidth*(0.25+0.5), kAlertViewHeight-22);
        [_cancelBtn setTitleColor:cancelBtnColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(void)setUp{
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentField];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];
    [self setUpSeperatorLine];
}

-(void)setUpSeperatorLine{
    UIView* view0=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kAlertViewWidth, 1)];
    UIView* view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, CGRectGetHeight(self.sureBtn.frame))];
    view0.backgroundColor=seperatorColor;
    view1.backgroundColor=seperatorColor;
    
    view0.center=CGPointMake(kAlertViewWidth*0.5, kAlertViewHeight-CGRectGetHeight(self.sureBtn.frame));
    view1.center=CGPointMake(kAlertViewWidth*0.5, kAlertViewHeight-CGRectGetHeight(self.sureBtn.frame)*0.5);
    
    [self addSubview:view0];
    [self addSubview:view1];
}

-(void)sureBtnClicked{
    if ([self.delegate respondsToSelector:@selector(sureBtnClickedWithContent:)]) {
        [self.delegate sureBtnClickedWithContent:self.contentField.text];
    }
    [self finishAlert];
}

-(void)cancelBtnClicked{
    if ([self.delegate respondsToSelector:@selector(cancelBtnClicked)]) {
        [self.delegate cancelBtnClicked];
    }
    [self finishAlert];
}

-(void)finishAlert{
    [self.backView finish];
}
@end
