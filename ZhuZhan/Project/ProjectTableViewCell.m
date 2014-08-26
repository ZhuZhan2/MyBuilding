//
//  ProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectTableViewCell.h"
#import "ProjectStage.h"
@implementation ProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(projectModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(239, 237, 237);
        [self addContent:model];
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


-(void)addContent:(projectModel *)model{
    stage = [ProjectStage JudgmentProjectStage:model];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15,0,291.5,260)];
    [bgImgView setImage:[UIImage imageNamed:@"全部项目_10.png"]];
    [self addSubview:bgImgView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,5,160,36)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = model.a_projectName;
    [self addSubview:nameLabel];
    
    investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,51,50,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额";
    [self addSubview:investmentLabel];
    
    investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,71,140,20)];
    investmentcountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentcountLabel.textColor = [UIColor blackColor];
    investmentcountLabel.text = model.a_investment;
    [self addSubview:investmentcountLabel];
    
    areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(135,51,60,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积";
    [self addSubview:areaLabel];
    
    areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(135,71,140,20)];
    areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areacountLabel.textColor = [UIColor blackColor];
    areacountLabel.text = model.a_area;
    [self addSubview:areacountLabel];
    
    progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(235,5,52,52)];
    if([stage isEqualToString:@"1"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_16.png"]];
    }else if([stage isEqualToString:@"2"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_15.png"]];
    }else if([stage isEqualToString:@"3"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_14.png"]];
    }else{
        [progressImage setImage:[UIImage imageNamed:@"全部项目_13.png"]];
    }
    [self addSubview:progressImage];
    
    startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230,57,65,20)];
    startdateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    startdateLabel.textColor = GrayColor;
    startdateLabel.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    [self addSubview:startdateLabel];
    
    enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230,71,65,20)];
    enddateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    enddateLabel.textColor = [UIColor orangeColor];
    enddateLabel.text = [model.a_exceptFinishTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    [self addSubview:enddateLabel];
    
    UIImageView *bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(17.5,100,286.5,109.5)];
    [bigImage setImage:[UIImage imageNamed:@"全部项目_37.png"]];
    [self addSubview:bigImage];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(35,225,20,20)];
    [arrowImage setImage:[UIImage imageNamed:@"全部项目_17.png"]];
    [self addSubview:arrowImage];
    
    UIImageView *dianImage = [[UIImageView alloc] initWithFrame:CGRectMake(285,225,3.5,18)];
    [dianImage setImage:[UIImage imageNamed:@"全部项目_19.png"]];
    dianImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *dianImagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    //[dianImagetapGestureRecognizer addTarget:self action:@selector(dianImageClick)];
    [dianImagetapGestureRecognizer setNumberOfTapsRequired:1];
    [dianImagetapGestureRecognizer setNumberOfTouchesRequired:1];
    [dianImage addGestureRecognizer:dianImagetapGestureRecognizer];
    [self addSubview:dianImage];
    
    UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(65,225,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    zoneLabel.textColor = BlueColor;
    zoneLabel.text = @"华南区 -";
    [self addSubview:zoneLabel];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,225,160,20)];
    addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text = model.a_landAddress;
    [self addSubview:addressLabel];
}
@end
