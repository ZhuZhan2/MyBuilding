//
//  ContactCommentTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "ContactCommentTableViewCell.h"

@implementation ContactCommentTableViewCell

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
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, 0, 2, 60)];
    [topImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:topImage];
    topImage.alpha = 0.2;
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 15, 240, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.2;
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"人脉_74a"]];
    headImageView.frame = CGRectMake(85, 22, 27, 27);
    [self.contentView addSubview:headImageView];
    
    contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    contentLabel.font = tfont;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.lineBreakMode =NSLineBreakByCharWrapping ;
    [self.contentView addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeLabel];
}

-(void)setModel:(CommentModel *)model{
    contentLabel.frame = CGRectMake(120, 15, 100, 30);
    contentLabel.text = model.a_content;
}
@end
