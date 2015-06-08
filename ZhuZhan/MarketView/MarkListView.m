//
//  MarkListView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "MarkListView.h"

@implementation MarkListView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage: [GetImagePath getImagePath:@"card_bg"]];
        [self addSubview:self.cutLine];
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, self.frame.size.width, 1)];
        _cutLine.image = [GetImagePath getImagePath:@"card_cut"];
    }
    return _cutLine;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, 40, 40)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(61, 10, 190, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _nameLabel;
}

-(UILabel *)typeLabel{
    if(!_typeLabel){
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(61, 28, 50, 20)];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = BlueColor;
    }
    return _typeLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(111, 28, 130, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(void)setModel:(MarketModel *)model{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.a_avatarUrl] placeholderImage:[GetImagePath getImagePath:@"默认图_用户头像_卡片头像"]];
    _nameLabel.text = model.a_loginName;
    _typeLabel.text = model.a_reqTypeCn;
    _timeLabel.text = model.a_createdTime;
}
@end
