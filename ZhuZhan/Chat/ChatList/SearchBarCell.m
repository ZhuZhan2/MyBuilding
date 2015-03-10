//
//  SearchBarCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import "SearchBarCell.h"
#import "EGOImageView.h"
@interface SearchBarCell ()
@property(nonatomic,strong)EGOImageView* mainImageView;
@property(nonatomic,strong)UILabel* mainLabel;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong,setter=setModel:)SearchBarCellModel* model;

@end

#define mainLabelFont [UIFont systemFontOfSize:16]

@implementation SearchBarCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(EGOImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
        _mainImageView.frame=CGRectMake(0, 0, 37, 37);
    }
    return _mainImageView;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        _mainLabel.font=mainLabelFont;
    }
    return _mainLabel;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        _seperatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    }
    return _seperatorLine;
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.seperatorLine];
}

-(void)setModel:(SearchBarCellModel *)model{
    _model=model;
    self.mainImageView.imageURL=[NSURL URLWithString:model.mainImageUrl];
    self.mainLabel.text=model.mainLabelText;
}

-(void)layoutSubviews{
    self.mainImageView.center=CGPointMake(30, CGRectGetHeight(self.frame)*0.5);
    self.mainLabel.frame=CGRectMake(60, 15, CGRectGetWidth(self.mainLabel.frame), CGRectGetHeight(self.mainLabel.frame));
    self.seperatorLine.center=CGPointMake(kScreenWidth-CGRectGetWidth(self.seperatorLine.frame)*0.5, self.frame.size.height-CGRectGetHeight(self.seperatorLine.frame)*.5);
}
@end


@implementation SearchBarCellModel
@end