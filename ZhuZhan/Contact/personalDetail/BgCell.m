//
//  BgCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "BgCell.h"

@implementation BgCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithTextHeight:(float)height WithModel:(ContactModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_29a"];
        [self addSubview:imgaeView];
        AutoChangeTextView *textView = [[AutoChangeTextView alloc] initWithFrame:CGRectMake(20, 110, 280, height)];
        textView.text = model.personalBackground;
        [self addSubview:textView];
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 30)];
        companyLabel.text = model.companyName;
        companyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:companyLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 85, 280, 30)];
        NSString *tempStr = [NSString stringWithFormat:@"%@————%@",model.projectBeginTime,model.projectEndTime];
        timeLabel.text = tempStr;
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textColor =GrayColor;
        [self addSubview:timeLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

@end
