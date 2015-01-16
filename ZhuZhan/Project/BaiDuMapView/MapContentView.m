//
//  MapContentView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MapContentView.h"
#import "ProjectStage.h"
@implementation MapContentView

- (id)initWithFrame:(CGRect)frame model:(projectModel *)model number:(NSString *)number;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addContent:model number:number];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)addContent:(projectModel *)model number:(NSString *)number{
    //NSLog(@"dic ===> %@",dic);
    //NSLog(@"%@",[ProjectStage JudgmentProjectStage:dic]);
    UIImageView *grayBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 190)];
    [grayBgView setImage:[GetImagePath getImagePath:@"地图搜索1_16"]];
    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15,25,291.5,151.5)];
    [bgImgView setImage:[GetImagePath getImagePath:@"地图搜索1_05"]];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,5,160,36)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = model.a_projectName;
    [bgImgView addSubview:nameLabel];
    
    UILabel *investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,51,85,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额(百万)";
    [bgImgView addSubview:investmentLabel];
    
    UILabel *investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,71,140,20)];
    investmentcountLabel.font = [UIFont systemFontOfSize:14];
    investmentcountLabel.textColor = [UIColor blackColor];
    investmentcountLabel.text = model.a_investment;
    [bgImgView addSubview:investmentcountLabel];
    
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,51,75,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积㎡";
    [bgImgView addSubview:areaLabel];
    
    UILabel *areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,71,140,20)];
    areacountLabel.font = [UIFont systemFontOfSize:14];
    areacountLabel.textColor = [UIColor blackColor];
    //areacountLabel.text = @"16,000M²";
    areacountLabel.text = [NSString stringWithFormat:@"%@",model.a_storeyArea];
    [bgImgView addSubview:areacountLabel];
    
    UIImageView *progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,5,52,52)];
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
    UIImageView *smailImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,17,24.5,18.5)];
    [smailImage setImage:[GetImagePath getImagePath:@"全部项目_21"]];
    [progressImage addSubview:smailImage];
    [bgImgView addSubview:progressImage];
    
    UILabel *startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210,57,65,20)];
    startdateLabel.font = [UIFont systemFontOfSize:12];
    startdateLabel.textColor = GrayColor;
    startdateLabel.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    [bgImgView addSubview:startdateLabel];
    
    UILabel *enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210,71,65,20)];
    enddateLabel.font = [UIFont systemFontOfSize:12];
    enddateLabel.textColor = [UIColor orangeColor];
    enddateLabel.text = [model.a_exceptFinishTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    [bgImgView addSubview:enddateLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,115,20,20)];
    [arrowImage setImage:[GetImagePath getImagePath:@"全部项目_17"]];
    [bgImgView addSubview:arrowImage];
    
    UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 250, 1)];
    [lingImage setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
    [bgImgView addSubview:lingImage];
    
    UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,115,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    zoneLabel.textColor = BlueColor;
    zoneLabel.text = [model.a_city isEqualToString:@""]?model.a_city:[NSString stringWithFormat:@"%@ - ",model.a_city];
    [bgImgView addSubview:zoneLabel];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,115,160,20)];
    addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text =model.a_landAddress;
    [bgImgView addSubview:addressLabel];
    
    [grayBgView addSubview:bgImgView];
    [self addSubview:grayBgView];
    
    UIImageView *numberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 28.5, 40.5)];
    [numberImageView setImage:[GetImagePath getImagePath:@"地图搜索1_09"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28.5, 30)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:nil size:14];
    label.text = number;
    label.textAlignment = NSTextAlignmentCenter;
    [numberImageView addSubview:label];
    [self addSubview:numberImageView];
}
@end
