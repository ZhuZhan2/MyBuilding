//
//  CorrelateCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CorrelateCell.h"

@implementation CorrelateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
        imageView.image = [UIImage imageNamed:@"人脉_57a"];
        imageView.userInteractionEnabled =YES;
        [self addSubview:imageView];
        
        UILabel *ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
        ProjectLabel.textAlignment = NSTextAlignmentLeft;
        ProjectLabel.font = [UIFont systemFontOfSize:16];
        ProjectLabel.text= model.projectName;
        [self addSubview:ProjectLabel];
        
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 120, 30)];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.textColor = [UIColor grayColor];
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.text = model.projectDistrict;
       [self addSubview:addressLabel];
       
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 59, 280, 1)];
        line.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        [self addSubview:line];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
      
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
