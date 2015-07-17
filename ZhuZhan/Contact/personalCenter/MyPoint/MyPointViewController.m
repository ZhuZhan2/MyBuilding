//
//  MyPointViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointViewController.h"
#import "MyPointDetailViewController.h"
#import "MyPointTopView.h"
#import "MyPointApi.h"
#import "PointDetailModel.h"
#import "PointRuleViewController.h"
#import "MyPointContentView.h"

@interface MyPointViewController ()<MyPointTopViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)MyPointTopView *myPointTopView;
@property(nonatomic,strong)PointDetailModel *pointModel;
@property(nonatomic,strong)MyPointContentView *myPointContentView;
@end

@implementation MyPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavi];
    [self getMyPoint];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.myPointTopView];
    [self.scrollView addSubview:self.myPointContentView];
}

/**
 *  导航栏设置
 */
- (void)initNavi{
    self.title = @"我的积分";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

/**
 *  获取积分详情
 */
-(void)getMyPoint{
    [MyPointApi GetPointDetailWithBlock:^(PointDetailModel *model, NSError *error) {
        if(!error){
            self.pointModel = model;
            [self.myPointTopView setPoint:[NSString stringWithFormat:@"%d",self.pointModel.a_points]];
            [self.myPointTopView setStatus:self.pointModel.a_status];
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

-(MyPointTopView *)myPointTopView{
    if(!_myPointTopView){
        _myPointTopView = [[MyPointTopView alloc] initWithFrame:CGRectMake(0, 64, 320, 160)];
        _myPointTopView.delegate = self;
    }
    return _myPointTopView;
}

-(MyPointContentView *)myPointContentView{
    if(!_myPointContentView){
        _myPointContentView = [[MyPointContentView alloc] initWithFrame:CGRectMake(0, 224, 320, 200)];
    }
    return _myPointContentView;
}

-(void)gotoPointDetailView:(NSInteger)tag{
    switch (tag) {
        case 0:{
            MyPointDetailViewController* vc = [[MyPointDetailViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            PointRuleViewController* vc = [[PointRuleViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
