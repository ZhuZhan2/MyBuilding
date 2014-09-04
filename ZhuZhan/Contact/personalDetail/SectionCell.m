//
//  SectionCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "SectionCell.h"

@implementation SectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithIndex:(int)index;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        switch (index) {
            case 1:
            {
                UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
                imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_28a"];
                [self addSubview:imgaeView];
            }
                break;
                
                case 4:
            {
                UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
                imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_29a"];
                [self addSubview:imgaeView];

            }
                break;
                
                case 6:
            {
                UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
                imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_30a"];
                [self addSubview:imgaeView];

            }
                break;
                
            default:
                break;
        }
    }
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
