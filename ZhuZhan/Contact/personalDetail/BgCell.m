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
        
        AutoChangeTextView *textView = [[AutoChangeTextView alloc] initWithFrame:CGRectMake(20, 60, 280, height)];
        textView.text = model.personalBackground;
        [self addSubview:textView];
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 30)];
        companyLabel.text = model.companyName;
        companyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:companyLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 35, 280, 30)];
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
