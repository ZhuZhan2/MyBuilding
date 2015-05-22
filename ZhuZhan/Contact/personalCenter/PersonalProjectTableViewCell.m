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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 280, 20)];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor lightGrayColor];
    }
    return _contentLabel;
}

-(void)setModel:(PersonalCenterModel *)model{
    NSLog(@"===>%@",model.a_id);
    self.contentLabel.text = @"项目有新评论";
    self.titleLabel.text = model.a_entityName;
}
@end
