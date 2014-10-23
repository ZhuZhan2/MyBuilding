//
//  CompanyMemberCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14/10/22.
//
//

#import "CompanyMemberCell.h"

@implementation CompanyMemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"公司认证员工_03a"]];
        self.userImageView.layer.cornerRadius=3;
        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(20, 12, 36, 36);
        [self addSubview:self.userImageView];
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 10, 200, 20)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 30, 200, 20)];
        self.userBussniessLabel.font=[UIFont boldSystemFontOfSize:12];
        self.userBussniessLabel.textColor=GrayColor;
        [self addSubview:self.userBussniessLabel];
        
        self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(272, 17, 26, 26)];
        [self addSubview:self.rightBtn];
    }
    return self;
}

-(void)setModelWithUserImageUrl:(NSString*)url userName:(NSString*)name userBussniess:(NSString*)bussniess btnImage:(UIImage*)image{
    self.userImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,url]];
    self.userNameLabel.text=name;
    self.userBussniessLabel.text=bussniess;
    [self.rightBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
