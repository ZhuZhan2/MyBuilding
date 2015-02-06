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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(projectModel *)model fromView:(NSString *)fromView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(239, 237, 237);
        if([fromView isEqualToString:@"project"]){
            flag = 0;
        }else if([fromView isEqualToString:@"topics"]){
            flag = 1;
        }
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
    UIImageView *bgImgView = [[UIImageView alloc] init];
    if(flag == 0){
        [bgImgView setFrame:CGRectMake(14.5,0,292,270)];
    }else if(flag == 1){
        [bgImgView setFrame:CGRectMake(14.5,10,292,270)];
    }
    [bgImgView setImage:[GetImagePath getImagePath:@"全部项目_10"]];
    [self addSubview:bgImgView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,18,190,16)];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    [bgImgView addSubview:nameLabel];
    
    investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,62,85,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额(百万)";
    [bgImgView addSubview:investmentLabel];
    
    investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,83,90,14)];
    investmentcountLabel.font = [UIFont systemFontOfSize:14];
    [bgImgView addSubview:investmentcountLabel];
    
    areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(115,62,85,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积(㎡)";
    [bgImgView addSubview:areaLabel];
    
    areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(115,83,90,14)];
    areacountLabel.font = [UIFont systemFontOfSize:14];
    [bgImgView addSubview:areacountLabel];
    
    progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,16,52,52)];
    if([model.a_projectstage isEqualToString:@"1"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }else if([model.a_projectstage isEqualToString:@"2"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_23a"]];
    }else if([model.a_projectstage isEqualToString:@"3"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_25a"]];
    }else{
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_27a"]];
    }
    [bgImgView addSubview:progressImage];
    
    startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(215,72,65,12)];
    startdateLabel.font = [UIFont systemFontOfSize:12];
    startdateLabel.textColor = GrayColor;
    startdateLabel.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    startdateLabel.textAlignment = NSTextAlignmentCenter;
    [bgImgView addSubview:startdateLabel];
    
    enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(215,85,65,12)];
    enddateLabel.font = [UIFont systemFontOfSize:12];
    enddateLabel.textColor = [UIColor orangeColor];
    enddateLabel.textAlignment = NSTextAlignmentCenter;
    enddateLabel.text = [model.a_exceptFinishTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    [bgImgView addSubview:enddateLabel];
    
    bigImage = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"全部项目_37"]];
    bigImage.frame = CGRectMake(2.2,110,288,110);
    bigImage.delegate = self;
    [bgImgView addSubview:bigImage];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(13,232,18,23)];
    [arrowImage setImage:[GetImagePath getImagePath:@"全部项目_17"]];
    [bgImgView addSubview:arrowImage];
    
    UIImageView *dianImage = [[UIImageView alloc] initWithFrame:CGRectMake(275,232,21,24)];
    if(flag == 1){
        dianImage.frame = CGRectMake(275,240,21,24);
    }
    [dianImage setImage:[UIImage imageNamed:@"项目-首页_18a"]];
    [self addSubview:dianImage];
    
    UIButton *dianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dianBtn setFrame:CGRectMake(265,220,30,30)];
    //dianBtn.backgroundColor = [UIColor redColor];
    [dianBtn addTarget:self action:@selector(dianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dianBtn];
    
    
    zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(37,233,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    zoneLabel.textColor = BlueColor;
    [bgImgView addSubview:zoneLabel];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(92,233,160,20)];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text = model.a_landAddress;
    [bgImgView addSubview:addressLabel];
    
    NSLog(@"%f",dianBtn.frame.origin.y);
}

-(void)dianBtnClick{
    if([self.delegate respondsToSelector:@selector(addProjectCommentView:)]){
        [self.delegate addProjectCommentView:self.indexRow];
    }
}

-(void)setModel:(projectModel *)model{
    if([model.a_projectName isEqualToString:@""]){
        nameLabel.text = @"项目名称";
        nameLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        nameLabel.text = model.a_projectName;
        nameLabel.textColor = [UIColor blackColor];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_investment] isEqualToString:@""]){
        investmentcountLabel.text = @"－";
        investmentcountLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        if([[NSString stringWithFormat:@"%@",model.a_investment] isEqualToString:@"0"]){
            investmentcountLabel.text = @"－";
            investmentcountLabel.textColor = RGBCOLOR(166, 166, 166);
        }else{
            investmentcountLabel.text = [NSString stringWithFormat:@"%@",model.a_investment];
            investmentcountLabel.textColor = GrayColor;
        }
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_storeyArea] isEqualToString:@""]){
        areacountLabel.text = @"－";
        areacountLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        if([[NSString stringWithFormat:@"%@",model.a_storeyArea] isEqualToString:@"0"]){
            areacountLabel.text = @"－";
            areacountLabel.textColor = RGBCOLOR(166, 166, 166);
        }else{
            areacountLabel.text = [NSString stringWithFormat:@"%@",model.a_storeyArea];
            areacountLabel.textColor = GrayColor;
        }
    }
    
    NSLog(@"%@",model.a_projectstage);
    if([model.a_projectstage isEqualToString:@"1"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }else if([model.a_projectstage isEqualToString:@"2"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_23a"]];
    }else if([model.a_projectstage isEqualToString:@"3"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_25a"]];
    }else if([model.a_projectstage isEqualToString:@"4"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_27a"]];
    }else{
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }
    
    if([model.a_exceptStartTime isEqualToString:@""]){
        startdateLabel.text = @"开工日期";
        startdateLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        startdateLabel.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        startdateLabel.textColor = GrayColor;
    }
    
    if([model.a_exceptFinishTime isEqualToString:@""]){
        enddateLabel.text = @"竣工日期";
        enddateLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        enddateLabel.text = [model.a_exceptFinishTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        enddateLabel.textColor = [UIColor orangeColor];
    }
    
    if([model.a_city isEqualToString:@""]){
        zoneLabel.text = @"区域 -";
        zoneLabel.textColor = RGBCOLOR(166, 166, 166);
        //zoneLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        zoneLabel.text = [NSString stringWithFormat:@"%@ - ",model.a_city];
        zoneLabel.textColor = BlueColor;
        //zoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if([model.a_landAddress isEqualToString:@""]){
        addressLabel.text = @"地址";
        addressLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        addressLabel.text = model.a_landAddress;
        addressLabel.textColor = [UIColor blackColor];
    }
    
    imageHight = [model.a_imageHeight floatValue];
    imageWidth = [model.a_imageWidth floatValue];
    bigImage.imageURL = [NSURL URLWithString:model.a_imageLocation];
}

- (void)imageViewLoadedImage:(EGOImageView*)imageView{
    //图片裁剪
    UIImage *srcimg = imageView.image;
    CGRect rect =  CGRectMake((imageWidth-288)/2, (imageHight-110)/2, 288, 110);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
    CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], rect);
    bigImage.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
}
@end
