//
//  CompanyCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CompanyCell.h"

@implementation CompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 150, 30)];
        companyLabel.textAlignment = NSTextAlignmentLeft;
        companyLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [self addSubview:companyLabel];
        
        
        positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 150, 30)];
        positionLabel.textAlignment = NSTextAlignmentLeft;
        positionLabel.textColor = [UIColor grayColor];
        positionLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
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

-(void)setCompanyStr:(NSString *)companyStr{
    companyLabel.text = companyStr;
}

-(void)setPositionStr:(NSString *)positionStr{
    positionLabel.text = positionStr;
}
@end
