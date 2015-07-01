//
//  ForwardListCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/1.
//
//

#import "ForwardListCell.h"

@implementation ForwardListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.cutLine];
    }
    return self;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7.5, 35, 35)];
        _headImageView.layer.cornerRadius=17.5;
        _headImageView.layer.masksToBounds=YES;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 17, 160, 16)];
        _nameLabel.font=[UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor=RGBCOLOR(89, 89, 89);
    }
    return _nameLabel;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
        _cutLine.backgroundColor = RGBCOLOR(229, 229, 229);
    }
    return _cutLine;
}

-(void)setModel:(ChatListModel *)model{
    if([model.a_type isEqualToString:@"01"]){
        self.nameLabel.text=model.a_loginName;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_loginImageUrl]] placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_会话头像"]];
    }else{
        self.nameLabel.text=model.a_groupName;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.a_loginImageUrl]] placeholderImage:[GetImagePath getImagePath:@"默认图_群组头像_会话头像"]];
    }
}
@end
