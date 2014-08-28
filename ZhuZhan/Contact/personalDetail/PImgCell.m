//
//  PImgCell.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PImgCell.h"

@implementation PImgCell

@synthesize bgImgview,userIcon,userLabel,companyLabel,positionLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        bgImgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        [self addSubview:bgImgview];
        
        userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(125, 50, 70, 70)];
        [self addSubview:userIcon];
        
        userLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 120, 60, 40)];
        userLabel.textAlignment = NSTextAlignmentCenter;
        userLabel.textColor = [UIColor whiteColor];
        userLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:userLabel];
        
        companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 150, 40)];
        companyLabel.textAlignment = NSTextAlignmentCenter;
        companyLabel.textColor = [UIColor whiteColor];
        companyLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:companyLabel];
        
        
        positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 80, 40)];
        positionLabel.textAlignment = NSTextAlignmentCenter;
        positionLabel.textColor = [UIColor whiteColor];
        positionLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:positionLabel];

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
