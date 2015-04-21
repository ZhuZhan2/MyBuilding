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
#import "IsFocusedApi.h"
@implementation RecommendProjectTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self addContent];
    }
    return self;
}

-(void)addContent{
    stageImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 53, 53)];
    stageImage.image = [GetImagePath getImagePath:@"+项目-首页_21a"];
    [self.contentView addSubview:stageImage];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 106, 320, 1)];
    lineImage.backgroundColor = [UIColor blackColor];
    lineImage.alpha = 0.2;
    [self.contentView addSubview:lineImage];
    
    startDate = [[UILabel alloc] initWithFrame:CGRectMake(13, 72, 60, 13)];
    startDate.text = @"2014/15/5";
    startDate.font = [UIFont systemFontOfSize:11];
    startDate.textColor = [UIColor blackColor];
    startDate.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:startDate];
    
    endDate = [[UILabel alloc] initWithFrame:CGRectMake(13, 83, 60, 13)];
    endDate.text = @"2014/15/21";
    endDate.font = [UIFont systemFontOfSize:11];
    endDate.textColor = [UIColor redColor];
    endDate.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:endDate];
    
    projectName = [[UILabel alloc] initWithFrame:CGRectMake(87, 17, 180, 17)];
    projectName.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:projectName];
    
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 42, 60, 13)];
    areaLabel.textColor = RGBCOLOR(40, 134, 247);
    areaLabel.text = @"建筑面积";
    areaLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:areaLabel];
    
    area = [[UILabel alloc] initWithFrame:CGRectMake(151, 42, 120, 13)];
    area.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:area];
    
    UILabel *investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, 61, 50, 13)];
    investmentLabel.textColor = RGBCOLOR(40, 134, 247);
    investmentLabel.text = @"投资额";
    investmentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:investmentLabel];
    
    investment = [[UILabel alloc] initWithFrame:CGRectMake(140, 61, 140, 13)];
    investment.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:investment];
    
    zone = [[UILabel alloc] initWithFrame:CGRectMake(87, 79, 60, 13)];
    zone.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:zone];
    
    address = [[UILabel alloc] initWithFrame:CGRectMake(140, 79, 140, 13)];
    address.textColor = RGBCOLOR(106, 106, 106);
    address.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:address];
    
    attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [attentionBtn setBackgroundImage:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
    attentionBtn.frame = CGRectMake(272, 41, 26, 26);
    [attentionBtn addTarget:self action:@selector(attentionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:attentionBtn];
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 52, 52)];
    btn.center=attentionBtn.center;
    [btn addTarget:self action:@selector(attentionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
}

-(void)setModel:(projectModel *)model{
    projectId = model.a_id;
    if([model.a_projectName isEqualToString:@""]){
        projectName.text = @"项目名称";
        projectName.textColor = GrayColor;
    }else{
        projectName.text = model.a_projectName;
        projectName.textColor = [UIColor blackColor];
    }
    
    if([model.a_storeyArea isEqualToString:@""]){
        area.text = @"-";
        area.textColor = GrayColor;
    }else{
        area.text = [NSString stringWithFormat:@"%@㎡",model.a_storeyArea];
        area.textColor = RGBCOLOR(106, 106, 106);
    }
    
    if([model.a_investment isEqualToString:@""]){
        investment.text = @"-";
        investment.textColor = GrayColor;
    }else{
        investment.text = [NSString stringWithFormat:@"¥%@百万",model.a_investment];
        investment.textColor = RGBCOLOR(106, 106, 106);
    }
    
    if([model.a_city isEqualToString:@""]){
        zone.text = @"区域 - ";
        zone.textColor = GrayColor;
    }else{
        zone.text = [NSString stringWithFormat:@"%@ - ",model.a_city];
        zone.textColor = RGBCOLOR(40, 134, 247);
    }
    
    if([model.a_landAddress isEqualToString:@""]){
        address.text = @"地址";
        address.textColor = GrayColor;
    }else{
        address.text = model.a_landAddress;
        address.textColor = RGBCOLOR(106, 106, 106);
    }
    
    if([model.a_exceptStartTime isEqualToString:@""]){
        startDate.text = @"开工日期";
        startDate.textColor = GrayColor;
    }else{
        startDate.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    
    if([model.a_exceptFinishTime isEqualToString:@""]){
        endDate.text = @"竣工日期";
        endDate.textColor = GrayColor;
    }else{
        endDate.text = [model.a_exceptFinishTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    }
    
    if([model.a_projectstage isEqualToString:@"1"]){
        [stageImage setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }else if([model.a_projectstage isEqualToString:@"2"]){
        [stageImage setImage:[GetImagePath getImagePath:@"+项目-首页_23a"]];
    }else if([model.a_projectstage isEqualToString:@"3"]){
        [stageImage setImage:[GetImagePath getImagePath:@"+项目-首页_25a"]];
    }else if([model.a_projectstage isEqualToString:@"4"]){
        [stageImage setImage:[GetImagePath getImagePath:@"+项目-首页_27a"]];
    }else{
        [stageImage setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }
}

-(void)attentionBtnAction{
//    if([self.delegate respondsToSelector:@selector(attentionProject:)]){
//        [self.delegate attentionProject:projectId];
//    }
    if(isFocused == 0){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:projectId forKey:@"targetId"];
        [dic setObject:@"03" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                isFocused = 1;
                [attentionBtn setBackgroundImage:[GetImagePath getImagePath:@"公司认证员工_08a"] forState:UIControlStateNormal];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:projectId forKey:@"targetId"];
        [dic setObject:@"03" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                isFocused = 0;
                [attentionBtn setBackgroundImage:[GetImagePath getImagePath:@"公司认证员工_18a"] forState:UIControlStateNormal];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }
}
@end
