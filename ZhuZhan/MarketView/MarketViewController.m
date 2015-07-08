//
//  MarketViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import "MarketViewController.h"
#import "AdDataModel.h"
#import "MarketSearchViewController.h"
#import "SearchMaterialViewController.h"
#import "ZWAdView.h"
#import "MarketFlowView.h"
#import "MarkListView.h"
#import "MarketApi.h"
#import "OtherSearchMaterialViewController.h"
#import "MarketPublicListViewController.h"
#import "RequirementDetailViewController.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "BannerImagesModel.h"
#import "MarketWebViewController.h"

#define contentHeight (kScreenHeight==480?431:519)
@interface MarketViewController ()<ZWAdViewDelagate,MarketFlowViewDataSource,MarketFlowViewDelegate,LoginViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)ZWAdView *zwAdView;
@property(nonatomic,strong)MarketFlowView *marketFlowView;
@property(nonatomic,strong)UIView *centerView;
@property(nonatomic,strong)UIImageView *phoneImageView;
@property(nonatomic,strong)UIImageView *homeImageView;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)UIButton *phoneBtn;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic,strong)UIView *demandList;
@property(nonatomic,strong)UIView* loadingView;
@property(nonatomic,strong)UIActivityIndicatorView* activityView;
@property(nonatomic,strong)NSMutableArray *modelsArr;
@property(nonatomic,strong)NSMutableArray *bannerImagesArr;

@property(nonatomic,strong)UIImageView *centerImageView;
@property(nonatomic,strong)UIButton *centerBtn;
@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(237, 237, 237);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 30)];
    //[rightButton setBackgroundImage:[GetImagePath getImagePath:@"项目-首页_03a"] forState:UIControlStateNormal];
    [leftButton setTitle:@"收起" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self.searchView addSubview:self.searchBtn];
    self.navigationItem.titleView = self.searchView;
    
    self.currentPage = 0;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.zwAdView];
    [self.scrollView addSubview:self.centerView];
    [self.centerView addSubview:self.countLabel];
    [self.centerView addSubview:self.marketFlowView];
    [self.centerView addSubview:self.demandList];
    [self.scrollView addSubview:self.phoneImageView];
    [self.scrollView addSubview:self.phoneBtn];
    [self loadList];
    [self loadBannerImages];
    
//    [self.scrollView addSubview:self.centerImageView];
//    [self.scrollView addSubview:self.centerBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequirementList) name:@"reloadRequirementList" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)modelsArr{
    if(!_modelsArr){
        _modelsArr = [NSMutableArray array];
    }
    return _modelsArr;
}

-(NSMutableArray *)bannerImagesArr{
    if(!_bannerImagesArr){
        _bannerImagesArr = [NSMutableArray array];
    }
    return _bannerImagesArr;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, contentHeight)];
        _scrollView.contentSize = CGSizeMake(320, 455);
    }
    return _scrollView;
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        _headImageView.image = [GetImagePath getImagePath:@"index_head"];
    }
    return _headImageView;
}

-(UIImageView *)homeImageView{
    if(!_homeImageView){
        _homeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 21)];
        _homeImageView.image = [GetImagePath getImagePath:@"index_home"];
    }
    return _homeImageView;
}

-(ZWAdView *)zwAdView{
    if(!_zwAdView){
        _zwAdView=[[ZWAdView alloc]initWithFrame:CGRectMake(0, 0,320 , 100)];
        _zwAdView.delegate=self;
        /**广告链接*/
        //AdDataModel * dataModel = [AdDataModel adDataModelWithImageName];
        //_zwAdView.adDataArray=[NSMutableArray arrayWithArray:dataModel.imageNameArray];
        //_zwAdView.pageControlPosition=ZWPageControlPosition_BottomCenter;/**设置圆点的位置*/
        //_zwAdView.hidePageControl=NO;/**设置圆点是否隐藏*/
        _zwAdView.adAutoplay=YES;/**自动播放*/
        _zwAdView.adPeriodTime=4.0;/**时间间隔*/
        _zwAdView.placeImageSource=@"banner_mobile_3";/**设置默认广告*/
        //[_zwAdView loadAdDataThenStart];
    }
    return _zwAdView;
}

/*********************************************************************************/

-(UIView *)centerView{
    if(!_centerView){
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 234)];
        _centerView.backgroundColor = RGBCOLOR(237, 237, 237);
    }
    return _centerView;
}

-(UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:16];
        _countLabel.textColor = RGBCOLOR(51, 51, 51);
        _countLabel.text = @"需求总数0条";
    }
    return _countLabel;
}

-(MarketFlowView *)marketFlowView{
    if(!_marketFlowView){
        _marketFlowView = [[MarketFlowView alloc] initWithFrame:CGRectMake(0, 30, 320, 160)];
        _marketFlowView.backgroundColor = RGBCOLOR(237, 237, 237);
        _marketFlowView.padding = 0.94;//间距
        _marketFlowView.dataSource = self;
        _marketFlowView.delegate =self;
        _marketFlowView.defaultImageView = [[UIImageView alloc] initWithImage:[GetImagePath getImagePath:@"nodata"]];
    }
    return _marketFlowView;
}

-(UIView *)demandList{
    if(!_demandList){
        _demandList = [[UIView alloc] initWithFrame:CGRectMake(0, 196, 320, 39)];
        _demandList.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 39)];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"查看所有需求";
        label.textColor = RGBCOLOR(0, 122, 255);
        [_demandList addSubview:label];
        UIImageView *cutLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        cutLine1.backgroundColor = RGBCOLOR(217, 217, 217);
        [_demandList addSubview:cutLine1];
        UIImageView *cutLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, 320, 1)];
        cutLine2.backgroundColor = RGBCOLOR(217, 217, 217);
        [_demandList addSubview:cutLine2];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = label.frame;
        [btn addTarget:self action:@selector(demandListAction) forControlEvents:UIControlEventTouchUpInside];
        [_demandList addSubview:btn];
    }
    return _demandList;
}

-(UIImageView *)phoneImageView{
    if(!_phoneImageView){
        _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 344, 320, 121)];
        _phoneImageView.image = [GetImagePath getImagePath:@"index_phone"];
    }
    return _phoneImageView;
}

-(UIButton *)phoneBtn{
    if(!_phoneBtn){
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.frame = CGRectMake(18, 390, 283, 49);
        [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}

/*********************************************************************************/

-(UIButton *)searchBtn{
    if(!_searchBtn){
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(0, 0, 254, 28);
        [_searchBtn setBackgroundImage:[GetImagePath getImagePath:@"MarketSearch"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.adjustsImageWhenHighlighted = NO;
    }
    return _searchBtn;
}

-(UIView *)searchView{
    if(!_searchView){
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(47, 26, 254, 28)];
    }
    return _searchView;
}

-(void)leftBtnClick{
    if([self.delegate respondsToSelector:@selector(gotoContactView)]){
        [self.delegate gotoContactView];
    }
}

-(void)searchAction{
    MarketSearchViewController *view = [[MarketSearchViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)phoneBtnAction{
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPhone"]) {
        NSString *telephone = @"tel://4006697262";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephone]];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不能打电话" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
}

//卡片大小
-(CGSize)sizeForPageInFlowView:(MarketFlowView *)flowView{
    return CGSizeMake(272, 160);
}

//卡片个数
- (NSInteger)numberOfPagesInFlowView:(MarketFlowView *)flowView{
    return self.modelsArr.count;
}

//卡片样式
-(UIView *)flowView:(MarketFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    MarkListView *listView = (MarkListView *)[flowView dequeueReusableCell];
    if (!listView) {
        listView = [[MarkListView alloc] initWithFrame:CGRectMake(0, 0, 272, 160)];
    }
    listView.model = self.modelsArr[index];
    return listView;
}

//滚动触发
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(MarketFlowView *)flowView {
    //NSLog(@"Scrolled to page # %d", pageNumber);
    self.currentPage = pageNumber;
}

//重置页面触发
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index{
    MarkListView *listView = (MarkListView *)cell;
    listView.model = self.modelsArr[index];
}

//点击触发
- (void)didSelectItemAtIndex:(NSInteger)index inFlowView:(MarketFlowView *)flowView{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        MarketModel *model = self.modelsArr[index];
        RequirementDetailViewController* vc = [[RequirementDetailViewController alloc] initWithTargetId:model.a_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)demandListAction{
    MarketPublicListViewController *view = [[MarketPublicListViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    if(block){
        block();
    }
}

-(void)reloadRequirementList{
    [self loadList];
}

-(void)loadList{
    [self startLoadingView];
    [MarketApi GetPageRequireListWithBlock:^(NSMutableArray *posts,NSString *total ,NSError *error) {
        if(!error){
            self.countLabel.text = [NSString stringWithFormat:@"需求总数%@条",total];
            self.modelsArr = posts;
            [self.marketFlowView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self stopLoadingView];
    } noNetWork:^{
        [ErrorCode alert];
        [self stopLoadingView];
    }];
}

-(void)loadBannerImages{
    [MarketApi GetBannerImagesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.bannerImagesArr = posts;
            self.zwAdView.adDataArray= self.bannerImagesArr;
            self.zwAdView.pageControlPosition=ZWPageControlPosition_BottomCenter;/**设置圆点的位置*/
            self.zwAdView.hidePageControl=NO;/**设置圆点是否隐藏*/
            if(self.bannerImagesArr.count == 0 || self.bannerImagesArr.count == 1){
                self.zwAdView.adScrollView.scrollEnabled = NO;
            }else{
                self.zwAdView.adScrollView.scrollEnabled = YES;
            }
            [self.zwAdView loadAdDataThenStart];
        }
    } noNetWork:^{
        [ErrorCode alert];
    }];
}

-(UIView *)loadingView{
    if (!_loadingView) {
        _loadingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 234)];
        //_loadingView.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:.5];
        _loadingView.backgroundColor=[UIColor whiteColor];
        self.activityView.center=_loadingView.center;
        [_loadingView addSubview:self.activityView];
    }
    return _loadingView;
}

-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

-(void)startLoadingView{
    [self.activityView startAnimating];
    [self.centerView addSubview:self.loadingView];
}

-(void)stopLoadingView{
    [self.activityView stopAnimating];
    [self.loadingView removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadRequirementList" object:nil];
}

-(void)adView:(ZWAdView *)adView didDeselectAdAtNum:(NSInteger)num{
    BannerImagesModel *model = self.bannerImagesArr[num];
    if(![model.a_webUrl isEqualToString:@""]){
        MarketWebViewController *view = [[MarketWebViewController alloc] init];
        view.webUrl = model.a_webUrl;
        [self.navigationController pushViewController:view animated:YES];
    }
}

/***********************************************************/
//-(UIImageView *)centerImageView{
//    if(!_centerImageView){
//        _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 224)];
//        _centerImageView.image = [GetImagePath getImagePath:@"index_need"];
//    }
//    return _centerImageView;
//}
//
//-(UIButton *)centerBtn{
//    if(!_centerBtn){
//        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _centerBtn.frame = CGRectMake(18, 190, 283, 123);
//        [_centerBtn addTarget:self action:@selector(centerBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _centerBtn;
//}
//
//-(void)centerBtnAction{
//    OtherSearchMaterialViewController *view = [[OtherSearchMaterialViewController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
//}
//
//-(UIImageView *)phoneImageView{
//    if(!_phoneImageView){
//        _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 334, 320, 121)];
//        _phoneImageView.image = [GetImagePath getImagePath:@"index_phone"];
//    }
//    return _phoneImageView;
//}
//
//-(UIButton *)phoneBtn{
//    if(!_phoneBtn){
//        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _phoneBtn.frame = CGRectMake(18, 380, 283, 49);
//        [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _phoneBtn;
//}
@end
