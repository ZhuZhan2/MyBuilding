//
//  CommentsCell.h
//  DynamicListDemo
//
//  Created by Jack on 14-8-20.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsCell : UITableViewCell

@property (nonatomic,strong)UIButton *userIcon;
@property (nonatomic,strong) UITextView *commentsView;
@property (nonatomic,strong) UILabel *userNameLabel;
@end
