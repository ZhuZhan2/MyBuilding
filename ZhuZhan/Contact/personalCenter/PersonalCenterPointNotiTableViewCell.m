//
//  PersonalCenterPointNotiTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/17.
//
//

#import "PersonalCenterPointNotiTableViewCell.h"
#import "RKViewFactory.h"
#import "RKShadowView.h"

@implementation PersonalCenterPointNotiTableViewCell

+ (CGFloat)carculateCellHeightWithModel:(PersonalCenterModel *)cellModel{
    CGFloat height = 0;
    if(![cellModel.a_msgContent isEqualToString:@""]){
        height += [RKViewFactory autoLabelWithMaxWidth:280 maxHeight:100 font:[UIFont systemFontOfSize:14] content:cellModel.a_msgContent]+10;
    }else{
        height +=5;
    }
    
    height +=37;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.cutline1];
        [self.bgView addSubview:self.cutline2];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.timeLabel];
    }
    return self;
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 172)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIImageView *)cutline1{
    if(!_cutline1){
        _cutline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutline1.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutline1;
}

-(UIImageView *)cutline2{
    if(!_cutline2){
        _cutline2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutline2.image = [GetImagePath getImagePath:@"project_cutline"];
    }
    return _cutline2;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 20)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _titleLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 140, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = AllNoDataColor;
    }
    return _timeLabel;
}

-(void)setPersonalCenterModel:(PersonalCenterModel *)personalCenterModel{
    NSLog(@"%@",personalCenterModel.a_msgContent);
    self.titleLabel.text = personalCenterModel.a_msgContent;
    self.timeLabel.text = personalCenterModel.a_createdTime;
    CGFloat height = 0;
    CGRect frame = self.cutline1.frame;
    height += CGRectGetHeight(self.cutline1.frame)+5;
    
    if(![personalCenterModel.a_msgContent isEqualToString:@""]){
        self.titleLabel.hidden = NO;
        [RKViewFactory autoLabel:self.titleLabel maxWidth:280 maxHeight:100];
        frame = self.titleLabel.frame;
        frame.origin.y = height;
        self.titleLabel.frame = frame;
        height += CGRectGetHeight(self.titleLabel.frame)+5;
    }else{
        self.titleLabel.hidden = YES;
    }
    
    frame = self.timeLabel.frame;
    frame.origin.y = height;
    self.timeLabel.frame = frame;
    
    height += CGRectGetHeight(self.timeLabel.frame)+5;
    
    
    
    
    frame = self.cutline2.frame;
    frame.origin.y = height;
    self.cutline2.frame = frame;
    height += CGRectGetHeight(self.cutline2.frame);
    
    frame = self.bgView.frame;
    frame.size.height = height;
    self.bgView.frame = frame;
}
@end
