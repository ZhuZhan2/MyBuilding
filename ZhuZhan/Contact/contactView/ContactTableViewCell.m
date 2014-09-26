//
//  ContactTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGBCOLOR(242, 242, 242)];
        [self setContent];
    }
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

-(void)setContent{
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.1;
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(67, 0, 2, 49)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage2];
    lineImage2.alpha = 0.2;
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a"]];
    [headImageView setFrame:CGRectMake(10, 6.5, 37, 37)];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:headImageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 6.5, 37, 37);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(62, 18.5, 12, 13)];
    [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_05a"]];
    [self.contentView addSubview:stageImage];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 20)];
    titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 150, 20)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:nameLabel];
    
    jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 25, 100, 20)];
    jobLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    jobLabel.textAlignment = NSTextAlignmentLeft;
    jobLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:jobLabel];
}

-(void)btnClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(HeadImageAction:)]){
        [self.delegate HeadImageAction:button];
    }
}

-(void)setModel:(ActivesModel *)model{
    headImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_avatarUrl]];
    titleLabel.text = model.a_title;
    nameLabel.text = model.a_content;
    if([model.a_category isEqualToString:@"Personal"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_05a"]];
    }else if([model.a_category isEqualToString:@"Company"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_07a"]];
    }else if([model.a_category isEqualToString:@"Product"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_06a"]];
    }
}

@end
