//
//  RequirementCategoryView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementCategoryView.h"

@interface RequirementCategoryView ()
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UIButton* assistView;
@end

@implementation RequirementCategoryView
- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.assistView];
    }
    return self;
}

- (void)setTitle:(NSString *)title{    
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth, CGRectGetHeight(self.frame))];
        _titleLabel.textColor = BlueColor;
    }
    return _titleLabel;
}

- (UIButton *)assistView{
    if (!_assistView) {
        _assistView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 82, 29)];
        [_assistView setBackgroundImage:[GetImagePath getImagePath:@"touchTA"] forState:UIControlStateNormal];
        _assistView.center = CGPointMake(260, 20);
        _assistView.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _assistView;
}
@end
