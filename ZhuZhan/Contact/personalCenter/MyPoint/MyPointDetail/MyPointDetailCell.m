//
//  MyPointDetailCell.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointDetailCell.h"
#import "RKShadowView.h"

@interface MyPointDetailCell ()
@property (nonatomic, strong)UILabel* mainTitleLabel;
@property (nonatomic, strong)UILabel* mainSubTitleLabel;
@property (nonatomic, strong)UILabel* assistMainTitleLabel;
@property (nonatomic, strong)UILabel* assistSubTitleLabel;
@end

@implementation MyPointDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mainTitleLabel];
        [self.contentView addSubview:self.mainSubTitleLabel];
        [self.contentView addSubview:self.assistMainTitleLabel];
        [self.contentView addSubview:self.assistSubTitleLabel];
        
        UIView* sepe = [RKShadowView seperatorLine];
        CGRect frame = sepe.frame;
        frame.origin.y = 59;
        sepe.frame = frame;
        [self.contentView addSubview:sepe];
    }
    return self;
}

- (void)setModel:(MyPointHistoryModel *)model{
    _model = model;
    self.mainTitleLabel.text = @"首次上传头像";
    self.mainSubTitleLabel.text = @"2015-12-23 12：23";
    self.assistMainTitleLabel.text = @"+50";
    self.assistSubTitleLabel.text = @"客服添加";
}

- (UILabel *)mainTitleLabel{
    if (!_mainTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 225, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = RGBCOLOR(51, 51, 51);
        
        _mainTitleLabel = label;
    }
    return _mainTitleLabel;
}

- (UILabel *)mainSubTitleLabel{
    if (!_mainSubTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 34, 225, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = RGBCOLOR(187, 187, 187);
        
        _mainSubTitleLabel = label;
    }
    return _mainSubTitleLabel;
}

- (UILabel *)assistMainTitleLabel{
    if (!_assistMainTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(264, 8, 225, 25)];
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = RGBCOLOR(226, 116, 36);
        
        _assistMainTitleLabel = label;
    }
    return _assistMainTitleLabel;
}

- (UILabel *)assistSubTitleLabel{
    if (!_assistSubTitleLabel) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(264, 31, 225, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = RGBCOLOR(187, 187, 187);
        
        _assistSubTitleLabel = label;
    }
    return _assistSubTitleLabel;
}
@end
