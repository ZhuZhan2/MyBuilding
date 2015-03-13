//
//  ChatListViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "ChatListViewCell.h"

@interface ChatListViewCell()
@property(nonatomic,strong)UILabel* userNameLabel;
@property(nonatomic,strong)UILabel* userBussniessLabel;
@property(nonatomic,strong)UIView* separatorLine;
@end

@implementation ChatListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"35px未设置"]];
        self.userImageView.layer.cornerRadius=3;
        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(12, 7.5, 35, 35);
        [self addSubview:self.userImageView];
        self.userImageView.userInteractionEnabled=YES;
        
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(62, 8, 200, 16)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        self.userNameLabel.textColor=RGBCOLOR(89, 89, 89);
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(62, 28, 200, 14)];
        self.userBussniessLabel.font=[UIFont systemFontOfSize:13];
        self.userBussniessLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.userBussniessLabel];
        
        self.rightLabel.textAlignment=NSTextAlignmentRight;
        self.rightLabel.font=[UIFont systemFontOfSize:13];
        self.rightLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.rightLabel];
        
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(EmployeesModel *)model{
    self.userImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_userIamge]];
    
    self.userNameLabel.text=model.a_userName;
    self.userBussniessLabel.text=model.a_company;

    self.rightLabel.text=@"2015-02-08";
}
@end
