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
    
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(62.5, 11.5, 27, 27)];
    [stageImage setImage:[UIImage imageNamed:@"人脉_57a"]];
    [self.contentView addSubview:stageImage];
}
@end
