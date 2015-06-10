//
//  MyMarketViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/10.
//
//

#import "MyMarketViewController.h"
#import "MarketPopView.h"
#import "MarketListSearchViewController.h"
#import "RequirementDetailViewController.h"
#import "PublishRequirementViewController.h"
#import "RKStageChooseView.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"

@interface MyMarketViewController ()<RKStageChooseViewDelegate>
@property(nonatomic,strong)NSString *requireType;
@property(nonatomic,strong)MarketPopView *popView;
@property(nonatomic,strong)RKStageChooseView *stageChooseView;
@end

@implementation MyMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav];
    [self initStageChooseViewWithStages:@[@"公开需求",@"客服需求"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 40, 20);
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    UIButton *screeningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screeningBtn.frame = CGRectMake(0, 0, 40, 20);
    screeningBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [screeningBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screeningBtn addTarget:self action:@selector(screeningBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *screeningItem = [[UIBarButtonItem alloc] initWithCustomView:screeningBtn];
    
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 40, 20);
    releaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(releaseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseItem = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
    self.navigationItem.rightBarButtonItems = @[releaseItem,screeningItem,searchItem];
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

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBtnAction{
    MarketListSearchViewController *searchView = [[MarketListSearchViewController alloc] init];
    searchView.isPublic = YES;
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)screeningBtnAction{
    [self.view.window addSubview:self.popView];
}

-(void)releaseBtnAction{
    PublishRequirementViewController* vc = [[PublishRequirementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)closePopView{
    [self.popView removeFromSuperview];
    self.popView = nil;
}

-(void)selectIndex:(NSInteger)index{
    [self.popView removeFromSuperview];
    self.popView = nil;
    switch (index) {
        case 0:
            //全部
            self.requireType = @"";
            break;
        case 1:
            //找项目
            self.requireType = @"01";
            break;
        case 2:
            //找材料
            self.requireType = @"02";
            break;
        case 3:
            //找合作
            self.requireType = @"04";
            break;
        case 4:
            //找关系
            self.requireType = @"03";
            break;
        case 5:
            //其他
            self.requireType = @"05";
            break;
        default:
            break;
    }
    //[self loadList];
}

-(void)initStageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor{
    self.stageChooseView=[RKStageChooseView stageChooseViewWithStages:
                          stages numbers:numbers delegate:self underLineIsWhole:underLineIsWhole normalColor:normalColor highlightColor:highlightColor];
    CGRect frame=self.stageChooseView.frame;
    frame.origin=CGPointMake(0, 64);
    self.stageChooseView.frame=frame;
    [self.view addSubview:self.stageChooseView];
}
@end
