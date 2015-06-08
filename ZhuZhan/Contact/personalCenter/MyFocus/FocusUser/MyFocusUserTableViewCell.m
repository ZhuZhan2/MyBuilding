//
//  MyFocusUserTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/22.
//
//

#import "MyFocusUserTableViewCell.h"
#import "IsFocusedApi.h"
#import "LoginSqlite.h"
@implementation MyFocusUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.userHeadBtn];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.companyLabel];
        [self.contentView addSubview:self.cutLine];
        [self.contentView addSubview:self.isFocusBtn];
    }
    return self;
}

-(UIButton *)userHeadBtn{
    if(!_userHeadBtn){
        _userHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _userHeadBtn.frame = CGRectMake(20, 12, 37, 37);
        _userHeadBtn.layer.cornerRadius=18.5;
        _userHeadBtn.layer.masksToBounds=YES;
        [_userHeadBtn addTarget:self action:@selector(userHeadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userHeadBtn;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 10, 200, 20)];
        _nameLabel.font=[UIFont boldSystemFontOfSize:16];
        _nameLabel.textColor=RGBCOLOR(89, 89, 89);
    }
    return _nameLabel;
}

-(UILabel *)companyLabel{
    if(!_companyLabel){
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 30, 140, 20)];
        _companyLabel.font=[UIFont systemFontOfSize:14];
        _companyLabel.textColor=RGBCOLOR(149, 149, 149);
    }
    return _companyLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 61, 320, 1)];
        _cutLine.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutLine;
}

-(UIButton *)isFocusBtn{
    if(!_isFocusBtn){
        _isFocusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _isFocusBtn.frame = CGRectMake(220, 18, 81, 28);
        [_isFocusBtn addTarget:self action:@selector(isFocusBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _isFocusBtn;
}

-(void)setModel:(MyCenterModel *)model{
    self.contractId = model.a_id;
    self.isFocused = model.a_isFocus;
    
    [self.userHeadBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.a_userImage] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_卡片头像"]];
    self.nameLabel.text = model.a_userName;
    self.companyLabel.text = model.a_company;
    if([self.isFocused isEqualToString:@"0"]){
        [_isFocusBtn setImage:[GetImagePath getImagePath:@"addfocus"] forState:UIControlStateNormal];
    }else{
        [_isFocusBtn setImage:[GetImagePath getImagePath:@"cancelfocus"] forState:UIControlStateNormal];
    }
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(void)isFocusBtnAction{
    if([self.delegate respondsToSelector:@selector(addFocused:)]){
        [self.delegate addFocused:self.indexPath];
    }
}

-(void)userHeadBtnAction{
    if([self.delegate respondsToSelector:@selector(userHeadClick:)]){
        [self.delegate userHeadClick:self.indexPath];
    }
}
@end
