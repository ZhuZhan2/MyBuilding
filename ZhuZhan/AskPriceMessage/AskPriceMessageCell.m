//
//  AskPriceMessageCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import "AskPriceMessageCell.h"
#import "RKShadowView.h"
@implementation AskPriceMessageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.cutLine];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 180, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UIView *)cutLine{
    if(!_cutLine){
        _cutLine = [RKShadowView seperatorLine];
    }
    return _cutLine;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 130, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:16];
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}


-(void)setModel:(AskPriceMessageModel *)model{
    CGRect frame = [self frame];
    self.timeLabel.text = model.a_time;
    self.titleLabel.text = model.a_title;
    CGSize size =CGSizeMake(290,500);
    CGSize actualsize =[model.a_content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.contentLabel.frame = CGRectMake(15, 36, 290, actualsize.height);
    self.contentLabel.text = model.a_content;
    self.cutLine.frame = CGRectMake(0, 36+actualsize.height+10, 320, 1);
    frame.size.height = 36+actualsize.height+11;
    self.frame = frame;
}
@end
