//
//  TopicsDetailTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "TopicsDetailTableViewCell.h"

@implementation TopicsDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TopicsModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(239, 237, 237);
        [self addContent:model];
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

-(void)addContent:(TopicsModel *)model{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [bgImage setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:bgImage];
    [self.contentView addSubview:bgView];
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"首页_16"]];
    [headImageView setFrame:CGRectMake(0, 0, 320, 202)];
    headImageView.imageURL = [NSURL URLWithString:model.a_image];
    [bgView addSubview:headImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 212, 320, 30)];
    titleLabel.text = model.a_title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [bgView addSubview:titleLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 245, 260, 1)];
    [lineImage setBackgroundColor:RGBCOLOR(222, 222, 222)];
    [bgView addSubview:lineImage];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 253, 288, 80)];
    
    
    CGRect bounds=[model.a_content boundingRectWithSize:CGSizeMake(288, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    contentLabel.frame=CGRectMake(15, 253, 288, bounds.size.height);
    contentLabel.numberOfLines = 0;
    contentLabel.text = model.a_content;
    contentLabel.textColor=GrayColor;
    contentLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:contentLabel];
    
    
    UIImageView* shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0, 278+bounds.size.height-10-3.5, 320, 3.5)];
    shadow.image=[GetImagePath getImagePath:@"XiangMuXiangQing/Shadow-bottom"];
    [self addSubview:shadow];
    
    
    bgView.frame=CGRectMake(0, 0, 320, 278+bounds.size.height-10);
    bgImage.frame=bgView.frame;
}
@end
