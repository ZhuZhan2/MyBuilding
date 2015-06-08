//
//  SingleCategoryView.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "SingleCategoryView.h"

@interface SingleCategoryView ()
@property (nonatomic, strong)UILabel* categoryLabel;
@end

@implementation SingleCategoryView
+ (SingleCategoryView *)singleCategoryViewWithCategory:(NSString *)category width:(CGFloat)width height:(CGFloat)height{
    SingleCategoryView* singleCategoryView = [[SingleCategoryView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [singleCategoryView setUpWithText:category];
    return singleCategoryView;
}

- (void)setUpWithText:(NSString*)text{
    self.text = text;
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:16];
    self.layer.cornerRadius = 3;
    self.layer.borderColor = RGBCOLOR(150, 150, 150).CGColor;
    self.layer.masksToBounds = YES;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
    [self addGestureRecognizer:tap];
    
    self.isSelected = NO;
}

- (void)clicked{
    if ([self.delegate respondsToSelector:@selector(singleCategoryViewClicked:)]) {
        [self.delegate singleCategoryViewClicked:self];
    }
}

- (void)setSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.backgroundColor = isSelected?BlueColor:[UIColor whiteColor];
    self.textColor = isSelected?[UIColor whiteColor]:RGBCOLOR(150, 150, 150);
    self.layer.borderWidth = isSelected?0:0.5;
}
@end
