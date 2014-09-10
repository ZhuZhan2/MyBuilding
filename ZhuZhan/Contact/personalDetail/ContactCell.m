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
        
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        back.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back];
        
        UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        imgaeView.image = [UIImage imageNamed:@"人脉－人的详情_28a"];
        [back addSubview:imgaeView];
        
        if (exist) {
            UILabel *commonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 150, 30)];
            commonLabel1.textAlignment = NSTextAlignmentLeft;
            commonLabel1.text = model.email;
            commonLabel1.font = [UIFont systemFontOfSize:14];
            commonLabel1.tag =2014091001;
            [self addSubview:commonLabel1];
            
            UIButton *emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            emailBtn.frame = CGRectMake(0, 50, 320, 50);
            [emailBtn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
            emailBtn.tag = 2014091001;
            [self addSubview:emailBtn];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 99, 280, 1)];
            line.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
            [self addSubview:line];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[UIImage imageNamed:@"人脉－人的详情_21a"]];
            [self addSubview:imageView];
            imageView.userInteractionEnabled =YES;
            
            UILabel *commonLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 150, 30)];
            commonLabel2.textAlignment = NSTextAlignmentLeft;
            commonLabel2.text = model.cellPhone;
            commonLabel2.font = [UIFont systemFontOfSize:14];
            commonLabel2.tag =2014091002;
            [self addSubview:commonLabel2];
            
            UIButton *cellPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cellPhoneBtn.frame = CGRectMake(0, 100, 320, 50);
            [cellPhoneBtn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
            cellPhoneBtn.tag = 2014091002;
            [self addSubview:cellPhoneBtn];
            
            
            
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(270, 116, 21, 18)];
            [imageView1 setImage:[UIImage imageNamed:@"人脉－人的详情_23a"]];
            [self addSubview:imageView1];
            imageView1.userInteractionEnabled =YES;
            
            UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, 280, 1)];
            line2.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
            [self addSubview:line2];

        }
        if (!exist) {
            UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, 150, 30)];
            commonLabel.textAlignment = NSTextAlignmentLeft;
            commonLabel.text = model.cellPhone;
            commonLabel.font = [UIFont systemFontOfSize:14];
            commonLabel.tag = 2014091002;
            [self addSubview:commonLabel];
            
            UIButton *cellPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cellPhoneBtn.frame = CGRectMake(0, 50, 320, 50);
            [cellPhoneBtn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
            cellPhoneBtn.tag = 2014091002;
            [self addSubview:cellPhoneBtn];
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[UIImage imageNamed:@"人脉－人的详情_23a"]];
            [self addSubview:imageView];
            imageView.userInteractionEnabled =YES;
            
            UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 280, 1)];
            line2.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
            [self addSubview:line2];
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
