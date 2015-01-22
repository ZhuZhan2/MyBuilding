//
//  CompanyMemberCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/22.
//
//

#import "CompanyMemberCell.h"
@interface CompanyMemberCell()
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userBussniessLabel;
@property(nonatomic,strong)UIView* separatorLine;
@property(nonatomic)BOOL needRightBtn;
@end
@implementation CompanyMemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.needRightBtn=needRightBtn;
        
        self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
        self.userImageView.layer.cornerRadius=3;
        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(20, 12, 37, 37);
        [self addSubview:self.userImageView];
        self.userImageView.userInteractionEnabled=YES;
        
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 10, 200, 20)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 30, 200, 20)];
        self.userBussniessLabel.font=[UIFont boldSystemFontOfSize:12];
        self.userBussniessLabel.textColor=GrayColor;
        [self addSubview:self.userBussniessLabel];
        
        if (self.needRightBtn) {
            self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(272, 17, 26, 26)];
            [self addSubview:self.rightBtn];
        }
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName{
    BOOL isFocesed=[model.a_isFocused isEqualToString:@"1"];
    self.userImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_userIamge]];

    self.userNameLabel.text=model.a_userName;
    self.userBussniessLabel.text=needCompanyName?[NSString stringWithFormat:@"%@ %@",model.a_company,model.a_duties]:model.a_duties;
    if (self.needRightBtn) {
        [self.rightBtn setBackgroundImage:isFocesed?[GetImagePath getImagePath:@"公司认证员工_08a"]:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
    }
    self.rightBtn.tag=indexPathRow;
    self.userImageView.tag=indexPathRow;
}
@end
