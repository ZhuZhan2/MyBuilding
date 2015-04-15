//
//  CommissionBaseViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "CommissionBaseViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
@interface CommissionBaseViewController ()
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@property (nonatomic)BOOL isMainView;
@end

@implementation CommissionBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightBtnWithImage:(UIImage*)image{
    if (!_rightBtn) {
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    }
    [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)setRightBtnWithText:(NSString*)text{
    if (!_rightBtn) {
        UIFont* font=[UIFont systemFontOfSize:15];
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [text boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width, 20)];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font=font;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    }
    [_rightBtn setTitle:text forState:UIControlStateNormal];
}

-(void)rightBtnClicked{
    
}

-(void)setLeftBtnWithImage:(UIImage*)image{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    }else{
        [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

-(void)setLeftBtnWithText:(NSString*)text{
    if (!_leftBtn) {
        UIFont* font=[UIFont systemFontOfSize:15];
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [text boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width, 20)];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font=font;
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    }
    [_leftBtn setTitle:text forState:UIControlStateNormal];
}

-(void)leftBtnClicked{
    if (self.leftBtnIsBack) {
        if (self.needAnimaiton) {
            [self addAnimation];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)addAnimation{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!self.isMainView) return;
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isMainView) return;
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}
@end
