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
#import "CommentModel.h"
#import "ProductModel.h"
#import "EGOImageView.h"
#import "MJRefresh.h"
#import "ConnectionAvailable.h"
#import "ErrorView.h"
@interface ProductViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate,ErrorViewDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property(nonatomic,strong)ErrorView* errorView;
@end

@implementation ProductViewController

-(void)dealloc{
    NSLog(@"ProductViewController dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	  
    //初始化navi
    [self loadNavi];
    
	//初始化瀑布流视图
    [self loadQtmquitView];
    
    startIndex = 0;
    [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            [qtmquitView reloadData];
            
            //初始化刷新视图
            [self setupRefresh];
        }
    } productId:@"" startIndex:startIndex];
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
- (void)setupRefresh
{
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

//无网络时做的操作
-(void)noNetWork{
    if (!self.errorView) {
        self.errorView = [[ErrorView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-49-64)];
    }
    [self.view addSubview:self.errorView];
    self.errorView.delegate=self;
    [qtmquitView headerEndRefreshing];
    [qtmquitView footerEndRefreshing];
}

//头刷新
- (void)headerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [self noNetWork];
    }else{
        startIndex=0;
        [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                showArr = posts;
                [qtmquitView headerEndRefreshing];
                [qtmquitView reloadData];
            }
        } productId:@"" startIndex:startIndex];
    }
}

//尾刷新
- (void)footerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [self noNetWork];
    }else{
        startIndex++;
        [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [showArr addObjectsFromArray:posts];
                [qtmquitView footerEndRefreshing];
                [qtmquitView reloadData];
            }
        } productId:@"" startIndex:startIndex];
    }
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
    
    cell.photoView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_imageUrl]];
    cell.titleLabel.text = model.a_content;
    cell.commentCountLabel.text= model.a_commentNumber;
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
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
