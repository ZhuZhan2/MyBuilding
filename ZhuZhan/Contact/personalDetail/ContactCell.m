//
//  ContactCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "ContactCell.h"

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

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

-(void)setModel:(MyCenterModel *)model{
    [commonLabel1 removeFromSuperview];
    commonLabel1 = nil;
    [emailBtn removeFromSuperview];
    emailBtn = nil;
    [line removeFromSuperview];
    line = nil;
    [imageView removeFromSuperview];
    imageView = nil;
    [commonLabel2 removeFromSuperview];
    commonLabel2 = nil;
    [cellPhoneBtn removeFromSuperview];
    cellPhoneBtn = nil;
    [imageView1 removeFromSuperview];
    imageView1 = nil;
    [commonLabel removeFromSuperview];
    commonLabel = nil;
    [back removeFromSuperview];
    back = nil;
    [topLineImage removeFromSuperview];
    topLineImage = nil;
    [topImgaeView removeFromSuperview];
    topImgaeView = nil;
    if(![model.a_cellPhone isEqualToString:@""]){
        back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        back.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
        [self addSubview:back];
        
        topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
        [topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
        [back addSubview:topLineImage];
        
        topImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
        topImgaeView.image = [GetImagePath getImagePath:@"人脉－人的详情_28a"];
        [back addSubview:topImgaeView];
        self.phone = model.a_cellPhone;
        if(![model.a_email isEqualToString:@""]){
            self.email = model.a_email;
            commonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 150, 30)];
            commonLabel1.textAlignment = NSTextAlignmentLeft;
            commonLabel1.text = model.a_email;
            commonLabel1.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel1];
            
            emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            emailBtn.frame = CGRectMake(270, 66, 21, 18);
            [emailBtn addTarget:self action:@selector(CallEmail) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emailBtn];
            
            line = [[UIImageView alloc] initWithFrame:CGRectMake(20, 99, 280, 1)];
            line.backgroundColor = [UIColor blackColor];
            [self addSubview:line];
            line.alpha = 0.2;
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[GetImagePath getImagePath:@"人脉－人的详情_21a"]];
            [self addSubview:imageView];
            imageView.userInteractionEnabled =YES;
            
            commonLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, 150, 30)];
            commonLabel2.textAlignment = NSTextAlignmentLeft;
            commonLabel2.text = model.a_cellPhone;
            commonLabel2.font = [UIFont systemFontOfSize:14];
            [self addSubview:commonLabel2];
            
            cellPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cellPhoneBtn.frame = CGRectMake(270, 116, 21, 18);
            [cellPhoneBtn addTarget:self action:@selector(CallPhone) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cellPhoneBtn];
            
            
            
            imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(270, 116, 21, 18)];
            [imageView1 setImage:[GetImagePath getImagePath:@"人脉－人的详情_23a"]];
            [self addSubview:imageView1];
        }else{
            self.phone = model.a_cellPhone;
            commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 150, 30)];
            commonLabel.textAlignment = NSTextAlignmentLeft;
            commonLabel.font = [UIFont systemFontOfSize:14];
            commonLabel.text = model.a_cellPhone;
            [self addSubview:commonLabel];
            
            cellPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cellPhoneBtn.frame = CGRectMake(270, 66, 21, 18);
            [cellPhoneBtn addTarget:self action:@selector(CallPhone) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cellPhoneBtn];
            
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[GetImagePath getImagePath:@"人脉－人的详情_23a"]];
            [self addSubview:imageView];
        }
    }else{
        if(![model.a_email isEqualToString:@""]){
            back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
            back.backgroundColor = [UIColor colorWithPatternImage:[GetImagePath getImagePath:@"grayColor"]];
            [self addSubview:back];
            
            topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
            [topLineImage setImage:[UIImage imageNamed:@"项目－高级搜索－2_15a"]];
            [back addSubview:topLineImage];
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(129, 8, 52, 34)];
            imageView.image = [GetImagePath getImagePath:@"人脉－人的详情_28a"];
            [back addSubview:imageView];
            self.email = model.a_email;
            commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 150, 30)];
            commonLabel.textAlignment = NSTextAlignmentLeft;
            commonLabel.font = [UIFont systemFontOfSize:14];
            commonLabel.text = model.a_email;
            [self addSubview:commonLabel];
            
            emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            emailBtn.frame = CGRectMake(270, 66, 21, 18);
            [emailBtn addTarget:self action:@selector(CallEmail) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emailBtn];
            
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 66, 21, 18)];
            [imageView setImage:[GetImagePath getImagePath:@"人脉－人的详情_21a"]];
            [self addSubview:imageView];
        }
    }
}

-(void)CallPhone{
    if([self.delegate respondsToSelector:@selector(gotoCallPhone:)]){
        [self.delegate gotoCallPhone:self.phone];
    }
}

-(void)CallEmail{
    if([self.delegate respondsToSelector:@selector(gotoCallEmail:)]){
        [self.delegate gotoCallEmail:self.email];
    }
}
@end
