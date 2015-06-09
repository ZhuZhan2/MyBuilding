//
//  MarketSearchProductCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/5.
//
//

#import "MarketSearchProductCell.h"
#import "RKViewFactory.h"
@implementation MarketSearchProductCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //618,210  264,210
        self.backgroundColor = RGBCOLOR(239, 237, 237);
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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(2, 5, 316, 111)];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 316, 111)];
    [bgImage setImage:[GetImagePath getImagePath:@"项目－项目专题_02a"]];
    [bgView addSubview:bgImage];
    
    [self.contentView addSubview:bgView];
    
    headImageView = [[UIImageView alloc] init];
    [headImageView setFrame:CGRectMake(3, 2.7, 132, 105)];
    headImageView.backgroundColor = [UIColor grayColor];
    [bgView addSubview:headImageView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(147, 8, 157, 30)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = BlueColor;
    [bgView addSubview:titleLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(147, 28, 157, 50)];
    contentLabel.numberOfLines = 2;
    contentLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:contentLabel];
    
    UIImageView *countImage = [[UIImageView alloc] initWithFrame:CGRectMake(147, 87, 11, 13)];
    [countImage setImage:[GetImagePath getImagePath:@"项目－项目专题_03a"]];
    [bgView addSubview:countImage];
    
    projectCount = [[UILabel alloc] initWithFrame:CGRectMake(170, 83, 100, 20)];
    projectCount.font = [UIFont systemFontOfSize:14];
    projectCount.textColor = [UIColor redColor];
    [bgView addSubview:projectCount];
    
}

-(void)setModel:(ProductModel *)model{
    [RKViewFactory imageViewWithImageView:headImageView imageUrl:model.a_marketImageUrl defaultImageName:@"product_ default_list"];
    titleLabel.text = model.a_name;
    contentLabel.text = model.a_content;
    projectCount.text = model.a_commentNumber;
}

@end
