//
//  PersonalProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import "PersonalProjectTableViewCell.h"

@implementation PersonalProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self addContent];
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

-(void)addContent{
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 2, 50)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage2];
    lineImage2.alpha = 0.08;
    
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(23, 12, 26, 26)];
    [self.contentView addSubview:stageImage];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 20)];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 20)];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentLabel];
}

-(void)setModel:(PersonalCenterModel *)model{
    contentLabel.text = @"项目有新评论";
    titleLabel.text = model.a_entityName;
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
}
@end
