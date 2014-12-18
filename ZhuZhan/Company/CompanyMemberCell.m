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
@end
@implementation CompanyMemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"公司认证员工_03a"]];
        self.userImageView.layer.cornerRadius=3;
        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(20, 12, 36, 36);
        [self addSubview:self.userImageView];
        self.userImageView.userInteractionEnabled=YES;
        
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 10, 200, 20)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 30, 200, 20)];
        self.userBussniessLabel.font=[UIFont boldSystemFontOfSize:12];
        self.userBussniessLabel.textColor=GrayColor;
        [self addSubview:self.userBussniessLabel];
        
        self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(272, 17, 26, 26)];
        [self addSubview:self.rightBtn];
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(EmployeesModel*)model indexPathRow:(NSInteger)indexPathRow{
    BOOL isFocesed=[model.a_isFocused isEqualToString:@"1"];
    self.userImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_userIamge]];
    self.userNameLabel.text=model.a_userName;
    self.userBussniessLabel.text=model.a_duties;
    [self.rightBtn setBackgroundImage:isFocesed?[GetImagePath getImagePath:@"公司认证员工_08a"]:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
    self.rightBtn.tag=indexPathRow;
    self.userImageView.tag=indexPathRow;
}

@end
