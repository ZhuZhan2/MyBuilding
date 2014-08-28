//
//  AccountImgCell.m
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "AccountImgCell.h"
#import "RadioButton.h"
@implementation AccountImgCell

@synthesize bgImgview,userIcon,userLabel,companyLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bgImgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        [self addSubview:bgImgview];
        
        userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(125, 30, 70, 70)];
        [self addSubview:userIcon];
        
        userLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 100, 60, 40)];
        userLabel.textAlignment = NSTextAlignmentCenter;
        userLabel.textColor = [UIColor whiteColor];
        userLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:userLabel];
        
        companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 125, 150, 30)];
        companyLabel.textAlignment = NSTextAlignmentCenter;
        companyLabel.textColor = [UIColor whiteColor];
        companyLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:companyLabel];
        
        
//        positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 150, 80, 40)];
//        positionLabel.textAlignment = NSTextAlignmentCenter;
//        positionLabel.textColor = [UIColor whiteColor];
//        positionLabel.font = [UIFont systemFontOfSize:14];
//        [self addSubview:positionLabel];
        
        
        UIButton *setBgBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        setBgBtn.frame = CGRectMake(80, 150, 60, 30);
        [setBgBtn setTitle:@"设置封面" forState:UIControlStateNormal];
        [setBgBtn addTarget:self action:@selector(setbackground) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setBgBtn];
        
        UIButton *setIconBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        setIconBtn.frame = CGRectMake(180, 150, 60, 30);
        [setIconBtn setTitle:@"设置头像" forState:UIControlStateNormal];
        [setIconBtn addTarget:self action:@selector(setUserIcon) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setIconBtn];
        
        for (int i =0; i<6; i++) {
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1)+200, 280, 2)];
            line.image = [UIImage imageNamed:@"我的任务_05"];
            [self addSubview:line];
        }
        
        UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(20, 200+10, 60, 30)];
        userName.text = @"用户名";
        userName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:userName];
        
        UITextField *userNameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 200+10, 120, 30)];
        userNameField.delegate = self;
        userNameField.backgroundColor = [UIColor greenColor];
        [self addSubview:userNameField];
        
        
        UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(20, 250+10, 60, 30)];
        password.text = @"密码";
        password.textAlignment = NSTextAlignmentLeft;
        [self addSubview:password];
        
        UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(100, 250+10, 120, 30)];
        passwordField.delegate = self;
        passwordField.backgroundColor = [UIColor greenColor];
        [self addSubview:passwordField];
        
        
        
        UILabel *cellPhone = [[UILabel alloc] initWithFrame:CGRectMake(20, 300+10, 70, 30)];
        cellPhone.text = @"电话号码";
        cellPhone.textAlignment = NSTextAlignmentLeft;
        [self addSubview:cellPhone];
        
        UITextField *cellPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300+10, 120, 30)];
        cellPhoneField.delegate = self;
        cellPhoneField.backgroundColor = [UIColor greenColor];
        [self addSubview:cellPhoneField];
        
        UIButton * verifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        verifyBtn.frame = CGRectMake(260, 300+10, 40, 30);
        [verifyBtn setTitle:@"验证" forState:UIControlStateNormal];
        [verifyBtn addTarget:self action:@selector(verifyCellPhone) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:verifyBtn];
        
        
        UILabel *gender = [[UILabel alloc] initWithFrame:CGRectMake(20, 350+10, 60, 30)];
        gender.text = @"性别";
        gender.textAlignment = NSTextAlignmentLeft;
        [self addSubview:gender];
        
        RadioButton *radioButton1 = [[RadioButton alloc]initWithGroupId:@"firstGroup" index:0 WithTitle:@"男" WithFrame:CGRectMake(100, 350+10, 50, 30)];
        [self addSubview:radioButton1];
        radioButton1.delegate = self;
        
        RadioButton *radioButton2 = [[RadioButton alloc]initWithGroupId:@"firstGroup" index:1 WithTitle:@"女" WithFrame:CGRectMake(150, 350+10, 50, 30)];
        [self addSubview:radioButton2];
        radioButton2.delegate = self;
        
        UILabel *workingUnit = [[UILabel alloc] initWithFrame:CGRectMake(20, 400+10, 70, 30)];
        workingUnit.text = @"在职单位";
        workingUnit.textAlignment = NSTextAlignmentLeft;
        [self addSubview:workingUnit];
        
        UITextField *workingUnitField = [[UITextField alloc] initWithFrame:CGRectMake(100, 400+10, 120, 30)];
        workingUnitField.delegate = self;
        workingUnitField.backgroundColor = [UIColor greenColor];
        [self addSubview:workingUnitField];
        
        UILabel *position = [[UILabel alloc] initWithFrame:CGRectMake(20, 450+10, 60, 30)];
        position.text = @"职位";
        workingUnit.textAlignment = NSTextAlignmentLeft;
        [self addSubview:position];
        
        UITextField *positionField = [[UITextField alloc] initWithFrame:CGRectMake(100, 450+10, 120, 30)];
        positionField.delegate = self;
        positionField.backgroundColor = [UIColor greenColor];
        [self addSubview:positionField];
        
    }
    return self;
}



-(void)setbackground
{
NSLog(@"setbackground");

}

-(void)setUserIcon
{

 NSLog(@"setUserIcon");
}

-(void)verifyCellPhone
{
 NSLog(@"verifyCellPhone");
    
}

-(void)getStringFromRadioButtonSelected:(NSString *)title
{
    NSLog(@"RadioButtonTitle:%@",title);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
