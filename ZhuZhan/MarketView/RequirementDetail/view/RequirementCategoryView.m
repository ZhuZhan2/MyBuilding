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
@property (nonatomic, strong)UIView* assistView;
@end

@implementation RequirementCategoryView
- (void)setTitle:(NSString *)title assistView:(UIView *)assistView{
    [self.assistView removeFromSuperview];
    
    self.titleLabel.text = title;
    
    self.assistView = assistView;
    [self addSubview:self.assistView];
    self.assistView.center = CGPointMake(265, 20);
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame))];
    }
    return _titleLabel;
}

- (UIView *)assistView{
    if (!_assistView) {
        _assistView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _assistView;
}
@end
