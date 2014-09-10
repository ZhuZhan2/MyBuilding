//
//  ContactCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "ContactCell.h"

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model WithEmailExist:(BOOL)exist
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 52, 34)];
        imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_28a"];
        [self addSubview:imgaeView];
        
        if (exist) {
            UILabel *commonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 150, 30)];
            commonLabel1.textAlignment = NSTextAlignmentLeft;
            commonLabel1.text = model.email;
            commonLabel1.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel1];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 99, 280, 1)];
            line.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
            [self addSubview:line];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[UIImage imageNamed:@"人脉－人的详情_21a"]];
            [self addSubview:imageView];
            imageView.userInteractionEnabled =YES;
            
            UILabel *commonLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 160, 150, 30)];
            commonLabel2.textAlignment = NSTextAlignmentLeft;
            commonLabel2.text = model.cellPhone;
            commonLabel2.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel2];
            
            
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(270, 166, 21, 18)];
            [imageView1 setImage:[UIImage imageNamed:@"人脉－人的详情_23a"]];
            [self addSubview:imageView1];
            imageView1.userInteractionEnabled =YES;

        }
        if (!exist) {
            UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 150, 30)];
            commonLabel.textAlignment = NSTextAlignmentLeft;
            commonLabel.text = model.cellPhone;
            commonLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel];
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[UIImage imageNamed:@"人脉－人的详情_23a"]];
            [self addSubview:imageView];
            imageView.userInteractionEnabled =YES;
        }
        
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
