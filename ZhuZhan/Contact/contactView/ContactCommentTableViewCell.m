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
    headImageView = [[UIImageView alloc] init];
    headImageView.frame = CGRectMake(5, 5, 27, 27);
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:headImageView];
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setFrame:CGRectMake(5, 5, 27, 27)];
    [headBtn addTarget:self action:@selector(headActon) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:headBtn];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 190, 30)];
    contentLabel.numberOfLines = 2;
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.lineBreakMode =NSLineBreakByTruncatingTail ;
    [self.contentView addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 25, 190, 30)];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLabel];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 242, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.1;
}

-(void)setModel:(ContactCommentModel *)model{
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_avatarUrl]] placeholderImage:[GetImagePath getImagePath:@"人脉_74a2"]];
    NSString* tempStr = [NSString stringWithFormat:@"%@：%@",model.a_userName,model.a_commentContents];
    NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(242, 66, 146) range:NSMakeRange(0, model.a_userName.length+1)];
    contentLabel.attributedText = attStr;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fixString = [dateFormatter stringFromDate:model.a_time];
    timeLabel.text = fixString;
    
    contactId = model.a_createdBy;
    userType = model.a_userType;
}

-(void)headActon{
    if([self.delegate respondsToSelector:@selector(contactCommentHeadAction:userType:)]){
        [self.delegate contactCommentHeadAction:contactId userType:userType];
    }
}
@end
