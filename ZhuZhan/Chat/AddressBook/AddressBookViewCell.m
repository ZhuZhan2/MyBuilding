//
//  AddressBookViewCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/12.
//
//

#import "AddressBookViewCell.h"

@interface AddressBookViewCell ()
@property(nonatomic,strong)UIImageView* mainImageView;
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)UILabel* mainLabel;
//@property(nonatomic,strong)UIButton* assistBtn;
@property(nonatomic,strong)UIView* seperatorLine;
@property(nonatomic,strong,setter=setModel:)AddressBookCellModel* model;

@property(nonatomic,weak)id<AddressBookViewCellDelegate>delegate;
@property(nonatomic,strong)NSIndexPath* indexPath;
@end

#define mainLabelFont [UIFont systemFontOfSize:13]
#define seperatorLineColor RGBCOLOR(229, 229, 229)

@implementation AddressBookViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<AddressBookViewCellDelegate>)delegate{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.delegate=delegate;
        [self setUp];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView=[[UIImageView alloc]init];
        _mainImageView.frame=CGRectMake(0, 0, 35, 35);
        _mainImageView.layer.cornerRadius=3;
        _mainImageView.layer.masksToBounds=YES;
    }
    return _mainImageView;
}

-(UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10, 0, 42, 50);
        [_headBtn addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 20)];
        _mainLabel.font=mainLabelFont;
    }
    return _mainLabel;
}

//-(UIButton *)assistBtn{
//    if (!_assistBtn) {
//        _assistBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
//        [_assistBtn addTarget:self action:@selector(chooseAssistBtn) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _assistBtn;
//}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 1)];
        _seperatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    }
    return _seperatorLine;
}

-(void)setUp{
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.mainLabel];
//    [self.contentView addSubview:self.assistBtn];
    [self.contentView addSubview:self.seperatorLine];
    [self.contentView addSubview:self.headBtn];
}

-(void)setUpSelectedBackView{
    CGFloat lineHeight=CGRectGetHeight(self.seperatorLine.frame);
    CGRect frame=self.bounds;
    frame.origin.y-=lineHeight;
    frame.size.height+=lineHeight;
    UIView* selectedBackView=[[UIView alloc]initWithFrame:frame];
    selectedBackView.backgroundColor=seperatorLineColor;
    self.selectedBackgroundView=selectedBackView;
}

-(void)setModel:(AddressBookCellModel *)model indexPath:(NSIndexPath*)indexPath{
    _model=model;
    _indexPath=indexPath;
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageUrl] placeholderImage:[GetImagePath getImagePath:@"35px未设置"]];
    self.mainLabel.text=model.mainLabelText;
    //[self.assistBtn setBackgroundImage:[GetImagePath getImagePath:model.isHighlight?@"已选择联系人":@"未选择联系人"] forState:UIControlStateNormal];

    [self setUpSelectedBackView];
    self.mainImageView.center=CGPointMake(30, 23.5);
    self.mainLabel.frame=CGRectMake(60, 15, CGRectGetWidth(self.mainLabel.frame), CGRectGetHeight(self.mainLabel.frame));
    //self.assistBtn.center=CGPointMake(290, 25);
    self.seperatorLine.center=CGPointMake(kScreenWidth-CGRectGetWidth(self.seperatorLine.frame)*0.5, 47);
}

//-(void)chooseAssistBtn{
//    if ([self.delegate respondsToSelector:@selector(chooseAssistBtn:indexPath:)]) {
//        [self.delegate chooseAssistBtn:self.assistBtn indexPath:self.indexPath];
//    }
//}

+(UIView *)fullSeperatorLine{
    UIView* seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    seperatorLine.backgroundColor=seperatorLineColor;
    return seperatorLine;
}

-(void)headAction{
    NSLog(@"headAction");
    if([self.delegate respondsToSelector:@selector(headClick:)]){
        [self.delegate headClick:self.indexPath];
    }
}
@end


@implementation AddressBookCellModel
@end
