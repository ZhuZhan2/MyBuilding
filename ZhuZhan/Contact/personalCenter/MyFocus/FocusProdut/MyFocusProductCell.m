//
//  MyFocusProductCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "MyFocusProductCell.h"
#import "RKShadowView.h"
@interface MyFocusProductCell ()
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* contentLabel;
@property(nonatomic,strong)UIButton* assistBtn;
@property(nonatomic,strong)UIImageView* mainImageView;

@property(nonatomic,strong)UIView* seperatorLineTop;
@property(nonatomic,strong)UIView* seperatorLineBottom;

@end

@implementation MyFocusProductCell
+ (CGFloat)totalHeight{
    return 143;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self addSubview:self.seperatorLineTop];
    [self addSubview:self.mainImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.assistBtn];
    [self addSubview:self.seperatorLineBottom];
}

- (void)setModel:(MyFocusProductCellModel *)model{
    _model = model;
    [self reload];
}

- (void)reload{
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.model.mainImageUrl] placeholderImage:[GetImagePath getImagePath:@"addfocus"]];
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
    [self.assistBtn setImage:[GetImagePath getImagePath:self.model.status == RKBtnStatusNotStart?@"addfocus":@"cancelfocus"] forState:UIControlStateNormal];
    
    [self autoSizeLabel:self.titleLabel];
    [self autoSizeLabel:self.contentLabel];
    CGRect frame = self.titleLabel.frame;
    frame.origin = CGPointMake(143, 22);
    self.titleLabel.frame = frame;
    
    frame = self.contentLabel.frame;
    frame.origin = CGPointMake(143, CGRectGetMaxY(self.titleLabel.frame));
    self.contentLabel.frame = frame;
}

- (void)assistBtnClicked{
    if ([self.delegate respondsToSelector:@selector(focusBtnClicked)]) {
        [self.delegate focusBtnClicked];
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UIButton *)assistBtn{
    if (!_assistBtn) {
        _assistBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 99, 81, 28)];
        [_assistBtn addTarget:self action:@selector(assistBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _assistBtn;
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 132, 132)];
    }
    return _mainImageView;
}

- (UIView *)seperatorLineTop{
    if (!_seperatorLineTop) {
        _seperatorLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        _seperatorLineTop.backgroundColor = AllBackDeepGrayColor;
        
        UIView* seperatorLine = [RKShadowView seperatorLine];
        CGRect frame = seperatorLine.frame;
        frame.origin.y = 9;
        seperatorLine.frame = frame;
        [_seperatorLineTop addSubview:seperatorLine];
    }
    return _seperatorLineTop;
}

- (UIView *)seperatorLineBottom{
    if (!_seperatorLineBottom) {
        _seperatorLineBottom = [RKShadowView seperatorLine];
        CGRect frame = _seperatorLineBottom.frame;
        frame.origin.y = 142;
        _seperatorLineBottom.frame = frame;
    }
    return _seperatorLineBottom;
}

- (void)autoSizeLabel:(UILabel*)label{
    CGRect bounds = [label.text boundingRectWithSize:CGSizeMake(170, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    bounds.size.height = bounds.size.height>40 ? 40:bounds.size.height;
    label.frame = bounds;
}
@end
