//
//  CommonCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CommonCell.h"

@implementation CommonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model WithIndex:(int)index
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        switch (index) {
            case 0:
            {
                
                UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, 320, 1)];
                horizontalLine.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                horizontalLine.alpha = 0.5;
                [self addSubview:horizontalLine];
                
                UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 4, 60)];
                verticalLine.image = [UIImage imageNamed:@"人脉_65a"];
                [self addSubview:verticalLine];
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
                icon.image =[UIImage imageNamed:@"人脉_27a"];
                icon.center = CGPointMake(32, 20);
                [self addSubview:icon];
                UILabel *company = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 30)];
                company.text =model.companyName;
                company.textAlignment = NSTextAlignmentLeft;
                company.font = [UIFont systemFontOfSize:16];
                [self addSubview:company];
                
                UILabel *leader = [[UILabel alloc] initWithFrame:CGRectMake(62, 30, 100, 30)];
                leader.textAlignment = NSTextAlignmentLeft;
                leader.text =model.projectLeader;
                leader.font = [UIFont systemFontOfSize:14];
                leader.textColor = GrayColor;
                [self addSubview:leader];
                
                
            }
                break;
            case 1:
            {
                
                UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
                horizontalLine.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                horizontalLine.alpha = 0.5;
                [self addSubview:horizontalLine];
                UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 4, 50)];
                verticalLine.image = [UIImage imageNamed:@"人脉_65a"];
                [self addSubview:verticalLine];
                
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                icon.center =verticalLine.center;
                icon.image =[UIImage imageNamed:@"人脉_34a"];
                icon.center = CGPointMake(33, 25);
                [self addSubview:icon];
                
                UILabel *updateProject = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 40)];
                updateProject.text =[NSString stringWithFormat:@"更新了项目 项目名称 %@",model.projectName];
                updateProject.textAlignment = NSTextAlignmentLeft;
                updateProject.font = [UIFont systemFontOfSize:16];
                [self addSubview:updateProject];

            }
                break;
            case 2:
            {
                
                UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
                horizontalLine.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                horizontalLine.alpha = 0.5;
                [self addSubview:horizontalLine];
                UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 4, 50)];
                verticalLine.image = [UIImage imageNamed:@"人脉_65a"];
                [self addSubview:verticalLine];
                
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                icon.center =verticalLine.center;
                icon.image =[UIImage imageNamed:@"人脉_57a"];
                [self addSubview:icon];
                UILabel *updateFriend = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 40)];
                NSString *tempStr =@"与";
                for (int i=0; i<[model.addFriendArr count]; i++) {
                    
                    NSString *str =[NSString stringWithFormat:@" %@",[model.addFriendArr objectAtIndex:i]];
                    tempStr = [tempStr stringByAppendingString:str];
                    
                }
                tempStr =[tempStr stringByAppendingString:@"成为了好友"];
                
                updateFriend.text =tempStr;
                updateFriend.textAlignment = NSTextAlignmentLeft;
                updateFriend.font = [UIFont systemFontOfSize:16];
                [self addSubview:updateFriend];
            }
                break;
            case 3:
            {
                UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
                horizontalLine.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                horizontalLine.alpha = 0.5;
                [self addSubview:horizontalLine];
                
                UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 4, 50)];
                verticalLine.image = [UIImage imageNamed:@"人脉_65a"];
                [self addSubview:verticalLine];
                
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
                icon.image =[UIImage imageNamed:@"人脉－个人中心_07a"];
                icon.center =verticalLine.center;
                [self addSubview:icon];
                
                UILabel *updateIcon = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 40)];
                updateIcon.text =@"更新了头像";
                updateIcon.textAlignment = NSTextAlignmentLeft;
                updateIcon.font = [UIFont systemFontOfSize:16];
                [self addSubview:updateIcon];
                
            }
                break;
            case 4:
            {
                UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, 320, 1)];
                horizontalLine.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                horizontalLine.alpha = 0.5;
                [self addSubview:horizontalLine];
                UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 4, 80)];
                verticalLine.image = [UIImage imageNamed:@"人脉_65a"];
                [self addSubview:verticalLine];
                
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
                icon.image =[UIImage imageNamed:@"人脉－个人中心_05a"];
                icon.center =CGPointMake(32, 25);
                [self addSubview:icon];
                
                UILabel *updateMood = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 60)];
                updateMood.text =model.userMood;
                updateMood.lineBreakMode =NSLineBreakByWordWrapping;
                updateMood.textAlignment = NSTextAlignmentLeft;
                updateMood.font = [UIFont systemFontOfSize:16];
                [self addSubview:updateMood];
            }
                break;
            case 5:
            {
            
                UIImageView *horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 199, 320, 1)];
                horizontalLine.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                horizontalLine.alpha = 0.5;
                [self addSubview:horizontalLine];
                UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, 4, 200)];
                verticalLine.image = [UIImage imageNamed:@"人脉_65a"];
                [self addSubview:verticalLine];
                
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
                icon.image =[UIImage imageNamed:@"人脉－个人中心_06a"];
                icon.center =CGPointMake(32, 30);
                [self addSubview:icon];
                
                UIImageView *updateImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 20, 150, 150)];
                updateImage.image =model.updatePicture;
                [self addSubview:updateImage];
            }
                break;
                
            default:
                break;
        }
    }
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    return self;
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
