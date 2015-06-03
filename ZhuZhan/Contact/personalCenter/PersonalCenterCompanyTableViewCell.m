//
//  PersonalCenterCompanyTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/22.
//
//

#import "PersonalCenterCompanyTableViewCell.h"

@implementation PersonalCenterCompanyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.bgView addSubview:self.cutLine1];
        [self.bgView addSubview:self.cutLine2];
        [self.bgView addSubview:self.headImage];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.contentLabel];
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 20)];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.text = @"通过企业认证";
    }
    return _contentLabel;
}

-(UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc] init];
        _headImage.frame = CGRectMake(20.5, 9.5, 30, 30);
        _headImage.layer.cornerRadius=15;
        _headImage.layer.masksToBounds=YES;
    }
    return _headImage;
}

-(void)setImageUrl:(NSString *)imageUrl{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[GetImagePath getImagePath:@"公司－我的公司_02a"]];
}

-(void)setCompanyName:(NSString *)companyName{
    self.titleLabel.text = companyName;
}
@end
