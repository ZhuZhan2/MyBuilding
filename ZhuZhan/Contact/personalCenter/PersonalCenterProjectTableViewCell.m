//
//  PersonalCenterProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/24.
//
//

#import "PersonalCenterProjectTableViewCell.h"

@implementation PersonalCenterProjectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.bgView addSubview:self.cutLine1];
        [self.bgView addSubview:self.cutLine2];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.contentLabel];
        [self.bgView addSubview:self.timeLabel];
        [self.contentView addSubview:self.bgView];
    }
    return self;
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIImageView *)cutLine1{
    if(!_cutLine1){
        _cutLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine1.backgroundColor = RGBCOLOR(217, 217, 217);
    }
    return _cutLine1;
}

-(UIImageView *)cutLine2{
    if(!_cutLine2){
        _cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
        _cutLine2.backgroundColor = RGBCOLOR(217, 217, 217);
    }
    return _cutLine2;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _titleLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 25, 120, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 150, 20)];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = BlueColor;
    }
    return _contentLabel;
}

-(void)setCompanyName:(NSString *)companyName{
    self.titleLabel.text = companyName;
}

-(void)setTime:(NSString *)time{
    self.timeLabel.text = time;
}

-(void)setProjectDemo:(NSString *)projectDemo{
    if([projectDemo isEqualToString:@"02"]){
        self.contentLabel.text = @"该项目认证成功";
    }else{
        self.contentLabel.text = @"该项目认证失败";
    }
}
@end
