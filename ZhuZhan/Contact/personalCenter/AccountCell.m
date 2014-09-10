//
//  AccountCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "AccountCell.h"

@implementation AccountCell

@synthesize userName,password,realName,sex,location,birthday,constellation,bloodType,email,cellPhone,company,position,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //*********账户信息**********************************************************************************
        UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        back1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back1];
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(134, 13, 52, 34)];
        imageView1.image = [UIImage imageNamed:@"人脉－账号设置_10a"];
        [self addSubview:imageView1];
        
        //用户名
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 80, 30)];
        userNameLabel.text = @"用  户  名";
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:userNameLabel];
        userName = [[UILabel alloc] initWithFrame:CGRectMake(110, 70, 120, 30)];
        userName.textAlignment = NSTextAlignmentLeft;
        userName.text =model.userName;
        [self addSubview:userName];
        UIImageView *horizontalLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 109, 280, 1)];
        horizontalLine1.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine1.alpha = 0.5;
        [self addSubview:horizontalLine1];
        
        //密码
        UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 80, 30)];
        passwordLabel.text = @"密        码";
        passwordLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:passwordLabel];
        password = [[UITextField alloc] initWithFrame:CGRectMake(110, 120, 120, 30)];
        password.textAlignment = NSTextAlignmentLeft;
        password.delegate =self;
        password.secureTextEntry =YES;
        password.text = model.password;
        [self addSubview:password];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(250, 120, 50, 30);
        [button setTitle:@"修改" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(begintoModifyPassword) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UIImageView *horizontalLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 159, 280, 1)];
        horizontalLine2.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine2.alpha = 0.5;
        [self addSubview:horizontalLine2];
        
          //真实姓名
        UILabel *realNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 80, 30)];
        realNameLabel.text = @"真实姓名";
        realNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:realNameLabel];
        realName = [[UITextField alloc] initWithFrame:CGRectMake(110, 170, 120, 30)];
        realName.textAlignment = NSTextAlignmentLeft;
        realName.delegate =self;
        realName.text = model.realName;
        [self addSubview:realName];
        UIImageView *horizontalLine3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 209, 280, 1)];
        horizontalLine3.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine3.alpha = 0.5;
        [self addSubview:horizontalLine3];
        
        //性别
        UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 80, 30)];
        sexLabel.text = @"性        别";
        sexLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:sexLabel];
        sex = [[UITextField alloc] initWithFrame:CGRectMake(110, 220, 120, 30)];
        sex.textAlignment = NSTextAlignmentLeft;
        sex.delegate =self;
        sex.text = model.sex;
        [self addSubview:sex];
        UIImageView *horizontalLine4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 259, 280, 1)];
        horizontalLine4.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine4.alpha = 0.5;
        [self addSubview:horizontalLine4];
        
        //所在地
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, 80, 30)];
        locationLabel.text = @"所   在  地";
        locationLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:locationLabel];
        location = [[UITextField alloc] initWithFrame:CGRectMake(110, 270, 120, 30)];
        location.textAlignment = NSTextAlignmentLeft;
        location.delegate =self;
        location.text = model.location;
        [self addSubview:location];
        UIImageView *horizontalLine5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 309, 280, 1)];
        horizontalLine5.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine5.alpha = 0.5;
        [self addSubview:horizontalLine5];
        
        //生日
        UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 80, 30)];
        birthdayLabel.text = @"生        日";
        birthdayLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:birthdayLabel];
        birthday= [[UITextField alloc] initWithFrame:CGRectMake(110, 320, 120, 30)];
        birthday.textAlignment = NSTextAlignmentLeft;
        birthday.delegate =self;
        birthday.placeholder = @"yyyy-mm-dd";
        birthday.text = model.birthday;
        [self addSubview:birthday];
        UIImageView *horizontalLine6 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 359, 280, 1)];
        horizontalLine6.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine6.alpha = 0.5;
        [self addSubview:horizontalLine6];
        
        //星座
        UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, 80, 30)];
        constellationLabel.text = @"星       座";
        constellationLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:constellationLabel];
        constellation= [[UILabel alloc] initWithFrame:CGRectMake(110, 370, 120, 30)];
        constellation.textAlignment = NSTextAlignmentLeft;
        constellation.text = model.constellation;
        [self addSubview:constellation];
        UIImageView *horizontalLine7 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 409, 280, 1)];
        horizontalLine7.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine7.alpha = 0.5;
        [self addSubview:horizontalLine7];
        
        //血型
        UILabel *bloodTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 420, 80, 30)];
        bloodTypeLabel.text = @"血       型";
        bloodTypeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:bloodTypeLabel];
        bloodType= [[UITextField alloc] initWithFrame:CGRectMake(110, 420, 120, 30)];
        bloodType.textAlignment = NSTextAlignmentLeft;
        bloodType.delegate =self;
        bloodType.text = model.bloodType;
        [self addSubview:bloodType];

        

        
        //*******联系方式**********************************************************************************
        
        UIView *back12 = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 60)];
        back12.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back12];
        UIImageView *imageView12 = [[UIImageView alloc] initWithFrame:CGRectMake(134, 473, 52, 34)];
        imageView12.image = [UIImage imageNamed:@"人脉－账号设置_14a"];
        [self addSubview:imageView12];
        
        //email
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 530, 80, 30)];
        emailLabel.text = @"邮箱地址";
        emailLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:emailLabel];
        email = [[UITextField alloc] initWithFrame:CGRectMake(110, 530, 200, 30)];
        email.textAlignment = NSTextAlignmentLeft;
        email.delegate =self;
        email.text = model.email;
        [self addSubview:email];
        UIImageView *horizontalLine9 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 569, 280, 1)];
        horizontalLine9.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine9.alpha = 0.5;
        [self addSubview:horizontalLine9];
        
        //cellPhone
        UILabel *cellPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 580, 80, 30)];
        cellPhoneLabel.text = @"电       话";
        cellPhoneLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:cellPhoneLabel];
        cellPhone = [[UILabel alloc] initWithFrame:CGRectMake(110, 580, 120, 30)];
        cellPhone.textAlignment = NSTextAlignmentLeft;
        cellPhone.text = model.cellPhone;
        [self addSubview:cellPhone];

        

        
        //*********公司信息*********************************************************************************
        
        UIView *back13 = [[UIView alloc] initWithFrame:CGRectMake(0, 620, 320, 60)];
        back13.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back13];
        UIImageView *imageView13 = [[UIImageView alloc] initWithFrame:CGRectMake(134, 633, 52, 34)];
        imageView13.image = [UIImage imageNamed:@"人脉－账号设置_18a"];
        [self addSubview:imageView13];
        
        //在职公司
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 690, 80, 30)];
        companyLabel.text = @"在职公司";
        companyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:companyLabel];
        company = [[UITextField alloc] initWithFrame:CGRectMake(110, 690, 120, 30)];
        company.textAlignment = NSTextAlignmentLeft;
        company.delegate =self;
        company.text = model.companyName;
        [self addSubview:company];
        UIImageView *horizontalLine10 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 729, 280, 1)];
        horizontalLine10.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine10.alpha = 0.5;
        [self addSubview:horizontalLine10];
        
        //职位
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 740, 80, 30)];
        positionLabel.text = @"职        位";
        positionLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:positionLabel];
        position = [[UITextField alloc] initWithFrame:CGRectMake(110, 740, 120, 30)];
        position.textAlignment = NSTextAlignmentLeft;
        position.delegate =self;
        position.text = model.position;
        [self addSubview:position];
        UIImageView *horizontalLine11 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 779, 280, 1)];
        horizontalLine11.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine11.alpha = 0.5;
        [self addSubview:horizontalLine11];

    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

-(void)begintoModifyPassword
{
    [delegate ModifyPassword:password.text];
}

#pragma mark textFieldDelelgate----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
