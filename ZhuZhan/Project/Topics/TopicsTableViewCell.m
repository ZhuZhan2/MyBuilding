//
//  TopicsTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "TopicsTableViewCell.h"

@implementation TopicsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(TopicsModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //618,210  264,210
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
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(5.5, 5, 309, 105)];
    [bgView setImage:[UIImage imageNamed:@"全部项目_10"]];
    [self.contentView addSubview:bgView];
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"首页_16"]];
    headImageView.delegate = self;
    [headImageView setFrame:CGRectMake(0, 0, 132, 105)];
    headImageView.showActivityIndicator = YES;
    NSLog(@"%@",model.a_image);
    headImageView.imageURL = [NSURL URLWithString:model.a_image];
    [bgView addSubview:headImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(142, 8, 157, 30)];
    titleLabel.text = model.a_title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blueColor];
    [bgView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(142, 28, 157, 50)];
    contentLabel.numberOfLines = 2;
    contentLabel.text = model.a_content;
    contentLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:contentLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(142, 75, 157, 1)];
    [lineImage setBackgroundColor:[UIColor grayColor]];
    [bgView addSubview:lineImage];
    
    UIImageView *countImage = [[UIImageView alloc] initWithFrame:CGRectMake(142, 80, 20, 20)];
    [countImage setBackgroundColor:[UIColor greenColor]];
    [bgView addSubview:countImage];
    
    projectCount = [[UILabel alloc] initWithFrame:CGRectMake(167, 80, 100, 20)];
    projectCount.text = model.a_projectCount;
    projectCount.font = [UIFont systemFontOfSize:14];
    projectCount.textColor = [UIColor redColor];
    [bgView addSubview:projectCount];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 80, 100, 20)];
    dateLabel.text = model.a_publishTime;
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = [UIColor grayColor];
    [bgView addSubview:dateLabel];
}
@end
