//
//  RequireCommentTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/10.
//
//

#import "RequireCommentTableViewCell.h"
#import "RKViewFactory.h"

@implementation RequireCommentTableViewCell

+ (CGFloat)carculateCellHeightWithModel:(ContactCommentModel *)cellModel{
    CGFloat height = 0;
    height += 40;
    height += [RKViewFactory autoLabelWithMaxWidth:300 maxHeight:1000 font:[UIFont systemFontOfSize:14] content:cellModel.a_commentContents]+5;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headBtn];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.cutLine];
    }
    return self;
}

-(UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10, 10, 40, 40);
    }
    return _headBtn;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, 120, 20)];
        _nameLabel.textColor = RGBCOLOR(51, 51, 51);
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 32, 0, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 47, 300, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

-(void)setModel:(ContactCommentModel *)model{
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.a_avatarUrl] forState:UIControlStateNormal placeholderImage:[GetImagePath getImagePath:model.a_isPersonal?@"默认图_人脉_卡片头像":@"默认图_公司头像_卡片头像"]];
    self.headBtn.layer.cornerRadius = model.a_isPersonal?20:3;
    self.nameLabel.text = model.a_userName;
    self.timeLabel.text = model.a_createdTime;
}
@end
