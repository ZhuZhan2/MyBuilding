//
//  AddFriendCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "AddFriendCell.h"

@interface AddFriendCell()
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userBussniessLabel;
@property(nonatomic,strong)UIView* separatorLine;
@property(nonatomic)BOOL needRightBtn;
@end

@implementation AddFriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.needRightBtn=needRightBtn;
        
        self.userImageView=[[UIImageView alloc]init];
        self.userImageView.layer.cornerRadius=3;
        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(15, 12.5, 35, 35);
        [self addSubview:self.userImageView];
        self.userImageView.userInteractionEnabled=YES;
        
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 12.5, 200, 16)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        self.userNameLabel.textColor=RGBCOLOR(89, 89, 89);
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(65, 33, 200, 14)];
        self.userBussniessLabel.font=[UIFont systemFontOfSize:13];
        self.userBussniessLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.userBussniessLabel];
        
        if (self.needRightBtn) {
            self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(270, 19, 26, 26)];
            [self addSubview:self.rightBtn];
        }
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 59, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setUserName:(NSString*)userName time:(NSString*)time userImageUrl:(NSString*)userImageUrl isFinished:(BOOL)isFinished indexPathRow:(NSInteger)indexPathRow status:(NSString *)status{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:userImageUrl] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.userNameLabel.text=userName;
    self.userBussniessLabel.text=time;
    [self.rightBtn setBackgroundImage:[GetImagePath getImagePath:isFinished?@"公司认证员工_08a":@"公司认证员工_18a"] forState:UIControlStateNormal];
    self.rightBtn.tag=indexPathRow;
    self.userImageView.tag=indexPathRow;
}


-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName{
    BOOL isFocesed=[model.a_isFocused isEqualToString:@"1"];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_userIamge]] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.userNameLabel.text=model.a_userName;
    self.userBussniessLabel.text=needCompanyName?[NSString stringWithFormat:@"%@ %@",model.a_company,model.a_duties]:model.a_duties;
    if (self.needRightBtn) {
        [self.rightBtn setBackgroundImage:isFocesed?[GetImagePath getImagePath:@"公司认证员工_08a"]:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
    }
    self.rightBtn.tag=indexPathRow;
    self.userImageView.tag=indexPathRow;
}
@end