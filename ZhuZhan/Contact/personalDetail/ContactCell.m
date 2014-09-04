//
//  ContactCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "ContactCell.h"

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model WithIndex:(int)index
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (index==2) {
            UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 150, 30)];
            commonLabel.textAlignment = NSTextAlignmentLeft;
            commonLabel.text = model.email;
            commonLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 49, 280, 1)];
            line.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
            [self addSubview:line];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 16, 21, 18)];
            [imageView setImage:[UIImage imageNamed:[model.contactImageIconArr objectAtIndex:0]]];
            [self addSubview:imageView];
            imageView.userInteractionEnabled =YES;

        }
        if (index==3) {
            UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 150, 30)];
            commonLabel.textAlignment = NSTextAlignmentLeft;
            commonLabel.text = model.cellPhone;
            commonLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel];
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 16, 21, 18)];
            [imageView setImage:[UIImage imageNamed:[model.contactImageIconArr objectAtIndex:1]]];
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
