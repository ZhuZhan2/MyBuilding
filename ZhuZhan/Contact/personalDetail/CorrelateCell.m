//
//  CorrelateCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CorrelateCell.h"
#import "ProjectStage.h"
@implementation CorrelateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 40, 40)];
        imageView.image = [GetImagePath getImagePath:@"人脉_57a"];
        imageView.userInteractionEnabled =YES;
        [self addSubview:imageView];
        
        ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 30)];
        ProjectLabel.textAlignment = NSTextAlignmentLeft;
        ProjectLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:ProjectLabel];
        
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 120, 30)];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:addressLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 49, 280, 1)];
        line.image = [GetImagePath getImagePath:@"人脉－引荐信_08a"];
        [self addSubview:line];
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

-(void)setModel:(projectModel *)model{
    stage = [ProjectStage JudgmentProjectStage:model];
    if([stage isEqualToString:@"1"]){
        [imageView setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }else if([stage isEqualToString:@"2"]){
        [imageView setImage:[GetImagePath getImagePath:@"+项目-首页_25a"]];
    }else if([stage isEqualToString:@"3"]){
        [imageView setImage:[GetImagePath getImagePath:@"+项目-首页_27a"]];
    }else{
        [imageView setImage:[GetImagePath getImagePath:@"+项目-首页_23a"]];
    }
    ProjectLabel.text = model.a_projectName;
    addressLabel.text = model.a_landAddress;
}
@end
