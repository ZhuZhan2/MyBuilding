//
//  ProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectTableViewCell.h"
#import "ProjectStage.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "IsFocusedApi.h"

#define FONT [UIFont systemFontOfSize:15]
#define OTHERFONT [UIFont systemFontOfSize:14]
#define LEFTMARGIN 16
#define LEFTPADDING 14
@implementation ProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = AllBackLightGratColor;
        [self.contentView addSubview:self.topImageView];
        [self.contentView addSubview:self.topContentImageView];
        [self.contentView addSubview:self.stageLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.contentImageView];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.projectName];
        [self.contentView addSubview:self.projectAddress];
        [self.contentView addSubview:self.projectInvestment];
        [self.contentView addSubview:self.projectArea];
        [self.contentView addSubview:self.projectInvestmentCount];
        [self.contentView addSubview:self.projectAreaCount];
        [self.contentView addSubview:self.projectStartDate];
        [self.contentView addSubview:self.projectEndDate];
        [self.contentView addSubview:self.projectStartDateCount];
        [self.contentView addSubview:self.projectEndDateCount];
        [self.contentView addSubview:self.mapImageVIew];
        [self.contentView addSubview:self.lastUpdatedTime];
        [self.contentView addSubview:self.lastUpdatedTimeCount];
        [self.contentView addSubview:self.cutLine2];
        [self.contentView addSubview:self.commentsNum];
        [self.contentView addSubview:self.focusBtn];
        [self.contentView addSubview:self.bottomImageView];
    }
    return self;
}

-(UIImageView *)topImageView{
    if(!_topImageView){
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFTMARGIN, 10, 288, 3)];
        _topImageView.image = [GetImagePath getImagePath:@"project_head"];
    }
    return _topImageView;
}

-(UIImageView *)topContentImageView{
    if(!_topContentImageView){
        _topContentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEFTMARGIN, 13, 288, 33)];
        _topContentImageView.image = [GetImagePath getImagePath:@"proiect_content"];
    }
    return _topContentImageView;
}

-(UILabel *)stageLabel{
    if(!_stageLabel){
        _stageLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMARGIN+LEFTPADDING, 10, 130, 36)];
        _stageLabel.textColor = BlueColor;
        _stageLabel.font = FONT;
    }
    return _stageLabel;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 116, 36)];
        _detailLabel.textColor = AllDeepGrayColor;
        _detailLabel.text = @"查看详情";
        _detailLabel.font = FONT;
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(281, 22, 7, 12)];
        _arrowImageView.image = [GetImagePath getImagePath:@"project_arrow"];
    }
    return _arrowImageView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(LEFTMARGIN, 46, 288, 1)];
        _cutLine.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine;
}

-(UIImageView *)contentImageView{
    if(!_contentImageView){
        _contentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _contentImageView.image = [GetImagePath getImagePath:@"proiect_content"];
    }
    return _contentImageView;
}

-(UILabel *)projectName{
    if(!_projectName){
        _projectName = [[UILabel alloc] initWithFrame:CGRectZero];
        _projectName.numberOfLines = 0;
        _projectName.font = [UIFont systemFontOfSize:19];
    }
    return _projectName;
}

-(UILabel *)projectAddress{
    if(!_projectAddress){
        _projectAddress = [[UILabel alloc] initWithFrame:CGRectZero];
        _projectAddress.numberOfLines = 0;
        _projectAddress.textColor = AllDeepGrayColor;
    }
    return _projectAddress;
}

-(UILabel *)projectInvestment{
    if(!_projectInvestment){
        _projectInvestment = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectInvestment.text = @"投资额(百万)";
        _projectInvestment.font = FONT;
        _projectInvestment.textColor = BlueColor;
    }
    return _projectInvestment;
}

-(UILabel *)projectArea{
    if(!_projectArea){
        _projectArea = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectArea.textColor = BlueColor;
        _projectArea.text = @"建筑面积(㎡)";
        _projectArea.font = FONT;
    }
    return _projectArea;
}

-(UILabel *)projectInvestmentCount{
    if(!_projectInvestmentCount){
        _projectInvestmentCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectInvestmentCount.font = FONT;
    }
    return _projectInvestmentCount;
}

-(UILabel *)projectAreaCount{
    if(!_projectAreaCount){
        _projectAreaCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectAreaCount.font = FONT;
    }
    return _projectAreaCount;
}

-(UILabel *)projectStartDate{
    if(!_projectStartDate){
        _projectStartDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectStartDate.font = FONT;
        _projectStartDate.textColor = BlueColor;
        _projectStartDate.text = @"预计开工时间";
    }
    return _projectStartDate;
}

-(UILabel *)projectEndDate{
    if(!_projectEndDate){
        _projectEndDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectEndDate.font = FONT;
        _projectEndDate.textColor = BlueColor;
        _projectEndDate.text = @"预计竣工时间";
    }
    return _projectEndDate;
}

-(UILabel *)projectStartDateCount{
    if(!_projectStartDateCount){
        _projectStartDateCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectStartDateCount.font = FONT;
    }
    return _projectStartDateCount;
}

-(UILabel *)projectEndDateCount{
    if(!_projectEndDateCount){
        _projectEndDateCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        _projectEndDateCount.font = FONT;
    }
    return _projectEndDateCount;
}

-(UIImageView *)mapImageVIew{
    if(!_mapImageVIew){
        _mapImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 284, 110)];
        _mapImageVIew.backgroundColor = [UIColor yellowColor];
    }
    return _mapImageVIew;
}

-(UILabel *)lastUpdatedTime{
    if(!_lastUpdatedTime){
        _lastUpdatedTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _lastUpdatedTime.font = OTHERFONT;
        _lastUpdatedTime.text = @"最后更新时间";
    }
    return _lastUpdatedTime;
}

-(UILabel *)lastUpdatedTimeCount{
    if(!_lastUpdatedTimeCount){
        _lastUpdatedTimeCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 20)];
        _lastUpdatedTimeCount.font = OTHERFONT;
    }
    return _lastUpdatedTimeCount;
}

-(UIImageView *)cutLine2{
    if(!_cutLine2){
        _cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 288, 1)];
        _cutLine2.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine2;
}

-(UILabel *)commentsNum{
    if(!_commentsNum){
        _commentsNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 20)];
        _commentsNum.font = OTHERFONT;
        _commentsNum.textColor = AllDeepGrayColor;
    }
    return _commentsNum;
}

-(UIButton *)focusBtn{
    if(!_focusBtn){
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _focusBtn.frame = CGRectMake(0, 0, 81, 28);
        [_focusBtn addTarget:self action:@selector(focusBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusBtn;
}

-(UIImageView *)bottomImageView{
    if(!_bottomImageView){
        _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 288, 5)];
        _bottomImageView.image = [GetImagePath getImagePath:@"project_bottom"];
    }
    return _bottomImageView;
}

-(void)layoutSubviews{
    CGFloat allHeight = 0;
    CGFloat projectAddressheight = self.projectAddress.frame.size.height;
    
    if(projectAddressheight == 0){
        self.projectInvestment.center = CGPointMake(LEFTMARGIN+LEFTPADDING+45, self.projectName.frame.size.height + self.projectName.frame.origin.y+20);
        self.projectArea.center = CGPointMake(229, self.projectName.frame.size.height + self.projectName.frame.origin.y+20);
        allHeight += 30;
    }else{
        self.projectInvestment.center = CGPointMake(LEFTMARGIN+LEFTPADDING+45, self.projectAddress.frame.origin.y + self.projectAddress.frame.size.height+13);
        self.projectArea.center = CGPointMake(229, self.projectAddress.frame.origin.y + self.projectAddress.frame.size.height+13);
        allHeight += 25;
    }
    self.projectInvestmentCount.center = CGPointMake(LEFTMARGIN+LEFTPADDING+47, self.projectArea.frame.origin.y + self.projectArea.frame.size.height+10);
    self.projectAreaCount.center = CGPointMake(231, self.projectArea.frame.origin.y + self.projectArea.frame.size.height+10);
    
    self.projectStartDate.center = CGPointMake(LEFTMARGIN+LEFTPADDING+45, self.projectInvestmentCount.frame.origin.y + self.projectInvestmentCount.frame.size.height+10);
    self.projectEndDate.center = CGPointMake(229, self.projectAreaCount.frame.origin.y + self.projectAreaCount.frame.size.height+10);
    
    self.projectStartDateCount.center = CGPointMake(LEFTMARGIN+LEFTPADDING+47, self.projectStartDate.frame.origin.y + self.projectStartDate.frame.size.height+10);
    self.projectEndDateCount.center = CGPointMake(231, self.projectEndDate.frame.origin.y + self.projectEndDate.frame.size.height+10);
    
    self.mapImageVIew.center = CGPointMake(LEFTMARGIN+144, self.projectEndDateCount.frame.origin.y + self.projectEndDateCount.frame.size.height+60);
    
    self.lastUpdatedTime.center = CGPointMake(LEFTMARGIN+LEFTPADDING+50, self.mapImageVIew.frame.origin.y + self.mapImageVIew.frame.size.height+15);
    self.lastUpdatedTimeCount.center = CGPointMake(LEFTMARGIN+LEFTPADDING+90+72, self.mapImageVIew.frame.origin.y + self.mapImageVIew.frame.size.height+15);
    
    self.cutLine2.center = CGPointMake(LEFTMARGIN+144, self.lastUpdatedTime.frame.origin.y + self.lastUpdatedTime.frame.size.height+5);
    
    self.commentsNum.center = CGPointMake(LEFTMARGIN+LEFTPADDING+70, self.cutLine2.frame.origin.y + self.cutLine2.frame.size.height+20);
    self.focusBtn.center = CGPointMake(LEFTMARGIN+LEFTPADDING+140+81, self.cutLine2.frame.origin.y + self.cutLine2.frame.size.height+20);
    
    allHeight += self.projectName.frame.size.height+self.projectAddress.frame.size.height+10;
    allHeight += self.projectArea.frame.size.height;
    allHeight += self.projectStartDate.frame.size.height;
    allHeight += self.projectStartDateCount.frame.size.height;
    allHeight += self.mapImageVIew.frame.size.height+10;
    allHeight += self.lastUpdatedTime.frame.size.height;
    allHeight += self.commentsNum.frame.size.height+20;
    allHeight += self.bottomImageView.frame.size.height;
    self.contentImageView.frame = CGRectMake(LEFTMARGIN, 46, 288, allHeight);
    self.bottomImageView.center = CGPointMake(LEFTMARGIN+144, allHeight+46);
}

-(void)setModel:(projectModel *)model{
    self.projectID = model.a_id;
    if([model.a_projectstage isEqualToString:@"1"]){
        self.stageLabel.text = @"土地信息阶段";
    }else if([model.a_projectstage isEqualToString:@"2"]){
        self.stageLabel.text = @"主体设计阶段";
    }else if([model.a_projectstage isEqualToString:@"3"]){
        self.stageLabel.text = @"主体施工阶段";
    }else if([model.a_projectstage isEqualToString:@"4"]){
        self.stageLabel.text = @"装修阶段";
    }else{
        self.stageLabel.text = @"土地信息阶段";
    }
    
    if([model.a_projectName isEqualToString:@""]){
        self.projectName.frame = CGRectMake(LEFTMARGIN+LEFTPADDING+3, 52, 254, 30);
        self.projectName.textColor = AllNoDataColor;
        self.projectName.text = @"项目名称";
    }else{
        CGSize projectNameSize =CGSizeMake(254,60);
        CGSize projectNameActualsize =[model.a_projectName boundingRectWithSize:projectNameSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
        self.projectName.frame = CGRectMake(LEFTMARGIN+LEFTPADDING+2, 52, 254, projectNameActualsize.height);
        self.projectName.text = model.a_projectName;
        self.projectName.textColor = [UIColor blackColor];
    }
    
    if([model.a_city isEqualToString:@""] && [model.a_landAddress isEqualToString:@""]){
        self.projectAddress.frame = CGRectZero;
    }else{
        NSString* tempStr = [NSString stringWithFormat:@"%@ %@",model.a_city,model.a_landAddress];
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:BlueColor range:NSMakeRange(0, model.a_city.length)];
        CGSize projectAddressSize =CGSizeMake(254,60);
        CGSize projectAddressActualsize =[tempStr boundingRectWithSize:projectAddressSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT} context:nil].size;
        self.projectAddress.frame = CGRectMake(LEFTMARGIN+LEFTPADDING-2, 54+self.projectName.frame.size.height, 254, projectAddressActualsize.height+10);
        self.projectAddress.attributedText = attStr;
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_investment] isEqualToString:@""]){
        self.projectInvestmentCount.text = @"－";
        self.projectInvestmentCount.textColor = AllNoDataColor;
    }else{
        if([[NSString stringWithFormat:@"%@",model.a_investment] isEqualToString:@"0"]){
            self.projectInvestmentCount.text = @"－";
            self.projectInvestmentCount.textColor = AllNoDataColor;
        }else{
            self.projectInvestmentCount.text = [NSString stringWithFormat:@"%@",model.a_investment];
            self.projectInvestmentCount.textColor = [UIColor blackColor];
        }
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_storeyArea] isEqualToString:@""]){
        self.projectAreaCount.text = @"－";
        self.projectAreaCount.textColor = AllNoDataColor;
    }else{
        if([[NSString stringWithFormat:@"%@",model.a_storeyArea] isEqualToString:@"0"]){
            self.projectAreaCount.text = @"－";
            self.projectAreaCount.textColor = AllNoDataColor;
        }else{
            self.projectAreaCount.text = [NSString stringWithFormat:@"%@",model.a_storeyArea];
            self.projectAreaCount.textColor = [UIColor blackColor];
        }
    }
    
    if([model.a_exceptStartTime isEqualToString:@""]){
        self.projectStartDateCount.text = @"－";
        self.projectStartDateCount.textColor = AllNoDataColor;
    }else{
        self.projectStartDateCount.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        self.projectStartDateCount.textColor = [UIColor blackColor];
    }
    
    if([model.a_exceptFinishTime isEqualToString:@""]){
        self.projectEndDateCount.text = @"－";
        self.projectEndDateCount.textColor = AllNoDataColor;
    }else{
        self.projectEndDateCount.text = [model.a_exceptStartTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        self.projectEndDateCount.textColor = [UIColor blackColor];
    }
    
    if([model.a_longitude isEqualToString:@""] && [model.a_latitude isEqualToString:@""]){
        [self.mapImageVIew sd_setImageWithURL:[NSURL URLWithString:model.a_imageLocation] placeholderImage:[GetImagePath getImagePath:@"mapdef"]];
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?width=568&height=220&center=%@,%@&zoom=14&markers=%@,%@&markerStyles=",model.a_longitude,model.a_latitude,model.a_longitude,model.a_latitude];
        [self.mapImageVIew sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[GetImagePath getImagePath:@"mapdef"]];
    }
    
    self.lastUpdatedTimeCount.text = [model.a_lastUpdatedTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    self.commentsNum.text = [NSString stringWithFormat:@"评论 %@",model.a_commentsNum];
    
    self.isFocused = model.isFocused;
    if([model.isFocused isEqualToString:@"0"]){
        [self.focusBtn setImage:[GetImagePath getImagePath:@"addfocus"] forState:UIControlStateNormal];
    }else{
        [self.focusBtn setImage:[GetImagePath getImagePath:@"cancelfocus"] forState:UIControlStateNormal];
    }
    
    CGFloat allHeight = 0;
    CGFloat projectAddressheight = self.projectAddress.frame.size.height;
    if(projectAddressheight == 0){
        allHeight += 36;
    }else{
        allHeight += 30;
    }
    allHeight += self.projectName.frame.size.height+self.projectAddress.frame.size.height+10;
    allHeight += self.projectInvestmentCount.frame.size.height;
    allHeight += self.projectStartDate.frame.size.height;
    allHeight += self.projectStartDateCount.frame.size.height;
    allHeight += self.mapImageVIew.frame.size.height;
    allHeight += self.lastUpdatedTime.frame.size.height;
    allHeight += self.commentsNum.frame.size.height;
    allHeight += 90;
    
    CGRect frame = [self frame];
    frame.size.height = allHeight;
    self.frame = frame;
}

-(void)focusBtnAction{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([self.isFocused isEqualToString:@"0"]){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.projectID forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                    [self.focusBtn setImage:[GetImagePath getImagePath:@"cancelfocus"] forState:UIControlStateNormal];
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:nil];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.projectID forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.focusBtn setImage:[GetImagePath getImagePath:@"addfocus"] forState:UIControlStateNormal];
                    self.isFocused = @"0";
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
    }else{
        if([self.delegate respondsToSelector:@selector(gotoLoginView)]){
            [self.delegate gotoLoginView];
        }
    }
}
@end
