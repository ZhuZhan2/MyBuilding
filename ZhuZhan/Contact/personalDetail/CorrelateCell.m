//
//  CorrelateCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "CorrelateCell.h"

@implementation CorrelateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(projectModel*)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
            back.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
            [self addSubview:back];
        
            UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
            imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_30a"];
            [back addSubview:imgaeView];
            
            for (int i=0; i<[model.projectArr count]; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 60+60*i, 40, 40)];
                imageView.image = [UIImage imageNamed:@"人脉_57a"];
                imageView.userInteractionEnabled =YES;
                [self addSubview:imageView];
                
                UILabel *ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60*i+60, 150, 30)];
                ProjectLabel.textAlignment = NSTextAlignmentLeft;
                ProjectLabel.font = [UIFont systemFontOfSize:16];
                ProjectLabel.text= model.a_projectName;//@"项目名称显示在这里";
                [self addSubview:ProjectLabel];
                
                
                UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20+60*i+60, 120, 30)];
                addressLabel.textAlignment = NSTextAlignmentLeft;
                addressLabel.textColor = [UIColor grayColor];
                addressLabel.font = [UIFont systemFontOfSize:14];
                addressLabel.text = model.a_district; //@"华南区－上海";
                [self addSubview:addressLabel];
                
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 49+60*i+60, 280, 1)];
                line.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
                [self addSubview:line];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 50+60*i, 320, 50);
                [button addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = 2014091005+i;
                [self addSubview:button];
                
            }
            
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)Clicked:(UIButton *)button
{
    [_delegate buttonClicked:button];
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
