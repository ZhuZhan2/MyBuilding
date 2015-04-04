//
//  RecommendContactTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import "RecommendContactTableViewCell.h"
@interface RecommendContactTableViewCell()
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userCompanyNameLabel;
@property(nonatomic,strong)UILabel* userBussniessLabel;
@property(nonatomic,strong)UIView* separatorLine;
@property(nonatomic)BOOL needRightBtn;
@end
@implementation RecommendContactTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.needRightBtn=needRightBtn;
        
        self.userImageView=[[UIImageView alloc]init];
        self.userImageView.layer.cornerRadius=3;
        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(20, 17, 37, 37);
        [self addSubview:self.userImageView];
        self.userImageView.userInteractionEnabled=YES;
        

        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 12, 200, 20)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:16];
        self.userNameLabel.textColor=RGBCOLOR(89, 89, 89);
        [self addSubview:self.userNameLabel];
        
        self.userCompanyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 36, 200, 15)];
        self.userCompanyNameLabel.font=[UIFont systemFontOfSize:14];
        self.userCompanyNameLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.userCompanyNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 54, 200, 15)];
        self.userBussniessLabel.font=[UIFont systemFontOfSize:14];
        self.userBussniessLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.userBussniessLabel];
        
        if (self.needRightBtn) {
            self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 52, 52)];
            self.rightBtn.center=CGPointMake(285, 40.5);
            [self addSubview:self.rightBtn];
        }
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(EmployeesModel *)model indexPathRow:(NSInteger)indexPathRow needCompanyName:(BOOL)needCompanyName{
    BOOL isFocesed=[model.a_isFocused isEqualToString:@"1"];
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_userIamge]] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    
    self.userNameLabel.text=model.a_userName;
    self.userCompanyNameLabel.text=[model.a_company isEqualToString:@""]?@"公司":model.a_company;
    self.userBussniessLabel.text=[model.a_duties isEqualToString:@""]?@"职位":model.a_duties;
    
    if (self.needRightBtn) {
        [self.rightBtn setImage:[GetImagePath getImagePath:isFocesed?@"公司认证员工_08a":@"公司认证员工_18a"] forState:UIControlStateNormal];
        self.rightBtn.tag=indexPathRow;
    }
    self.userImageView.tag=indexPathRow;
}
@end
