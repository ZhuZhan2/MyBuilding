//
//  ContactTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-3.
//
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell
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
    
    headImageView = [[UIImageView alloc] init];
    [headImageView setFrame:CGRectMake(10, 6.5, 37, 37)];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 3;
    [self.contentView addSubview:headImageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 6.5, 37, 37);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(62, 18.5, 12, 13)];
    [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_05a"]];
    [self.contentView addSubview:stageImage];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 20)];
    titleLabel.font = [UIFont fontWithName:nil size:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 25, 150, 20)];
    nameLabel.font = [UIFont fontWithName:nil size:12];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:nameLabel];
    
    jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 25, 100, 20)];
    jobLabel.font = [UIFont fontWithName:nil size:12];
    jobLabel.textAlignment = NSTextAlignmentLeft;
    jobLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:jobLabel];
}

-(void)btnClick:(UIButton *)button{
    if([self.delegate respondsToSelector:@selector(HeadImageAction:)]){
        [self.delegate HeadImageAction:_indexpath];
    }
}

-(void)setModel:(ActivesModel *)model{
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_dynamicAvatarUrl]] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    titleLabel.text = [NSString stringWithFormat:@"%@%@",model.a_dynamicLoginName,model.a_title];
    if(model.a_type == 1){
        nameLabel.text = model.a_productName;
    }else{
        nameLabel.text = model.a_content;
    }
    if([model.a_sourceCode isEqualToString:@"00"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_05a"]];
    }else if([model.a_sourceCode isEqualToString:@"01"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_07a"]];
    }else if([model.a_sourceCode isEqualToString:@"03"]){
        [stageImage setImage:[GetImagePath getImagePath:@"人脉－个人中心_06a"]];
    }
}

@end
