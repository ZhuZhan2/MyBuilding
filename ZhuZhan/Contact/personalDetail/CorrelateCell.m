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
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 12, 44, 44)];
        imageView.image = [GetImagePath getImagePath:@"人的详情88-01"];
        [self addSubview:imageView];
        
        ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(103, 15, 170, 16)];
        ProjectLabel.textAlignment = NSTextAlignmentLeft;
        ProjectLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:ProjectLabel];
        
        zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(103, 37, 120, 14)];
        zoneLabel.textAlignment = NSTextAlignmentLeft;
        zoneLabel.textColor = [UIColor grayColor];
        zoneLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:zoneLabel];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 37, 120, 14)];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:addressLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(13.5, 67, 294, 1)];
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
    if([model.a_projectstage isEqualToString:@"1"]){
        [imageView setImage:[GetImagePath getImagePath:@"人的详情88-01"]];
    }else if([model.a_projectstage isEqualToString:@"2"]){
        [imageView setImage:[GetImagePath getImagePath:@"人的详情88-02"]];
    }else if([model.a_projectstage isEqualToString:@"3"]){
        [imageView setImage:[GetImagePath getImagePath:@"人的详情88-03"]];
    }else if([model.a_projectstage isEqualToString:@"4"]){
        [imageView setImage:[GetImagePath getImagePath:@"人的详情88-04"]];
    }else{
        [imageView setImage:[GetImagePath getImagePath:@"人的详情88-01"]];
    }
    ProjectLabel.text = model.a_projectName;
    addressLabel.text = model.a_landAddress;
    if([model.a_city isEqualToString:@""]){
        zoneLabel.text = @"";
    }else{
        zoneLabel.text = [NSString stringWithFormat:@"%@ - ",model.a_city];
    }
}
@end
