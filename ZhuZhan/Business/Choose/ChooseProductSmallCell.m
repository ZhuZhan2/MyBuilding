//
//  ChooseProductSmallCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductSmallCell.h"
@interface ChooseProductSmallCell ()
@property(nonatomic,strong)UIImageView* assistImageView;
@property(nonatomic,strong)UILabel* mainLabel;
@property(nonatomic,strong)UIView* seperatorLine;
@end

#define mainFont [UIFont systemFontOfSize:15]

@implementation ChooseProductSmallCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.assistImageView];
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.seperatorLine];
}

-(UIImageView *)assistImageView{
    if (!_assistImageView) {
        _assistImageView=[[UIImageView alloc]initWithFrame:CGRectMake(23, 17, 14, 14)];
    }
    return _assistImageView;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 16, 200, 16)];
        _mainLabel.font=mainFont;
    }
    return _mainLabel;
}

-(UIView*)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        _seperatorLine.backgroundColor=RGBCOLOR(215, 215, 215);
    }
    return _seperatorLine;
}

-(void)setModel:(ChooseProductCellModel *)model{
    _model=model;
    self.mainLabel.text=model.content;
    self.assistImageView.image=[GetImagePath getImagePath:model.isHighlight?@"多选已选":@"多选未选"];
}
@end

