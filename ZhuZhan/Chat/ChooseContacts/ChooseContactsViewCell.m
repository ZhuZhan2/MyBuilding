//
//  ChooseContactsViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "ChooseContactsViewCell.h"
#import "EGOImageView.h"
@interface ChooseContactsViewCell ()
@property(nonatomic,strong)EGOImageView* mainImageView;
@property(nonatomic,strong)UILabel* mainLabel;
@property(nonatomic,strong)UIButton* assistBtn;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong,setter=setModel:)ChooseContactsCellModel* model;

@property(nonatomic,weak)id<ChooseContactsViewCellDelegate>delegate;
@property(nonatomic,strong)NSIndexPath* indexPath;
@end

#define mainLabelFont [UIFont systemFontOfSize:16]

@implementation ChooseContactsViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<ChooseContactsViewCellDelegate>)delegate{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.delegate=delegate;
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

-(UIButton *)assistBtn{
    if (!_assistBtn) {
        _assistBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
        [_assistBtn addTarget:self action:@selector(chooseAssistBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _assistBtn;
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
    [self.contentView addSubview:self.assistBtn];
    [self.contentView addSubview:self.seperatorLine];
}

-(void)setModel:(ChooseContactsCellModel *)model indexPath:(NSIndexPath*)indexPath{
    _model=model;
    _indexPath=indexPath;
    self.mainImageView.imageURL=[NSURL URLWithString:model.mainImageUrl];
    self.mainLabel.text=model.mainLabelText;
    [self.assistBtn setBackgroundImage:[GetImagePath getImagePath:model.isHighlight?@"公司认证员工_08a":@"公司认证员工_18a"] forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    self.mainImageView.center=CGPointMake(30, CGRectGetHeight(self.frame)*0.5);
    self.mainLabel.frame=CGRectMake(60, 15, CGRectGetWidth(self.mainLabel.frame), CGRectGetHeight(self.mainLabel.frame));
    self.assistBtn.center=CGPointMake(290, 25);
    self.seperatorLine.center=CGPointMake(kScreenWidth-CGRectGetWidth(self.seperatorLine.frame)*0.5, self.frame.size.height-CGRectGetHeight(self.seperatorLine.frame)*.5);
}

-(void)chooseAssistBtn{
    if ([self.delegate respondsToSelector:@selector(chooseAssistBtn:indexPath:)]) {
        [self.delegate chooseAssistBtn:self.assistBtn indexPath:self
         .indexPath];
    }
}
@end


@implementation ChooseContactsCellModel
@end