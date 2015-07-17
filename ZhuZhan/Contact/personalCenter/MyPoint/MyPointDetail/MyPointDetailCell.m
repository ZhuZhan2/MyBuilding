//
//  MyPointDetailCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointDetailCell.h"
#import "RKShadowView.h"
#import "RKViewFactory.h"
@interface MyPointDetailCell ()
@property (nonatomic, strong)UILabel* mainTitleLabel;
@property (nonatomic, strong)UILabel* mainSubTitleLabel;
@property (nonatomic, strong)UILabel* assistMainTitleLabel;
@property (nonatomic, strong)UILabel* assistSubTitleLabel;

@property (nonatomic, strong)UIView* sepaLine;
@end

@implementation MyPointDetailCell

+ (CGFloat)carculateModel:(MyPointHistoryModel*)model{
    CGFloat height = 35;
    if (![model.a_reason isEqualToString:@""]) {
        height += [RKViewFactory autoLabelWithMaxWidth:290 font:[UIFont systemFontOfSize:13] content:model.a_reason];
        height += 3;
    }
    
    height += 17;
    height += 5;
    height += 1;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mainTitleLabel];
        [self.contentView addSubview:self.mainSubTitleLabel];
        [self.contentView addSubview:self.assistMainTitleLabel];
        [self.contentView addSubview:self.assistSubTitleLabel];
        
        self.sepaLine = [RKShadowView seperatorLine];
        [self.contentView addSubview:self.sepaLine];
    }
    return self;
}

- (void)setModel:(MyPointHistoryModel *)model{
    _model = model;
    self.mainTitleLabel.text = model.a_sourceCn;
    NSString* time = model.a_createdTime;
    NSString* formatTime = [time substringToIndex:time.length-3];
    self.mainSubTitleLabel.text = formatTime;
    BOOL isAdd = [model.a_action isEqualToString:@"00"];
    self.assistMainTitleLabel.text = [NSString stringWithFormat:isAdd?@"+%@":@"-%@",model.a_points];
    self.assistMainTitleLabel.textColor = isAdd?RGBCOLOR(226, 116, 36):RGBCOLOR(161, 161, 161);
    self.assistSubTitleLabel.text = model.a_reason;
    
    [self reloadView];
}

- (void)reloadView{
    [RKViewFactory autoLabel:self.assistSubTitleLabel maxWidth:290];

    CGRect frame = self.mainSubTitleLabel.frame;
    CGFloat extraHeight = [self.model.a_reason isEqualToString:@""]?0:3;
    frame.origin.y = CGRectGetMaxY(self.assistSubTitleLabel.frame) + extraHeight;
    self.mainSubTitleLabel.frame = frame;
    
    frame = self.sepaLine.frame;
    frame.origin.y = CGRectGetMaxY(self.mainSubTitleLabel.frame) + 5;
    self.sepaLine.frame = frame;
}

- (UILabel *)mainTitleLabel{
    if (!_mainTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 140, 20)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = RGBCOLOR(51, 51, 51);

        _mainTitleLabel = label;
    }
    return _mainTitleLabel;
}

- (UILabel *)mainSubTitleLabel{
    if (!_mainSubTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 225, 17)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = RGBCOLOR(187, 187, 187);
        
        _mainSubTitleLabel = label;
    }
    return _mainSubTitleLabel;
}

- (UILabel *)assistMainTitleLabel{
    if (!_assistMainTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(155, 8, 150, 25)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:21];
        label.textColor = RGBCOLOR(226, 116, 36);
        
        _assistMainTitleLabel = label;
    }
    return _assistMainTitleLabel;
}

- (UILabel *)assistSubTitleLabel{
    if (!_assistSubTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 0, 0)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = RGBCOLOR(187, 187, 187);
        
        _assistSubTitleLabel = label;
    }
    return _assistSubTitleLabel;
}
@end
