//
//  BgCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "BgCell.h"

@implementation BgCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        back.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
        [self addSubview:back];
        
        UIImageView *topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        [topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
        [back addSubview:topLineImage];
        
        UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        imgaeView.image = [GetImagePath getImagePath:@"人脉－人的详情_29a"];
        [back addSubview:imgaeView];
        
//        AutoChangeTextView *textView = [[AutoChangeTextView alloc] initWithFrame:CGRectMake(20, 110, 280, height)];
//        textView.text = model.personalBackground;
//        [self addSubview:textView];
//        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 30)];
//        companyLabel.text = model.companyName;
//        companyLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:companyLabel];
//        
//        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 85, 280, 30)];
//        NSString *tempStr = [NSString stringWithFormat:@"%@————%@",model.beginTime,model.endTime];
//        timeLabel.text = tempStr;
//        timeLabel.textAlignment = NSTextAlignmentLeft;
//        timeLabel.font = [UIFont systemFontOfSize:14];
//        timeLabel.textColor =GrayColor;
//        [self addSubview:timeLabel];
        
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
