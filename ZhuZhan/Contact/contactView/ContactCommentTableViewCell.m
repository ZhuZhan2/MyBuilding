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
    
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_74a"]];
    headImageView.frame = CGRectMake(5, 5, 27, 27);
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:headImageView];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 190, 30)];
    contentLabel.numberOfLines = 2;
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.lineBreakMode =NSLineBreakByTruncatingTail ;
    [self.contentView addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 25, 190, 30)];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLabel];
}

-(void)setModel:(ContactCommentModel *)model{
    NSString* tempStr = [NSString stringWithFormat:@"%@:%@",model.a_userName,model.a_commentContents];
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(242, 66, 146) range:NSMakeRange(0, model.a_userName.length)];
    contentLabel.attributedText = attStr;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fixString = [dateFormatter stringFromDate:model.a_time];
    timeLabel.text = fixString;
}
@end
