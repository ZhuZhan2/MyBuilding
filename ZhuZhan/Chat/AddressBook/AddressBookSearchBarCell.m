//
//  AddressBookSearchBarCell.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/8.
//
//

#import "AddressBookSearchBarCell.h"
@interface AddressBookSearchBarCell ()
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UIImageView* mainImageView;
@property(nonatomic,strong)UILabel* mainLabel;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong,setter=setModel:)AddressBookSearchBarCellModel* model;
@property(nonatomic,strong)NSIndexPath* indexPath;
@end

#define mainLabelFont [UIFont systemFontOfSize:13]

@implementation AddressBookSearchBarCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView=[[UIImageView alloc]init];
        _mainImageView.frame=CGRectMake(0, 0, 37, 37);
    }
    return _mainImageView;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 17)];
        _mainLabel.font=mainLabelFont;
    }
    return _mainLabel;
}

-(UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10, 0, 42, 50);
        [_headBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 1)];
        _seperatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    }
    return _seperatorLine;
}

-(void)setUp{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.mainLabel];
    [self.contentView addSubview:self.seperatorLine];
    [self.contentView addSubview:self.headBtn];
}

-(void)setModel:(AddressBookSearchBarCellModel *)model indexPath:(NSIndexPath *)indexPath{
    _model=model;
    _indexPath = indexPath;
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageUrl] placeholderImage:[GetImagePath getImagePath:@"人脉_06a2"]];
    self.mainLabel.text=model.mainLabelText;
    
    self.mainImageView.center=CGPointMake(30, 47*0.5);
    self.mainLabel.frame=CGRectMake(65, 15, CGRectGetWidth(self.mainLabel.frame), CGRectGetHeight(self.mainLabel.frame));
    self.seperatorLine.center=CGPointMake(kScreenWidth-CGRectGetWidth(self.seperatorLine.frame)*0.5, 47-CGRectGetHeight(self.seperatorLine.frame)*.5);
}

-(void)headAction{
    NSLog(@"headAction");
    if([self.searchDelegate respondsToSelector:@selector(headSearchBarClick:)]){
        [self.searchDelegate headSearchBarClick:self.indexPath];
    }
}
@end
@implementation AddressBookSearchBarCellModel
@end