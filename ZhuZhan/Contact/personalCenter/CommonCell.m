//
//  CommonCell.m
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell

@synthesize userIcon,contentLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
                
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(43, 0, 3, 50)];
        line.image = [UIImage imageNamed:@"搜索_10"];
        [self addSubview:line];
        
        userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 30, 30)];
        [self addSubview:userIcon];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 30)];
        [self addSubview:contentLabel];
        
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
