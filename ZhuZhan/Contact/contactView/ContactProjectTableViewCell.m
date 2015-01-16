//
//  ContactProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-2.
//
//

#import "ContactProjectTableViewCell.h"

@implementation ContactProjectTableViewCell
@synthesize indexpath = _indexpath;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGBCOLOR(242, 242, 242)];
        [self setContent];
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

-(void)setContent{
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.1;
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(67, 0, 2, 49)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage2];
    lineImage2.alpha = 0.2;
    
    headImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    [headImageView setFrame:CGRectMake(10, 6.5, 37, 37)];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:headImageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 6.5, 37, 37);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(53.5, 11.5, 27, 27)];
    [self.contentView addSubview:stageImage];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 20)];
    titleLabel.font = [UIFont fontWithName:nil size:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 25, 200, 20)];
    contentLabel.font = [UIFont fontWithName:nil size:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentLabel];
}

-(void)btnClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(HeadImageAction:)]){
        [self.delegate HeadImageAction:_indexpath];
    }
}

-(void)setModel:(ActivesModel *)model{
    if([model.a_projectStage isEqualToString:@"1"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉_57a"]];
    }else if([model.a_projectStage isEqualToString:@"2"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉_59a"]];
    }else if([model.a_projectStage isEqualToString:@"3"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉_61a"]];
    }else if([model.a_projectStage isEqualToString:@"4"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉_63a"]];
    }else{
        [stageImage setImage:[GetImagePath getImagePath:@"人脉_57a"]];
    }
    titleLabel.text = model.a_title;
    contentLabel.text = model.a_content;
    headImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_avatarUrl]];
}
@end
