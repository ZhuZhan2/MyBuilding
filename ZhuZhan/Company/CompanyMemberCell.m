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
        self.userImageView.frame=CGRectMake(3.5, 3.5, 36, 36);
        [self addSubview:self.userImageView];
        
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 20)];
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 20)];
        [self addSubview:self.userBussniessLabel];
        
        self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(280, 17, 26, 26)];
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
