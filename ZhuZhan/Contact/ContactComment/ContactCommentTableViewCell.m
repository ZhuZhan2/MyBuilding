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
    
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"人脉_74a"]];
    headImageView.frame = CGRectMake(5, 5, 27, 27);
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
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
    contentLabel.frame = CGRectMake(40, 5, 100, 30);
    contentLabel.text = model.a_content;
}
@end
