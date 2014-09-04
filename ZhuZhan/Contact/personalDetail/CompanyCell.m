//
//  CompanyCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CompanyCell.h"

@implementation CompanyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 150, 30)];
        companyLabel.textAlignment = NSTextAlignmentLeft;
        companyLabel.text = model.companyName;
        companyLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:companyLabel];
        
        
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 80, 30)];
        positionLabel.textAlignment = NSTextAlignmentLeft;
        positionLabel.textColor = [UIColor grayColor];
        positionLabel.text = model.projectLeader;
        positionLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:positionLabel];
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
