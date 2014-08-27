//
//  CompanyPublishedCell.m
//  DynamicListDemo
//
//  Created by Jack on 14-8-20.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "CompanyPublishedCell.h"

@implementation CompanyPublishedCell

@synthesize bigImgView,publishView,userNameLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320,200)];
        [self addSubview:bigImgView];
        publishView = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, 320, 60)];
        publishView.editable =NO;
        [self addSubview:publishView];
        userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [publishView addSubview:userNameLabel];
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
