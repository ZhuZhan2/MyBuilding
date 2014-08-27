//
//  CommentsCell.m
//  DynamicListDemo
//
//  Created by Jack on 14-8-20.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "CommentsCell.h"

@implementation CommentsCell

@synthesize userIcon,commentsView,userNameLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *verticalLine = [[UIImageView alloc] initWithFrame:CGRectMake(74, 0, 3, 50)];
        verticalLine.image = [UIImage imageNamed:@"搜索_10"];
        [self addSubview:verticalLine];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(74, 50, 310, 2)];
        line.image = [UIImage imageNamed:@"我的任务_05"];
        [self addSubview:line];
        
        userIcon =[UIButton buttonWithType:UIButtonTypeCustom];
        userIcon.frame = CGRectMake(84, 5, 40, 40);
        [self addSubview:userIcon];
        
        commentsView = [[UITextView alloc] initWithFrame:CGRectMake(130, 0, 320, 60)];
        commentsView.editable =NO;
        [self addSubview:commentsView];
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [commentsView addSubview:userNameLabel];
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
