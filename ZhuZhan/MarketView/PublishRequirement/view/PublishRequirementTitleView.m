//
//  PublishRequirementTitleView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "PublishRequirementTitleView.h"

@interface PublishRequirementTitleView ()
@property (nonatomic, strong)UIImageView* imageView;
@property (nonatomic, strong)UILabel* titleLabel;
@end

@implementation PublishRequirementTitleView
+ (PublishRequirementTitleView *)titleViewWithImageName:(NSString *)imageName title:(NSString *)title{
    PublishRequirementTitleView* view = [[PublishRequirementTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [view setUpWithImageName:imageName title:title];
    return view;
}

- (void)setUpWithImageName:(NSString *)imageName title:(NSString *)title{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    self.imageView.image = [GetImagePath getImagePath:imageName];
    self.titleLabel.text = title;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8.5, 23, 23)];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 250, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}
@end
