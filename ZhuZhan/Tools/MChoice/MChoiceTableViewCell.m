//
//  MChoiceTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MChoiceTableViewCell.h"

@implementation MChoiceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        m_checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 29, 29)];
        [m_checkImageView setImage:[UIImage imageNamed:@"Unselected.png"]];
        [self addSubview:m_checkImageView];
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

- (void) setChecked:(BOOL)checked
{
	if (checked)
	{
		m_checkImageView.image = [UIImage imageNamed:@"Selected.png"];
		self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
	}
	else
	{
		m_checkImageView.image = [UIImage imageNamed:@"Unselected.png"];
		self.backgroundView.backgroundColor = [UIColor whiteColor];
	}
	m_checked = checked;
}
@end
