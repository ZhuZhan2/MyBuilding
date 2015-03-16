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
#import "ProductPublishController.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
@interface ProductViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate,ErrorViewDelegate,UISearchBarDelegate,ProductPublishControllerDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property(nonatomic,strong)ErrorView* errorView;
@property(nonatomic,strong)UIActivityIndicatorView* indicatorView;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,strong)NoProductView *noProductView;
@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,strong)NSString *keyWords;
@property(nonatomic,strong)UIButton *closeSearchBtn;
@end

@implementation ProductViewController

-(void)dealloc{
    NSLog(@"ProductViewController dealloc");
}

-(void)loadIndicatorView{
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64.5, 320, kScreenHeight) superView:self.view];
}

-(void)endIndicatorView{
    [self.loadingView.gifView stopGif];
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.keyWords = @"";
    //初始化navi
    [self loadNavi];
    
    [self initSearchView];
    
	//初始化瀑布流视图
    [self loadQtmquitView];
    [self loadIndicatorView];
    startIndex = 0;
    [self firstNetWork];
}

-(void)initSearchView{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 43)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
    [self.view addSubview:self.searchBar];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self getCloseSearchBtn];
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.keyWords = searchBar.text;
    [self removeCloseSearchBtn];
    [self firstNetWork];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.keyWords = @"";
    [self removeCloseSearchBtn];
    [self firstNetWork];
    [self.searchBar setShowsCancelButton:NO animated:YES];
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
    } startIndex:0 keyWords:self.keyWords noNetWork:^{
        [self endIndicatorView];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-49-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)addNoProductView{
    if(self.noProductView == nil){
        self.noProductView = [[NoProductView alloc] initWithFrame:CGRectMake(0, 64+self.searchBar.frame.size.height, 320, kScreenHeight-49-64-self.searchBar.frame.size.height)];
        [self.view addSubview:self.noProductView];
    }
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.noProductView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.noProductView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void)loadQtmquitView{
    qtmquitView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 64+43, 320, kScreenHeight-49-43-64)];
	qtmquitView.delegate = self;
	qtmquitView.dataSource = self;
	qtmquitView.showsVerticalScrollIndicator=NO;
	[self.view addSubview:qtmquitView];
}

-(void)loadNavi{
    self.title = @"产品";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[GetImagePath getImagePath:@"＋"] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 0, 19, 19);
    [btn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
}

-(void)rightBtnClicked{
    if([[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        ProductPublishController* vc=[[ProductPublishController alloc]init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    } startIndex:0 keyWords:self.keyWords noNetWork:^{
        [qtmquitView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-49-64) superView:self.view reloadBlock:^{
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
    } startIndex:startIndex+1 keyWords:self.keyWords noNetWork:^{
        [qtmquitView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-49-64) superView:self.view reloadBlock:^{
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
    cell.nameLabel.text=model.a_name;
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
    
    CGFloat height=0;
    NSString* name=@"产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称";
    name=@"产品名称";
    if (![name isEqualToString:@""]) {
        height+=5;
        CGFloat tempHeight=[name boundingRectWithSize:CGSizeMake([quiltView cellWidth]-10, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nameFont} context:nil].size.height;
        tempHeight=tempHeight>=20?40:20;
        height+=tempHeight;
        height+=5;
    }
    
    if (![model.a_content isEqualToString:@""]) {
         CGFloat tempHeight=[model.a_content boundingRectWithSize:CGSizeMake([quiltView cellWidth]-10, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size.height;
        tempHeight=tempHeight>=18?36:18;
        height+=tempHeight;
        height+=5;
    }
    
   // BOOL productContentExist=![model.a_content isEqualToString:@""];
    
    
    
    return size.height *scroll+height+30;
}

//选中cell调用的方法
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel* model=showArr[indexPath.row];
    ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithProductModel:model];
    vc.type = @"01";
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIImage*)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)getCloseSearchBtn{
    if(self.closeSearchBtn == nil){
        self.closeSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeSearchBtn.frame = qtmquitView.frame;
        [self.closeSearchBtn addTarget:self action:@selector(removeCloseSearchBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.closeSearchBtn];
    }
}

-(void)removeCloseSearchBtn{
    self.keyWords = self.searchBar.text;
    [self.searchBar resignFirstResponder];
    [self.closeSearchBtn removeFromSuperview];
    self.closeSearchBtn = nil;
    [self firstNetWork];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

-(void)successAddProduct{
    startIndex = 0;
    [self firstNetWork];
}
@end
