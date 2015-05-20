//
//  ProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import "ProjectTableViewCell.h"
#import "ProjectStage.h"

#define FONT [UIFont systemFontOfSize:15]
#define LEFTMARGIN 16
#define LEFTPADDING 14
@implementation ProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(239, 237, 237);
        [self.contentView addSubview:self.topImageView];
        [self.contentView addSubview:self.topContentImageView];
        [self.contentView addSubview:self.stageLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.detailBtn];
        [self.contentView addSubview:self.contentImageView];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.projectName];
        [self.contentView addSubview:self.projectAddress];
        [self.contentView addSubview:self.projectInvestment];
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
        _stageLabel.text = @"主体设计阶段";
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

-(UIButton *)detailBtn{
    if(!_detailBtn){
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.frame = CGRectMake(160, 10, 130, 36);
    }
    return _detailBtn;
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
        _projectInvestment = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMARGIN+LEFTPADDING, 0, 90, 20)];
        _projectInvestment.text = @"投资额(百万)";
        _projectInvestment.font = FONT;
        _projectInvestment.textColor = BlueColor;
    }
    return _projectInvestment;
}

-(UILabel *)projectArea{
    if(!_projectArea){
        _projectArea = [[UILabel alloc] initWithFrame:CGRectMake(LEFTMARGIN+LEFTPADDING, 0, 90, 20)];
    }
    return _projectArea;
}

-(void)layoutSubviews{
    CGFloat allHeight = 0;
    CGFloat projectAddressheight = self.projectAddress.frame.size.height;
    if(projectAddressheight == 0){
        self.projectInvestment.center = CGPointMake(LEFTMARGIN+LEFTPADDING+45, self.projectName.frame.size.height + self.projectName.frame.origin.y+20);
        allHeight += 35;
    }else{
        self.projectInvestment.center = CGPointMake(LEFTMARGIN+LEFTPADDING+45, self.projectName.frame.size.height + self.projectAddress.frame.size.height + self.projectAddress.frame.origin.y-8);
        allHeight += 30;
    }
    allHeight += self.projectName.frame.size.height+self.projectAddress.frame.size.height+10;
    self.contentImageView.frame = CGRectMake(LEFTMARGIN, 46, 288, allHeight);
}

-(void)setModel:(projectModel *)model{
    if([model.a_projectName isEqualToString:@""]){
        self.projectName.frame = CGRectMake(LEFTMARGIN+LEFTPADDING+3, 52, 254, 30);
        self.projectName.textColor = AllNoDataColor;
        self.projectName.text = @"项目名称";
    }else{
        CGSize projectNameSize =CGSizeMake(254,60);
        CGSize projectNameActualsize =[model.a_projectName boundingRectWithSize:projectNameSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
        self.projectName.frame = CGRectMake(LEFTMARGIN+LEFTPADDING+3, 52, 254, projectNameActualsize.height);
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
        self.projectAddress.frame = CGRectMake(LEFTMARGIN+LEFTPADDING-1, 54+self.projectName.frame.size.height, 254, projectAddressActualsize.height+10);
        self.projectAddress.attributedText = attStr;
    }
}
@end
