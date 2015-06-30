//
//  PersonalProjectTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-28.
//
//

#import "PersonalProjectTableViewCell.h"

@implementation PersonalProjectTableViewCell

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
        [self.bgView addSubview:self.addressLabel];
        [self.contentView addSubview:self.bgView];
    }
    return self;
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
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
        _cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69, 320, 1)];
        _cutLine2.backgroundColor = RGBCOLOR(217, 217, 217);
    }
    return _cutLine2;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 45, 120, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 160, 20)];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = BlueColor;
    }
    return _contentLabel;
}

-(UILabel *)addressLabel{
    if(!_addressLabel){
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 280, 20)];
        _addressLabel.font = [UIFont systemFontOfSize:14];
    }
    return _addressLabel;
}

-(void)setModel:(PersonalCenterModel *)model{
    if(model.a_type == 1){
        self.contentLabel.text = @"我建立的项目有新评论";
        self.titleLabel.text = model.a_projectName;
        self.addressLabel.text = model.a_projectAddress;
    }else if(model.a_type == 8){
        self.contentLabel.text = @"我发布的需求有新评论";
        self.titleLabel.text = model.a_reqType;
        self.addressLabel.text = model.a_reqDesc;
    }else{
        self.contentLabel.text = @"我发布的需求有客服回复";
        self.titleLabel.text = model.a_reqType;
        self.addressLabel.text = model.a_reqDesc;
    }
    self.timeLabel.text = model.a_createdTime;
}
@end
