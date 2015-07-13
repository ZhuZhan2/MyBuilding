//
//  SignViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/13.
//
//

#import "SignViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MyPointApi.h"
#import "PointDetailModel.h"

@interface SignViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *pointTitleLabel;
@property(nonatomic,strong)UILabel *pointLabel;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *signDayLabel;
@property(nonatomic,strong)UILabel *signPointLabel;
@property(nonatomic,strong)UIButton *signBtn;
@property(nonatomic,strong)PointDetailModel *pointModel;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    [self getMyPoint];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.pointTitleLabel];
    [self.scrollView addSubview:self.pointLabel];
    [self.scrollView addSubview:self.bgImageView];
    [self.scrollView addSubview:self.signDayLabel];
    [self.scrollView addSubview:self.signPointLabel];
    [self.scrollView addSubview:self.signBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    self.title = @"签到";
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)getMyPoint{
    [MyPointApi GetPointDetailWithBlock:^(PointDetailModel *model, NSError *error) {
        if(!error){
            self.pointModel = model;
            if([self.pointModel.a_status isEqualToString:@"00"]){
                if(self.pointModel.a_hasSign){
                    [_signBtn setImage:[GetImagePath getImagePath:@"poing_signEnd"] forState:UIControlStateNormal];
                    self.signBtn.enabled = NO;
                }else{
                    [_signBtn setImage:[GetImagePath getImagePath:@"point_sign"] forState:UIControlStateNormal];
                    self.signBtn.enabled = YES;
                }
            }else{
                [_signBtn setImage:[GetImagePath getImagePath:@"point_noSign"] forState:
                 UIControlStateNormal];
                self.signBtn.enabled = NO;
            }
            self.pointLabel.text = [NSString stringWithFormat:@"%d",self.pointModel.a_points];
            self.signDayLabel.text = [NSString stringWithFormat:@"你已连续签到%@天",self.pointModel.a_signDays];
            self.signPointLabel.text = [NSString stringWithFormat:@"%@",self.pointModel.a_toDayGet];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } noNetWork:^{
        [ErrorCode alert];
    }];
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.contentSize = CGSizeMake(320, 504);
    }
    return _scrollView;
}

-(UILabel *)pointTitleLabel{
    if(!_pointTitleLabel){
        _pointTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, 320, 20)];
        _pointTitleLabel.textAlignment = NSTextAlignmentCenter;
        _pointTitleLabel.text = @"我的积分";
        _pointTitleLabel.font = [UIFont systemFontOfSize:15];
        _pointTitleLabel.textColor = RGBCOLOR(51, 51, 51);
    }
    return _pointTitleLabel;
}

-(UILabel *)pointLabel{
    if(!_pointLabel){
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 52, 320, 30)];
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        _pointLabel.text = @"";
        _pointLabel.font = [UIFont systemFontOfSize:25];
        _pointLabel.textColor = RGBCOLOR(218, 84, 22);
    }
    return _pointLabel;
}

-(UIImageView *)bgImageView{
    if(!_bgImageView){
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(54.5, 95, 211, 250)];
        _bgImageView.image = [GetImagePath getImagePath:@"point_signPig"];
    }
    return _bgImageView;
}

-(UILabel *)signDayLabel{
    if(!_signDayLabel){
        _signDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 368, 320, 20)];
        _signDayLabel.textAlignment = NSTextAlignmentCenter;
        _signDayLabel.font = [UIFont systemFontOfSize:15];
        _signDayLabel.textColor = RGBCOLOR(38, 38, 38);
        _signDayLabel.text = @"你已连续签到0天";
    }
    return _signDayLabel;
}

-(UILabel *)signPointLabel{
    if(!_signPointLabel){
        _signPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 388, 320, 20)];
        _signPointLabel.textAlignment = NSTextAlignmentCenter;
        _signPointLabel.font = [UIFont systemFontOfSize:15];
        _signPointLabel.textColor = RGBCOLOR(38, 38, 38);
        _signPointLabel.text = @"今天签到可获得0积分";
    }
    return _signPointLabel;
}

-(UIButton *)signBtn{
    if(!_signBtn){
        _signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _signBtn.frame = CGRectMake(62.5, 426, 195, 45);
        [_signBtn setImage:[GetImagePath getImagePath:@"point_sign"] forState:UIControlStateNormal];
        [_signBtn addTarget:self action:@selector(signBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signBtn;
}

-(void)signBtnAction{
    [MyPointApi SignWithBlock:^(int todayPoint, NSError *error) {
        if(!error){
            NSLog(@"todayPoint===> %d",todayPoint);
            [self getMyPoint];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"newPoint" object:nil];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } noNetWork:^{
        [ErrorCode alert];
    }];
}
@end
