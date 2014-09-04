//
//  ContactProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-2.
//
//

#import "ContactProjectTableViewCell.h"

@implementation ContactProjectTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 49)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage2];
    lineImage2.alpha = 0.2;
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"人脉_06a"]];
    [headImageView setFrame:CGRectMake(15, 6.5, 37, 37)];
    [self.contentView addSubview:headImageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 6.5, 37, 37);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(62.5, 11.5, 27, 27)];
    [stageImage setImage:[UIImage imageNamed:@"人脉_57a"]];
    [self.contentView addSubview:stageImage];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 20)];
    titleLabel.text = @"项目名称显示在这里";
    titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 200, 20)];
    contentLabel.text = @"修改的字段在这里列出来";
    contentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentLabel];
}

-(void)btnClick{
    if([self.delegate respondsToSelector:@selector(HeadImageAction)]){
        [self.delegate HeadImageAction];
    }
}
@end
