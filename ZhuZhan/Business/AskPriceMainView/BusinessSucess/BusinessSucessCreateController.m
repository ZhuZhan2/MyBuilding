//
//  BusinessSucessCreateController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/25.
//
//

#import "BusinessSucessCreateController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface BusinessSucessCreateController ()
@property (nonatomic, strong)UIImageView* imageView;
@property (nonatomic, strong)UILabel* remindLabel;
@property (nonatomic, strong)UIButton* leftBtn;
@property (nonatomic, strong)UIButton* rightBtn;
@end

@implementation BusinessSucessCreateController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.remindLabel];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
}

- (void)leftBtnClicked{
    if ([self.delegate respondsToSelector:@selector(businessSucessCreateControllerLeftBtnClicked)]) {
        [self.delegate businessSucessCreateControllerLeftBtnClicked];
    }
}

- (void)rightBtnClicked{
    if ([self.delegate respondsToSelector:@selector(businessSucessCreateControllerRightBtnClicked)]) {
        [self.delegate businessSucessCreateControllerRightBtnClicked];
    }
}

- (UIImageView *)imageView{
    if (!_imageView) {
        CGFloat widht = 183;
        CGFloat x = (kScreenWidth-widht)/2;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 95+64, widht, 183)];
        _imageView.image = [GetImagePath getImagePath:@"佣金_提交成功"];
    }
    return _imageView;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+15, kScreenWidth, 30)];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.text = @"提交成功";
    }
    return _remindLabel;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 425+64, 128, 37)];
        [_leftBtn setBackgroundImage:[GetImagePath getImagePath:@"佣金_提交成功按钮_我的询价列表"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-25-128, 425+64, 128, 37)];
        [_rightBtn setBackgroundImage:[GetImagePath getImagePath:@"佣金_提交成功按钮_首页"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
@end
