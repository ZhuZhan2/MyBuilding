//
//  Cell1.m
//  DynamicListDemo
//
//  Created by Jack on 14-8-20.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "Cell1.h"

@implementation Cell1

@synthesize userIcon,cellIcon,contentLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 48, 310, 2)];
        line.image = [UIImage imageNamed:@"我的任务_05"];
        [self addSubview:line];
        
//        UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(74, 0, 3, 50)];
//        verticalLine.image = [UIImage imageNamed:@"搜索_10"];
//        [self addSubview:verticalLine];
        
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(74, 0, 3, 50)];
        verticalLine.backgroundColor = [UIColor blackColor];
        verticalLine.alpha=0.2;
        [self addSubview:verticalLine];
        
        userIcon =[UIButton buttonWithType:UIButtonTypeCustom];
        userIcon.frame = CGRectMake(10, 5, 40, 40);
        [self addSubview:userIcon];
        
        cellIcon = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 30, 30)];
        [self addSubview:cellIcon];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
        contentLabel.font = [UIFont systemFontOfSize:16];
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
