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
@property(nonatomic,strong)UILabel* remindNumberLabel;
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,strong)UIView* separatorLine;
@end

@implementation ChatListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier needRightBtn:(BOOL)needRightBtn{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImageView=[[UIImageView alloc]init];
        self.userImageView.layer.cornerRadius=17.5;
//        self.userImageView.layer.masksToBounds=YES;
        self.userImageView.frame=CGRectMake(12, 7.5, 35, 35);
        [self addSubview:self.userImageView];
        self.userImageView.userInteractionEnabled=YES;
        
        
        self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(62, 8, 160, 16)];
        self.userNameLabel.font=[UIFont boldSystemFontOfSize:15];
        self.userNameLabel.textColor=RGBCOLOR(89, 89, 89);
        [self addSubview:self.userNameLabel];
        
        self.userBussniessLabel=[[UILabel alloc]initWithFrame:CGRectMake(62, 28, 250, 14)];
        self.userBussniessLabel.font=[UIFont systemFontOfSize:13];
        self.userBussniessLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.userBussniessLabel];
        
        self.rightLabel.textAlignment=NSTextAlignmentRight;
        self.rightLabel.font=[UIFont systemFontOfSize:13];
        self.rightLabel.textColor=RGBCOLOR(149, 149, 149);
        [self addSubview:self.rightLabel];
        
        self.remindNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        self.remindNumberLabel.backgroundColor=[UIColor redColor];
        self.remindNumberLabel.layer.cornerRadius=6;
        self.remindNumberLabel.clipsToBounds=YES;
        self.remindNumberLabel.textAlignment=NSTextAlignmentCenter;
        self.remindNumberLabel.textColor=[UIColor whiteColor];
        self.remindNumberLabel.center=CGPointMake(CGRectGetWidth(self.userImageView.frame), 0);
        self.remindNumberLabel.font=[UIFont systemFontOfSize:9];
        [self.userImageView addSubview:self.remindNumberLabel];
        
        self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(175, 8, 130, 16)];
        self.timeLabel.textAlignment=NSTextAlignmentRight;
        self.timeLabel.textColor=RGBCOLOR(149, 149, 149);
        self.timeLabel.font=[UIFont systemFontOfSize:13];

        [self addSubview:self.timeLabel];
        
        self.separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
        self.separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
        [self addSubview:self.separatorLine];
    }
    return self;
}

-(void)setModel:(ChatListModel *)model{
    if([model.a_type isEqualToString:@"01"]){
        self.userNameLabel.text=model.a_loginName;
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_loginImageUrl]] placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_会话头像"]];
    }else{
        self.userNameLabel.text=model.a_groupName;
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_loginImageUrl]] placeholderImage:[GetImagePath getImagePath:@"默认图_群组头像_会话头像"]];
    }
    self.userBussniessLabel.text=model.a_content;

    if (model.a_isShow) {
        self.remindNumberLabel.text=model.a_msgCount;
    }
    self.remindNumberLabel.hidden=!model.a_isShow;

    self.timeLabel.text=model.a_time;
    
    self.rightLabel.text=@"2015-02-08";
}
@end
