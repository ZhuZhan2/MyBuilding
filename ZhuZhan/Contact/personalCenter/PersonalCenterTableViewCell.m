//
//  PersonalCenterTableViewCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/4.
//
//

#import "PersonalCenterTableViewCell.h"
#import "RKViewFactory.h"

@implementation PersonalCenterTableViewCell

+ (CGFloat)carculateCellHeightWithModel:(PersonalCenterModel *)cellModel{
    CGFloat height = 0;
    if(![cellModel.a_imageUrl isEqualToString:@""]){
        height += 160;
    }
    
    if(![cellModel.a_content isEqualToString:@""]){
        height += [RKViewFactory autoLabelWithMaxWidth:280 maxHeight:40 font:[UIFont systemFontOfSize:14] content:cellModel.a_content]+10;
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
        [self.bgView addSubview:self.bigImageView];
        [self.bgView addSubview:self.contentLabel];
        [self.bgView addSubview:self.typeLabel];
        [self.bgView addSubview:self.timelabel];
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

-(UIImageView *)bigImageView{
    if(!_bigImageView){
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 320, 160)];
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bigImageView;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 280, 20)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _contentLabel;
}

-(UILabel *)typeLabel{
    if(!_typeLabel){
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,165,140,20)];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = BlueColor;
    }
    return _typeLabel;
}

-(UILabel *)timelabel{
    if(!_timelabel){
        _timelabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 165, 140, 20)];
        _timelabel.font = [UIFont systemFontOfSize:14];
        _timelabel.textColor = AllNoDataColor;
    }
    return _timelabel;
}

-(void)setPersonalCentermodel:(PersonalCenterModel *)personalCentermodel{
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:personalCentermodel.a_imageUrl] placeholderImage:[GetImagePath getImagePath:@"默认图_动态详情"]];
    
    self.contentLabel.text = personalCentermodel.a_content;
    
    if([personalCentermodel.a_category isEqualToString:@"Personal"]){
        self.typeLabel.text = @"我发布的动态有新评论";
    }else{
        self.typeLabel.text = @"我发布的产品有新评论";
    }
    
    self.timelabel.text = personalCentermodel.a_time;
        
    CGFloat height = 0;
    CGRect frame = self.cutline1.frame;
    height += CGRectGetHeight(self.cutline1.frame);
    
    if (![personalCentermodel.a_imageUrl isEqualToString:@""]) {
        self.bigImageView.hidden = NO;
        frame = self.bigImageView.frame;
        frame.origin.y = height;
        self.bigImageView.frame = frame;
        height += CGRectGetHeight(self.bigImageView.frame)+5;
    }else{
        self.bigImageView.hidden = YES;
        height += 5;
    }
    
    if(![personalCentermodel.a_content isEqualToString:@""]){
        self.contentLabel.hidden = NO;
        [RKViewFactory autoLabel:self.contentLabel maxWidth:280 maxHeight:40];
        frame = self.contentLabel.frame;
        frame.origin.y = height;
        self.contentLabel.frame = frame;
        height += CGRectGetHeight(self.contentLabel.frame)+5;
    }else{
        self.contentLabel.hidden = YES;
    }
    
    frame = self.typeLabel.frame;
    frame.origin.y = height;
    self.typeLabel.frame = frame;
    
    frame = self.timelabel.frame;
    frame.origin.y = height;
    self.timelabel.frame = frame;
    
    height += CGRectGetHeight(self.typeLabel.frame)+5;
    
    
    
    
    frame = self.cutline2.frame;
    frame.origin.y = height;
    self.cutline2.frame = frame;
    height += CGRectGetHeight(self.cutline2.frame);
    
    frame = self.bgView.frame;
    frame.size.height = height;
    self.bgView.frame = frame;
}
@end
