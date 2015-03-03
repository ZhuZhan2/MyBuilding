//
//  ProductViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-2.
//
//

#import "ProductViewController.h"
#import "TMPhotoQuiltViewCell.h"
#import "ProductDetailViewController.h"
#import "ProductModel.h"
#import "EGOImageView.h"
#import "MJRefresh.h"
#import "ConnectionAvailable.h"
#import "ErrorView.h"
#import "LoadingView.h"
#import "NoProductView.h"
@interface ProductViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate,ErrorViewDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property(nonatomic,strong)ErrorView* errorView;
@property(nonatomic,strong)UIActivityIndicatorView* indicatorView;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,strong)NoProductView *noProductView;
@end

@implementation ProductViewController

-(void)dealloc{
    NSLog(@"ProductViewController dealloc");
}

-(void)loadIndicatorView{
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64.5, 320, 568) superView:self.view];
}

-(void)endIndicatorView{
    [self.loadingView.gifView stopGif];
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	  
    //初始化navi
    [self loadNavi];
	//初始化瀑布流视图
    [self loadQtmquitView];
    [self loadIndicatorView];
    startIndex = 0;
    [self firstNetWork];
}

-(void)firstNetWork{
    [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            [qtmquitView reloadData];
            if(showArr.count !=0){
                //初始化刷新视图
                [self.noProductView removeFromSuperview];
                self.noProductView = nil;
                [self setupRefresh];
            }else{
                [self addNoProductView];
            }
            [self endIndicatorView];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } startIndex:0 keyWords:@"" noNetWork:^{
        [self endIndicatorView];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-49-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)addNoProductView{
    if(self.noProductView == nil){
        self.noProductView = [[NoProductView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-49-64)];
        [self.view addSubview:self.noProductView];
    }
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.noProductView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.noProductView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void)loadQtmquitView{
    qtmquitView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-49)];
	qtmquitView.delegate = self;
	qtmquitView.dataSource = self;
	qtmquitView.showsVerticalScrollIndicator=NO;
	[self.view addSubview:qtmquitView];
}

-(void)loadNavi{
    self.title = @"产品";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
}

//=====================================================================
//初始化刷新视图
//=====================================================================
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [qtmquitView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [qtmquitView addFooterWithTarget:self action:@selector(footerRereshing)];
}

//ErrorView的委托方法,点击重载后调用
-(void)reloadView{
    if (self.errorView.superview) {
        [self.errorView removeFromSuperview];
        [self headerRereshing];
    }
}

//头刷新
- (void)headerRereshing
{
    [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        [qtmquitView headerEndRefreshing];
        [self.noProductView headerEndRefreshing];
        if(!error){
            startIndex=0;
            showArr = posts;
            [qtmquitView reloadData];
            if(showArr.count !=0){
                //初始化刷新视图
                [self.noProductView removeFromSuperview];
                self.noProductView = nil;
                [self setupRefresh];
            }else{
                [self addNoProductView];
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } startIndex:0 keyWords:@"" noNetWork:^{
        [qtmquitView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-49-64) superView:self.view reloadBlock:^{
            [self headerRereshing];
        }];
    }];
}

//尾刷新
- (void)footerRereshing
{
    [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        [qtmquitView footerEndRefreshing];
        [self.noProductView footerEndRefreshing];
        if(!error){
            startIndex++;
            [showArr addObjectsFromArray:posts];
            [qtmquitView reloadData];
            if(showArr.count !=0){
                //初始化刷新视图
                [self.noProductView removeFromSuperview];
                self.noProductView = nil;
                [self setupRefresh];
            }else{
                [self addNoProductView];
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } startIndex:startIndex+1 keyWords:@"" noNetWork:^{
        [qtmquitView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-49-64) superView:self.view reloadBlock:^{
            [self footerRereshing];
        }];
    }];
}

//=====================================================================
//TMQuiltViewDataSource,TMQuiltViewDelegate
//=====================================================================

- (CGSize)imageAtIndexPath:(NSIndexPath *)indexPath {
    ProductModel* model=showArr[indexPath.row];
    CGSize size;
    if ([model.a_imageUrl isEqualToString:@""]) {
        size=CGSizeMake(151, 113);
    }else{
    size=CGSizeMake([model.a_imageWidth floatValue]*.5, [model.a_imageHeight floatValue]*.5);
    }
    return size;
    //return CGSizeMake(151, 113);
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [showArr count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"];
    }
    ProductModel *model = showArr[indexPath.row];
    cell.titleLabel.text = model.a_content;
    cell.commentCountLabel.text= model.a_commentNumber;
    cell.imageSize = [self imageAtIndexPath:indexPath];
    BOOL imageExist=model.a_imageUrl&&![model.a_imageUrl isEqualToString:@""];
    NSLog(@"%@",model.a_imageUrl);
    cell.photoView.imageURL = [NSURL URLWithString:imageExist?model.a_imageUrl:@""];
    cell.model = model;
    return cell;
}

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    return [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
    || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight?3:2;
}

//返回cell的高度
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size=[self imageAtIndexPath:indexPath];
    CGFloat scroll=[quiltView cellWidth]/size.width;
    
    ProductModel *model = showArr[indexPath.row];
    BOOL productContentExist=![model.a_content isEqualToString:@""];
    
    return [self imageAtIndexPath:indexPath].height *scroll+(productContentExist?80:30);
}

//选中cell调用的方法
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel* model=showArr[indexPath.row];
    ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithProductModel:model];
    vc.type = @"Product";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
