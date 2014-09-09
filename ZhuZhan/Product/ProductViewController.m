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
@interface ProductViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation ProductViewController

-(void)dealloc{
    NSLog(@"ProductViewController dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"产品";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
	qtmquitView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-49)];
	qtmquitView.delegate = self;
	qtmquitView.dataSource = self;
	qtmquitView.showsVerticalScrollIndicator=NO;
	[self.view addSubview:qtmquitView];
    //[self createHeaderView];
	//[self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
    
    startIndex = 0;
    [ProductModel GetProductInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            NSLog(@"=====%@",posts);
            showArr = posts;
            //NSLog(@"%@",showArr);
            
            for (int i=0; i<showArr.count; i++) {
                ProductModel* model=showArr[i];
                NSLog(@"%d,%@",i,model.a_content);
            }

            [qtmquitView reloadData];
        }
    } productId:@"" startIndex:startIndex];
    
}

//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.frame.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[qtmquitView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)testFinishedLoadData{
	
    [self finishReloadingData];
    [self setFooterView];
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
        [self setFooterView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)setFooterView{
	//    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(qtmquitView.contentSize.height, qtmquitView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              qtmquitView.frame.size.width,
                                              self.view.bounds.size.height);
    }else
	{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         qtmquitView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [qtmquitView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
	{
        [_refreshFooterView refreshLastUpdatedDate];
    }
}


-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
	{
        // pull down to refresh data
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter)
	{
        // pull up to load more data
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
	
	// overide, the actual loading data operation is done in the subclass
}

//刷新调用的方法
-(void)refreshView
{
	NSLog(@"刷新完成");
    [self testFinishedLoadData];
	
}
//加载调用的方法
-(void)getNextPageView
{
    NSLog(@"getNextPageView");
	for(int i = 0; i < 10; i++) {
		[_images addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
	}
	[qtmquitView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
	
	[self beginToReloadData:aRefreshPos];
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSMutableArray *)images
//{
//    NSLog(@"22222");
//    if (!_images)
//	{
//        _images=[NSMutableArray array];
//        //图片源
//        NSArray* names=@[@"+项目-首页_21a.png",@"地图搜索1_09.png",@"+项目-首页_21a.png",@"语音搜索_01.png",@"地图搜索1_09.png",@"语音搜索_01.png",@"+项目-首页_21a.png",@"语音搜索_01.png",@"+项目-首页_21a.png"];
//        for(int i = 0; i < names.count; i++) {
//            [_images addObject:names[i]];
//        }
//    }
//    return _images;
//}


- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    ProductModel *model = showArr[indexPath.row];
    EGOImageView *imageview = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"bg001"]];
    imageview.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_imageUrl]];
    //return [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
    return imageview.image;
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
    
    //cell.photoView.image = [self imageAtIndexPath:indexPath];
    cell.photoView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,model.a_imageUrl]];

    cell.titleLabel.text = model.a_content;
    cell.commentCountLabel.text= model.a_commentNumber;
    return cell;
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {

    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
	{
        return 3;
    } else {
        return 2;
    }
}

//返回cell的高度
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size=[self imageAtIndexPath:indexPath].size;
    CGFloat scroll=[quiltView cellWidth]/size.width;
    
    return [self imageAtIndexPath:indexPath].size.height *scroll+100;// / [self quiltViewNumberOfColumns:quiltView];
}

//选中cell调用的方法
- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"index:%d",indexPath.row);
    NSMutableDictionary* dataDic=[[NSMutableDictionary alloc]init];
    [dataDic setObject:[UIImage imageNamed:@"123.png"] forKey:@"productImage"];
    [dataDic setObject:@"按时打算将扩大时间的骄傲啥都怕时间的拉伸麦德龙；爱似麻烦；阿三方面了；按实际发牢骚；房间爱丽丝；房间爱；房间爱死了；房间爱；房间爱；房间爱；发觉是否；拉伸" forKey:@"productText"];
    
    NSMutableArray* comments=[[NSMutableArray alloc]init];
    for (int i=0; i<25; i++) {
        CommentModel* model=[[CommentModel alloc]init];
        model.a_name = [NSString stringWithFormat:@"name=%d",i];
        //model.a_time = [NSString stringWithFormat:@"%d-%d %d:%d",i,i,i,i];
        NSString* content = [NSString stringWithFormat:@"content=%d",i];
        model.a_content=content;
        for (int k=0; k<i; k++) {
            model.a_content=[NSString stringWithFormat:@"%@%@",model.a_content,content];
        }
        model.a_imageUrl = [NSString stringWithFormat:@"imageUrl=%d",i];
        [comments addObject:model];
    }
    
    [dataDic setObject:comments forKey:@"comments"];
    
    ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithImage:dataDic[@"productImage"] text:dataDic[@"productText"] productID:[showArr[indexPath.row] a_id]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
