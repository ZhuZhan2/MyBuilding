//
//  MyPointDetailView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointDetailView.h"

@interface MyPointDetailView()
@property (nonatomic, copy)NSString* mainTitle;
@property (nonatomic, copy)NSString* subTitle;
@end

@implementation MyPointDetailView
+ (MyPointDetailView *)myPointDetailViewWithMainTitle:(NSString *)mainTitle subTitle:(NSString *)subTitle{
    MyPointDetailView* view = [[MyPointDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view.mainTitle = mainTitle;
    view.subTitle = subTitle;
    [view setUp];
    return view;
}

- (void)setUp{
    [self addSubview:self.mainTitleLabel];
    [self addSubview:self.subTitleLabel];
    
    CGRect frame = self.mainTitleLabel.frame;
    frame.origin = CGPointMake(15, 15);
    self.mainTitleLabel.frame = frame;
    
    frame = self.subTitleLabel.frame;
    frame.origin = CGPointMake(105, 15);
    self.subTitleLabel.frame = frame;
}

- (UILabel *)mainTitleLabel{
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _mainTitleLabel.font = [UIFont systemFontOfSize:15];
        _mainTitleLabel.textColor = RGBCOLOR(51, 51, 51);
        _mainTitleLabel.text = self.mainTitle;
    }
    return _mainTitleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _subTitleLabel.text = self.subTitle;
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.font = [UIFont systemFontOfSize:25];
        _subTitleLabel.textColor = RGBCOLOR(226, 116, 36);
    }
    return _subTitleLabel;
}

- (void)setBottomView:(UIView *)bottomView{
    _bottomView = bottomView;
    CGRect frame = bottomView.frame;
    frame.origin.y = CGRectGetHeight(self.frame);
    bottomView.frame = frame;
    [self addSubview:bottomView];
    
    frame = self.frame;
    frame.size.height += CGRectGetHeight(bottomView.frame);
    self.frame = frame;
}
@end
