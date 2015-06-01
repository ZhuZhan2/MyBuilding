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
        [self.contentView addSubview:self.contentImageView];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.projectName];
        [self.contentView addSubview:self.projectAddress];
        [self.contentView addSubview:self.projectInvestment];
        [self.contentView addSubview:self.projectArea];
        [self.contentView addSubview:self.projectInvestmentCount];
        [self.contentView addSubview:self.projectAreaCount];
        [self.contentView addSubview:self.mapImageVIew];
        [self.contentView addSubview:self.lastUpdatedTime];
        [self.contentView addSubview:self.lastUpdatedTimeCount];
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
        _stageLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMARGIN+LEFTPADDING, 14, 130, 36)];
        _stageLabel.textColor = BlueColor;
        _stageLabel.font = FONT;
    }
    return _stageLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(LEFTMARGIN, 52, 288, 1)];
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

-(UIImageView *)mapImageVIew{
    if(!_mapImageVIew){
        _mapImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 284, 110)];
        _mapImageVIew.backgroundColor = RGBCOLOR(215, 216, 215);
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

-(UIButton *)focusBtn{
    if(!_focusBtn){
        _focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _focusBtn.frame = CGRectMake(210, 18, 81, 28);
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
    
    self.mapImageVIew.center = CGPointMake(LEFTMARGIN+144, self.projectAreaCount.frame.origin.y + self.projectAreaCount.frame.size.height+60);
    
    self.lastUpdatedTime.center = CGPointMake(LEFTMARGIN+LEFTPADDING+50, self.mapImageVIew.frame.origin.y + self.mapImageVIew.frame.size.height+15);
    self.lastUpdatedTimeCount.center = CGPointMake(LEFTMARGIN+LEFTPADDING+90+72, self.mapImageVIew.frame.origin.y + self.mapImageVIew.frame.size.height+15);
    
    allHeight += self.projectName.frame.size.height+self.projectAddress.frame.size.height+10;
    allHeight += self.projectArea.frame.size.height;
    allHeight += self.mapImageVIew.frame.size.height+10;
    allHeight += self.lastUpdatedTime.frame.size.height;
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
        self.projectName.frame = CGRectMake(LEFTMARGIN+LEFTPADDING+2, 58, 254, projectNameActualsize.height);
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
        self.projectAddress.frame = CGRectMake(LEFTMARGIN+LEFTPADDING-2, 58+self.projectName.frame.size.height, 254, projectAddressActualsize.height+10);
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
    
    if([model.a_longitude isEqualToString:@""] && [model.a_latitude isEqualToString:@""]){
        [self.mapImageVIew sd_setImageWithURL:[NSURL URLWithString:model.a_imageLocation] placeholderImage:[GetImagePath getImagePath:@"project_default_list"]];
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?width=568&height=220&center=%@,%@&zoom=14&markers=%@,%@&markerStyles=",model.a_longitude,model.a_latitude,model.a_longitude,model.a_latitude];
        [self.mapImageVIew sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[GetImagePath getImagePath:@"project_default_list"]];
    }
    
    self.lastUpdatedTimeCount.text = [model.a_lastUpdatedTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    self.isFocused = model.isFocused;
    if([model.isFocused isEqualToString:@"0"]){
        [self.focusBtn setImage:[GetImagePath getImagePath:@"addfocus"] forState:UIControlStateNormal];
    }else{
        [self.focusBtn setImage:[GetImagePath getImagePath:@"cancelfocus"] forState:UIControlStateNormal];
    }
    
    CGFloat allHeight = 0;
    CGFloat projectAddressheight = self.projectAddress.frame.size.height;
    if(projectAddressheight == 0){
        allHeight += 30;
    }else{
        allHeight += 25;
    }
    allHeight += self.projectName.frame.size.height+self.projectAddress.frame.size.height+10;
    allHeight += self.projectInvestmentCount.frame.size.height;
    allHeight += self.mapImageVIew.frame.size.height;
    allHeight += self.lastUpdatedTime.frame.size.height;
    allHeight += 66;
    
    CGRect frame = [self frame];
    frame.size.height = allHeight;
    self.frame = frame;
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)focusBtnAction{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([self.delegate respondsToSelector:@selector(addFocused:)]){
            [self.delegate addFocused:self.indexPath];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(gotoLoginView)]){
            [self.delegate gotoLoginView];
        }
    }
}
@end
