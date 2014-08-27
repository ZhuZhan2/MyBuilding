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
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 358)];
    [bgView setImage:[UIImage imageNamed:@"全部项目_10"]];
    [self.contentView addSubview:bgView];
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"首页_16"]];
    [headImageView setFrame:CGRectMake(0, 0, 320, 202)];
    [bgView addSubview:headImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 212, 320, 30)];
    titleLabel.text = @"超级公寓在深山老林里面";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:titleLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 245, 260, 1)];
    [lineImage setBackgroundColor:[UIColor grayColor]];
    [bgView addSubview:lineImage];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 253, 288, 80)];
    contentLabel.numberOfLines = 5;
    contentLabel.text = @"超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面超级公寓在深山老林里面";
    contentLabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:contentLabel];
}
@end
