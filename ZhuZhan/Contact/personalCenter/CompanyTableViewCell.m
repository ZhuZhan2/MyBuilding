//
//  CompanyTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/4.
//
//

#import "CompanyTableViewCell.h"

@implementation CompanyTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        back.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
        [self.contentView addSubview:back];
        
        UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        [topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
        [back addSubview:topLineImage];
        
        UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        imgaeView.image = [GetImagePath getImagePath:@"人脉－账号设置_10a"];
        [back addSubview:imgaeView];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 200)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        for(int i=0;i<3;i++){
            UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50+50*i, 280, 1)];
            lineImage.backgroundColor = [UIColor blackColor];
            lineImage.alpha = 0.2;
            [bgView addSubview:lineImage];
        }
        
        UIView *back2 = [[UIView alloc] initWithFrame:CGRectMake(0, 250, 320, 50)];
        back2.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
        [self.contentView addSubview:back2];
        
        UIImageView *topLineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        [topLineImage2 setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
        [back2 addSubview:topLineImage2];
        
        UIImageView *imgaeView2 = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        imgaeView2.image = [GetImagePath getImagePath:@"人脉－账号设置_14a"];
        [back2 addSubview:imgaeView2];
        
        UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 320, 200)];
        bgView2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView2];
        
        for(int i=0;i<2;i++){
            UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50+50*i, 280, 1)];
            lineImage.backgroundColor = [UIColor blackColor];
            lineImage.alpha = 0.2;
            [bgView2 addSubview:lineImage];
        }
        
        UILabel *companyName = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 80, 30)];
        companyName.text = @"公司全称";
        companyName.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:companyName];
        
        companyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 180, 30)];
        companyNameTextField.enabled = NO;
        companyNameTextField.font = [UIFont systemFontOfSize:14];
        companyNameTextField.delegate = self;
        companyNameTextField.tag = 0;
        [bgView addSubview:companyNameTextField];
        
        UILabel *passWord = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 80, 30)];
        passWord.text = @"密       码";
        passWord.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:passWord];
        
        passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 60, 160, 30)];
        passWordTextField.enabled = NO;
        passWordTextField.font = [UIFont systemFontOfSize:14];
        passWordTextField.delegate = self;
        passWordTextField.tag = 1;
        passWordTextField.secureTextEntry = YES;
        [bgView addSubview:passWordTextField];
        
        UIButton *updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        updataBtn.frame = CGRectMake(260, 60, 50, 30);
        [updataBtn setTitle:@"修改" forState:UIControlStateNormal];
        [updataBtn setTitleColor:BlueColor forState:UIControlStateNormal];
        updataBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [updataBtn addTarget:self action:@selector(updataPassWord) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:updataBtn];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(25, 110, 80, 30)];
        address.text = @"所  在  地";
        address.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:address];
        
        addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 110, 180, 30)];
        addressTextField.enabled = NO;
        addressTextField.font = [UIFont systemFontOfSize:14];
        addressTextField.delegate = self;
        addressTextField.tag = 2;
        [bgView addSubview:addressTextField];
        
        UILabel *industry = [[UILabel alloc] initWithFrame:CGRectMake(25, 160, 80, 30)];
        industry.text = @"行       业";
        industry.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:industry];
        
        industryTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 160, 180, 30)];
        industryTextField.enabled = NO;
        industryTextField.font = [UIFont systemFontOfSize:14];
        industryTextField.delegate = self;
        industryTextField.tag = 3;
        [bgView addSubview:industryTextField];
        
        UILabel *contact = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 80, 30)];
        contact.text = @"联  系  人";
        contact.font = [UIFont systemFontOfSize:14];
        [bgView2 addSubview:contact];
        
        contactTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 180, 30)];
        contactTextField.enabled = NO;
        contactTextField.font = [UIFont systemFontOfSize:14];
        contactTextField.delegate = self;
        contactTextField.tag = 4;
        [bgView2 addSubview:contactTextField];
        
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 80, 30)];
        phone.text = @"电      话";
        phone.font = [UIFont systemFontOfSize:14];
        [bgView2 addSubview:phone];
        
        phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 60, 180, 30)];
        phoneTextField.enabled = NO;
        phoneTextField.font = [UIFont systemFontOfSize:14];
        phoneTextField.delegate = self;
        phoneTextField.tag = 5;
        [bgView2 addSubview:phoneTextField];
        
        UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(25, 110, 80, 30)];
        email.text = @"邮      箱";
        email.font = [UIFont systemFontOfSize:14];
        [bgView2 addSubview:email];
        
        emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 110, 180, 30)];
        emailTextField.font = [UIFont systemFontOfSize:14];
        emailTextField.delegate = self;
        emailTextField.tag = 6;
        emailTextField.enabled = NO;
        [bgView2 addSubview:emailTextField];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updataPassWord{
    if([self.delegate respondsToSelector:@selector(gotoUpdataPassWord)]){
        [self.delegate gotoUpdataPassWord];
    }
}

-(void)setModel:(CompanyModel *)model{
    companyNameTextField.text = model.a_companyName;
    passWordTextField.text = @"**********";
    addressTextField.text = [NSString stringWithFormat:@"%@ %@",model.a_companyCity,model.a_companyDistrict];
    industryTextField.text = model.a_companyIndustry;
    contactTextField.text = model.a_companyContactName;
    phoneTextField.text = model.a_companyContactCellphone;
    emailTextField.text = model.a_companyContactEmail;
}
@end
