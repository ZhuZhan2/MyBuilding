//
//  RecommendProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import "RecommendProjectTableViewCell.h"
#import "ProjectApi.h"
#import "LoginSqlite.h"
@implementation RecommendProjectTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self addContent];
    }
    return self;
}

-(void)addContent{
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 53, 53)];
    stageImage.image = [GetImagePath getImagePath:@"+项目-首页_21a"];
    [self.contentView addSubview:stageImage];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 106, 320, 1)];
    lineImage.backgroundColor = [UIColor blackColor];
    lineImage.alpha = 0.2;
    [self.contentView addSubview:lineImage];
    
    startDate = [[UILabel alloc] initWithFrame:CGRectMake(13, 65, 58, 20)];
    startDate.text = @"2014/15/5";
    startDate.font = [UIFont systemFontOfSize:10];
    startDate.textColor = [UIColor blackColor];
    startDate.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:startDate];
    
    endDate = [[UILabel alloc] initWithFrame:CGRectMake(13, 80, 58, 20)];
    endDate.text = @"2014/15/21";
    endDate.font = [UIFont systemFontOfSize:10];
    endDate.textColor = [UIColor redColor];
    endDate.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:endDate];
    
    projectName = [[UILabel alloc] initWithFrame:CGRectMake(83, 15, 150, 30)];
    projectName.text = @"上海中技桩业项目名称";
    projectName.textColor = [UIColor blackColor];
    projectName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    [self.contentView addSubview:projectName];
    
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, 35, 60, 30)];
    areaLabel.textColor = RGBCOLOR(40, 134, 247);
    areaLabel.text = @"建筑面积";
    areaLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:areaLabel];
    
    area = [[UILabel alloc] initWithFrame:CGRectMake(145, 35, 120, 30)];
    area.text = @"16000M²";
    area.textColor = RGBCOLOR(106, 106, 106);
    area.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:area];
    
    UILabel *investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(83, 55, 50, 30)];
    investmentLabel.textColor = RGBCOLOR(40, 134, 247);
    investmentLabel.text = @"投资额";
    investmentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:investmentLabel];
    
    investment = [[UILabel alloc] initWithFrame:CGRectMake(130, 55, 140, 30)];
    investment.text = @"￥16000000百万";
    investment.textColor = RGBCOLOR(106, 106, 106);
    investment.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:investment];
    
    zone = [[UILabel alloc] initWithFrame:CGRectMake(83, 75, 70, 30)];
    zone.text = @"华东区 — ";
    zone.textColor = RGBCOLOR(40, 134, 247);
    zone.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:zone];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(140, 75, 140, 30)];
    address.text = @"上海市";
    address.textColor = RGBCOLOR(106, 106, 106);
    address.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:address];
    
    attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [attentionBtn setBackgroundImage:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
    attentionBtn.frame = CGRectMake(272, 40.5, 26, 26);
    [attentionBtn addTarget:self action:@selector(attentionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:attentionBtn];
}

-(void)setModel:(projectModel *)model{
    projectId = model.a_id;
    projectName.text = model.a_projectName;
    area.text = [NSString stringWithFormat:@"%@M²",model.a_area];
    investment.text = [NSString stringWithFormat:@"¥%@百万",model.a_investment];
    zone.text = model.a_district;
    address.text = model.a_landAddress;
    startDate.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    endDate.text = [model.a_exceptFinishTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
}

-(void)attentionBtnAction{
//    if([self.delegate respondsToSelector:@selector(attentionProject:)]){
//        [self.delegate attentionProject:projectId];
//    }
    if(isFocused == 0){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[LoginSqlite getdata:@"uerId"] forKey:@"UserId"];
        [dic setValue:projectId forKey:@"ProjectId"];
        [ProjectApi AddProjectFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                isFocused = 1;
                [attentionBtn setBackgroundImage:[GetImagePath getImagePath:@"公司认证员工_08a"] forState:UIControlStateNormal];
            }
        } dic:dic noNetWork:nil];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[LoginSqlite getdata:@"uerId"] forKey:@"UserId"];
        [dic setValue:projectId forKey:@"ProjectId"];
        [ProjectApi DeleteFocusProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                isFocused = 0;
                [attentionBtn setBackgroundImage:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
            }
        } dic:dic noNetWork:nil];
    }
}
@end
