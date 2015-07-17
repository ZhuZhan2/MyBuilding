//
//  MapSearchViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/7.
//
//

#import "MapSearchViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import <MapKit/MapKit.h>
#import "projectApi.h"
#import "projectModel.h"
#import "MapContentView.h"
#import "ProgramDetailViewController.h"

@interface MapSearchViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,LocationErrorViewDelegate,MapContentViewDelegate,LoginViewDelegate>{
    CLLocationCoordinate2D _testLocation;//测试的位置(经纬度)
}
@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong)BMKGeoCodeSearch* geocodesearch;
@property(nonatomic,strong)BMKPointAnnotation* annotationPoint;
@property(nonatomic,strong)BMKPolygon* polygon;
@property(nonatomic,strong)NSArray *numberArr;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)NSMutableArray *coordinates;
@property(nonatomic)BOOL isSelect;
@property(nonatomic)BOOL isDrawing;
@property(nonatomic)BOOL isNext;
@property(nonatomic,strong)UIView *btnView;
@property(nonatomic,strong)UIButton *drawBtn;
@property(nonatomic,strong)UIButton* nextBtn;
@property(nonatomic,strong)UIButton* lastBtn;
@property(nonatomic,strong)UIImageView *imageView;//绘画层
@property(nonatomic)CGMutablePathRef pathRef;//手指画线的Path
@property(nonatomic)CLLocationCoordinate2D centerLocation;
@property(nonatomic)CLLocationDistance dis;
@property(nonatomic)CGPoint locationConverToImage;//存储转换测试位置的CGPoint
@property(nonatomic)int startIndex;
@property(nonatomic)int allCount;
@property(nonatomic)int tempStartIndex;
@property(nonatomic)int pageCount;
@property(nonatomic)int topCount;
@property(nonatomic,strong)LocationErrorView *errorView;
@property(nonatomic,strong)MapContentView *mapContent;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *topBgView;
@end

@implementation MapSearchViewController
int j;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    j=0;
    self.startIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    [self.view addSubview:self.mapView];
    [self.locService startUserLocationService];
    [self.view addSubview:self.btnView];
    [self.btnView addSubview:self.drawBtn];
    [self.btnView addSubview:self.nextBtn];
    [self.btnView addSubview:self.lastBtn];
    [self isLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
    self.geocodesearch.delegate = self;
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
    self.geocodesearch.delegate = nil;
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

- (void)dealloc {
    if (self.mapView) {
        self.mapView = nil;
    }
    
    if (self.geocodesearch != nil) {
        self.geocodesearch = nil;
    }
}

-(void)initNav{
    self.title = @"地图搜索";
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)leftBtnClick{//退出到前一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

-(BMKMapView *)mapView{
    if(!_mapView){
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)];
        _mapView.zoomEnabled = YES;//允许Zoom
        _mapView.scrollEnabled = YES;//允许Scroll
        _mapView.mapType = BMKMapTypeStandard;//地图类型为标准，可以为卫星，可以开启或关闭交通
        [_mapView setZoomLevel:15];
    }
    return _mapView;
}

-(BMKLocationService *)locService{
    if(!_locService){
        _locService = [[BMKLocationService alloc]init];
    }
    return _locService;
}

-(BMKGeoCodeSearch *)geocodesearch{
    if(!_geocodesearch){
        _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    }
    return _geocodesearch;
}

-(NSArray *)numberArr{
    if(!_numberArr){
        _numberArr = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    }
    return _numberArr;
}

-(NSMutableArray *)showArr{
    if(!_showArr){
        _showArr = [[NSMutableArray alloc] init];
    }
    return _showArr;
}

-(NSMutableArray *)coordinates{
    if(!_coordinates){
        _coordinates = [[NSMutableArray alloc] init];
    }
    return _coordinates;
}

-(UIView *)btnView{
    if(!_btnView){
        _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, 66, 220)];
    }
    return _btnView;
}

-(UIButton *)drawBtn{
    if(!_drawBtn){
        _drawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _drawBtn.frame = CGRectMake(10,20, 40, 40);
        [_drawBtn setBackgroundImage:[GetImagePath getImagePath:@"mapsearch-1"] forState:UIControlStateNormal];
        [_drawBtn addTarget:self action:@selector(drawFunction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drawBtn;
}

-(UIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(10,80, 40, 40);
        [_nextBtn setBackgroundImage:[GetImagePath getImagePath:@"项目地图搜索01"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.enabled=NO;
    }
    return _nextBtn;
}

-(UIButton *)lastBtn{
    if(!_lastBtn){
        _lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lastBtn.frame = CGRectMake(10,140, 40, 40);
        [_lastBtn setBackgroundImage:[GetImagePath getImagePath:@"项目地图搜索02"] forState:UIControlStateNormal];
        [_lastBtn addTarget:self action:@selector(lastPage) forControlEvents:UIControlEventTouchUpInside];
        _lastBtn.enabled=NO;
    }
    return _lastBtn;
}

-(UIView *)topBgView{
    if(!_topBgView){
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320,40)];
        [_topBgView setBackgroundColor:[UIColor grayColor]];
        _topBgView.alpha = 0.5;
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 69.5, 160, 30)];
        countLabel.text = [NSString stringWithFormat:@"%d条结果",self.topCount];
        countLabel.textColor = [UIColor blackColor];
        countLabel.textAlignment = NSTextAlignmentCenter;
        [_topBgView addSubview:countLabel];
    }
    return _topBgView;
}

-(LocationErrorView *)errorView{
    if(!_errorView){
        _errorView = [[LocationErrorView alloc] initWithFrame:self.view.frame];
        _errorView.delegate = self;
    }
    return _errorView;
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //[_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (self.mapView) {
        self.mapView.region = region;
        NSLog(@"当前的坐标  维度:%f,经度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        //_mapView.showsUserLocation = YES;//显示定位图层
        [self.mapView updateLocationData:userLocation];
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        NSLog(@"%f",pt.latitude);
        BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag){
            NSLog(@"反geo检索发送成功");
        }else{
            NSLog(@"反geo检索发送失败");
        }
        [self.locService stopUserLocationService];
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    [self.view addSubview:self.errorView];
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    self.annotationPoint = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = result.location.latitude;
    coor.longitude = result.location.longitude;
    _testLocation.latitude=result.location.latitude;//设定测试点的坐标是当前位置
    _testLocation.longitude=result.location.longitude;
    self.annotationPoint.coordinate = coor;
    self.annotationPoint.title = result.address;
    [self.mapView addAnnotation:self.annotationPoint];
    [self.mapView setZoomLevel:14];
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = [NSString stringWithFormat:@"xidanMark%d",j];
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        [annotationView setImage:[GetImagePath getImagePath:@"地图搜索1_09"]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 28.5, 30)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:[self.numberArr objectAtIndex:j] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.tag = j;
        [btn addTarget:self action:@selector(showContentView:) forControlEvents:UIControlEventTouchUpInside];
        [annotationView addSubview:btn];
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        annotationView.tag = j;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    if(self.showArr.count !=0){
        annotationView.canShowCallout = NO;
    }else{
        annotationView.canShowCallout = YES;
    }
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    j++;
    return annotationView;
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =3.5;
        //polygonView.lineDash = (overlay == self.polygon);
        return polygonView;
    }
    return nil;
}

-(void)showContentView:(UIButton *)button{
    if(self.showArr.count !=0){
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64)];
        [self.bgView setBackgroundColor:[UIColor clearColor]];
        self.bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *bgViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [bgViewtapGestureRecognizer addTarget:self action:@selector(closeBgview)];
        [bgViewtapGestureRecognizer setNumberOfTapsRequired:1];
        [bgViewtapGestureRecognizer setNumberOfTouchesRequired:1];
        [self.bgView addGestureRecognizer:bgViewtapGestureRecognizer];
        [self.view addSubview:self.bgView];
        projectModel *model = [self.showArr objectAtIndex:button.tag];
        self.mapContent = [[MapContentView alloc] initWithFrame:CGRectMake(0, kScreenHeight, 320, 190) model:model number:[self.numberArr objectAtIndex:button.tag] index:button.tag];
        self.mapContent.delegate = self;
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoProgramDetailView:)];
        [self.mapContent addGestureRecognizer:tap];
        self.mapContent.tag=button.tag;
        self.mapContent.userInteractionEnabled = YES;
        [self.view addSubview:self.mapContent];
        [UIView animateWithDuration:0.5 animations:^{
            self.mapContent.frame = CGRectMake(0, kScreenHeight-190, 611, 260);
        }];
    }else{
        if(!self.isSelect){
            [_mapView selectAnnotation:self.annotationPoint animated:YES];
            self.isSelect = YES;
        }else{
            [_mapView deselectAnnotation:self.annotationPoint animated:YES];
            self.isSelect = NO;
        }
        //imageView.userInteractionEnabled = NO;
    }
}

-(void)closeBgview{
    [self.bgView removeFromSuperview];
    self.bgView=nil;
    [UIView animateWithDuration:0.5 animations:^{
        self.mapContent.frame = CGRectMake(0, kScreenHeight, 611, 260);
        [self.mapContent removeFromSuperview];
        self.mapContent = nil;
    }];
}

-(void)gotoProgramDetailView:(UITapGestureRecognizer*)tap{
    projectModel *model = [self.showArr objectAtIndex:tap.view.tag];
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    vc.projectId=model.a_id;
    vc.isFocused = model.isFocused;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)nextPage{
    if (!self.nextBtn.enabled) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil]show];
        self.pageCount++;
        [self judgeBtnEnable];
        return;
    }
    j = 0;
    [self.showArr removeAllObjects];
    NSArray *annArray = [[NSArray alloc]initWithArray:self.mapView.annotations];
    [_mapView removeAnnotations: annArray];
    self.annotationPoint = nil;
    [self getMapSearch:self.centerLocation startIndex:1 dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
}

-(void)lastPage{
    j = 0;
    [self.showArr removeAllObjects];
    NSArray *annArray = [[NSArray alloc]initWithArray:self.mapView.annotations];
    [_mapView removeAnnotations: annArray];
    self.annotationPoint = nil;
    [self getMapSearch:self.centerLocation startIndex:0 dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
}

-(void)drawFunction{
    j=0;
    if(self.imageView == nil){
        [self.showArr removeAllObjects];
        [self.coordinates removeAllObjects];
        [self.topBgView removeFromSuperview];
        self.topBgView = nil;
        self.topCount = 0;
        self.imageView=[[UIImageView alloc] initWithFrame:self.mapView.frame];
        [self.imageView setImage:[GetImagePath getImagePath:@"地图搜索_02"]];
        self.imageView.userInteractionEnabled=YES;
        [self.view insertSubview:self.imageView atIndex:1];
        self.isDrawing = YES;
        UIGraphicsBeginImageContext(self.imageView.frame.size);
        [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 50, 79, 133, 1.0);
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4);
        [self removeAnnotationsOnTheMap];
    }else{
        self.isDrawing = NO;
        [self.imageView removeFromSuperview];
        self.imageView = nil;
        [self.view addSubview:self.topBgView];
    }
}

-(void)removeAnnotationsOnTheMap{
    NSArray *annArray = [[NSArray alloc]initWithArray:_mapView.annotations];
    [self.mapView removeAnnotations: annArray];
    [self.mapView removeOverlay:self.polygon];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.isDrawing){
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.imageView];
        //创建path
        self.pathRef=CGPathCreateMutable();
        CGPathMoveToPoint(self.pathRef, NULL, location.x, location.y);
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        [self.coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.isDrawing){
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.imageView];
        CGPoint pastLocation = [touch previousLocationInView:self.imageView];
        //画线
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pastLocation.x, pastLocation.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), location.x, location.y);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);  //颜色
        CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
        self.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        //更新Path
        CGPathAddLineToPoint(self.pathRef, NULL, location.x, location.y);
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        [self.coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.isDrawing){
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.imageView];
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
        [self.coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
        [self drawMap];
    }
}

-(void)drawMap{
    self.isDrawing = NO;
    NSInteger numberOfPoints = [self.coordinates count];
    
    if (numberOfPoints > 2)
    {
        double maxLongitude=-9999;
        double minLongitude=9999;
        double maxLatitude=-9999;
        double minLatitude=9999;
        
        CLLocationCoordinate2D points[numberOfPoints];
        for (NSInteger i = 0; i < numberOfPoints; i++) {
            points[i] = [self.coordinates[i] MKCoordinateValue];
            if (points[i].longitude>maxLongitude) {
                maxLongitude=points[i].longitude;
            }else if (points[i].longitude<minLongitude){
                minLongitude=points[i].longitude;
            }
            if (points[i].latitude>maxLatitude){
                maxLatitude=points[i].latitude;
            }else if (points[i].latitude<minLatitude){
                minLatitude=points[i].latitude;
            }
            
        }
        self.polygon = [BMKPolygon polygonWithCoordinates:points count:numberOfPoints];
        [self.mapView addOverlay:self.polygon];
        
        self.centerLocation=CLLocationCoordinate2DMake((maxLatitude+minLatitude)*0.5, (maxLongitude+minLongitude)*.5);
        CLLocationCoordinate2D coor1=CLLocationCoordinate2DMake(maxLatitude,maxLongitude);
        BMKMapPoint mp1 = BMKMapPointForCoordinate(coor1);
        BMKMapPoint mp2 = BMKMapPointForCoordinate(self.centerLocation);
        self.dis = BMKMetersBetweenMapPoints(mp1, mp2);
        NSLog(@"%f",self.dis);
        //self.pageCount=0;
        self.allCount=1;
        self.startIndex=-1;
        [self getMapSearch:self.centerLocation startIndex:YES dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
    }
}

-(void)getMapSearch:(CLLocationCoordinate2D)Location startIndex:(BOOL)isNext dis:(NSString *)distance{
    self.isNext = isNext;
    int tempStartIndex;
    if (isNext) {
        if (self.startIndex>=self.allCount-1) {
            tempStartIndex=self.allCount-1;
        }else{
            tempStartIndex=self.startIndex+1;
        }
    }else{
        if (self.startIndex<=0) {
            tempStartIndex=0;
        }else{
            tempStartIndex=self.startIndex-1;
        }
    }
    self.tempStartIndex = tempStartIndex;
    self.nextBtn.enabled = NO;
    self.lastBtn.enabled = NO;
    [ProjectApi GetMapSearchWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            CGPathCloseSubpath(self.pathRef);
            if([posts[1] intValue]%26 == 0){
                self.allCount = [posts[1] intValue]/26;
            }else{
                self.allCount = ([posts[1] intValue]/26)+1;
            }
            
            if (isNext) {
                if (self.startIndex<self.allCount-1) {
                    self.startIndex++;
                }
            }else{
                if (self.startIndex>0) {
                    self.startIndex--;
                }
            }
            if([posts[1] intValue] == 0){
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil]show];
                //[self judgeBtnEnable];
            }else{
                [self addAnnotation:posts[0] isNext:isNext];
                //[self judgeBtnEnable];
            }
            [self.imageView removeFromSuperview];
            self.imageView = nil;
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self getMapSearch:self.centerLocation startIndex:YES dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
                }];
            }
            [self.imageView removeFromSuperview];
            self.imageView = nil;
        }
    } longitude:[NSString stringWithFormat:@"%lf",self.centerLocation.longitude] latitude:[NSString stringWithFormat:@"%lf",self.centerLocation.latitude] radius:distance startIndex:tempStartIndex noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self getMapSearch:self.centerLocation startIndex:YES dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
        }];
    }];
    
}

-(void)addAnnotation:(NSMutableArray *)posts isNext:(BOOL)isNext{
    //地理坐标转换成点
    for(int i=0;i<posts.count;i++){
        projectModel *model = posts[i];
        _testLocation.latitude = [model.a_latitude floatValue];
        _testLocation.longitude = [model.a_longitude floatValue];
        NSLog(@"lat==%f,long==%f",_testLocation.latitude,_testLocation.longitude);
        self.locationConverToImage=[_mapView convertCoordinate:_testLocation toPointToView:self.imageView];
        //NSLog(@"%f====%f",locationConverToImage.x,locationConverToImage.y);
        if ([self PtInPolygon:_testLocation]) {
            
            NSLog(@"point in path!");
            [self.showArr addObject:model];
            self.annotationPoint = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = _testLocation.latitude;
            coor.longitude = _testLocation.longitude;
            self.annotationPoint.coordinate = coor;
            self.annotationPoint.title = model.a_landName;
            self.annotationPoint.subtitle = model.a_landAddress;
            [self.mapView addAnnotation:self.annotationPoint];
        }
    }
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    [self judgeBtnEnable];
    if(self.showArr.count == 0){
        if (isNext) {
            [self nextPage];
        }else{
            [self lastPage];
        }
    }else{
        if (isNext) {
            self.pageCount++;
        }else{
            self.pageCount--;
        }
    }
    [self judgeBtnEnable];
}

-(void)judgeBtnEnable{
    self.nextBtn.enabled=(self.startIndex<self.allCount-1);
    self.lastBtn.enabled=(self.pageCount>1);
}

-(void)reloadMap{
    NSLog(@"reloadMap");
    [self isLocation];
}

-(void)isLocation{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"没打开");
        [self.view addSubview:self.errorView];
    }else{
        NSLog(@"打开");
        [self.errorView removeFromSuperview];
        self.errorView = nil;
    }
}

-(BOOL)PtInPolygon:(CLLocationCoordinate2D)p{
    int nCross = 0;
    NSInteger numberOfPoints = [self.coordinates count];
    for(int i = 0; i < numberOfPoints; i++){
        CLLocationCoordinate2D p1 = [self.coordinates[i] MKCoordinateValue];
        CLLocationCoordinate2D p2 = [self.coordinates[(i+1)%numberOfPoints] MKCoordinateValue];
        // 求解 y=p.y 与 p1p2 的交点
        if ( p1.latitude == p2.latitude ){// p1p2 与 y=p0.y平行
            continue;
        }
        if(p.latitude < MIN(p1.latitude, p2.latitude)){// 交点在p1p2延长线上
            continue;
        }
        if(p.latitude >= MAX(p1.latitude, p2.latitude)){
            continue;
        }
        double x = (double)(p.latitude - p1.latitude) * (double)(p2.longitude - p1.longitude) / (double)(p2.latitude - p1.latitude) + p1.longitude;
        if ( x > p.longitude ){
            nCross++;
        }
    }
    return (nCross % 2 == 1);
}

-(void)addFocus:(NSInteger)index isFocused:(BOOL)isFocused{
    projectModel *model = [self.showArr objectAtIndex:index];
    if(isFocused){
        model.isFocused = @"1";
    }else{
        model.isFocused = @"0";
    }
    [self.showArr replaceObjectAtIndex:index withObject:model];
}

-(void)gotoLoginView{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.needDelayCancel=YES;
    loginVC.delegate = self;
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [self closeBgview];
    j = 0;
    [self removeAnnotationsOnTheMap];
    NSInteger numberOfPoints = [self.coordinates count];
    
    if (numberOfPoints > 2)
    {
        double maxLongitude=-9999;
        double minLongitude=9999;
        double maxLatitude=-9999;
        double minLatitude=9999;
        
        CLLocationCoordinate2D points[numberOfPoints];
        for (NSInteger i = 0; i < numberOfPoints; i++) {
            points[i] = [self.coordinates[i] MKCoordinateValue];
            if (points[i].longitude>maxLongitude) {
                maxLongitude=points[i].longitude;
            }else if (points[i].longitude<minLongitude){
                minLongitude=points[i].longitude;
            }
            if (points[i].latitude>maxLatitude){
                maxLatitude=points[i].latitude;
            }else if (points[i].latitude<minLatitude){
                minLatitude=points[i].latitude;
            }
            
        }
        self.polygon = [BMKPolygon polygonWithCoordinates:points count:numberOfPoints];
        [_mapView addOverlay:self.polygon];
        
        [ProjectApi GetMapSearchWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                [self.showArr removeAllObjects];
                CGPathCloseSubpath(self.pathRef);
                if([posts[1] intValue]%26 == 0){
                    self.allCount = [posts[1] intValue]/26;
                }else{
                    self.allCount = ([posts[1] intValue]/26)+1;
                }
                
                if (self.isNext) {
                    if (self.startIndex<self.allCount-1) {
                        self.startIndex++;
                    }
                }else{
                    if (self.startIndex>0) {
                        self.startIndex--;
                    }
                }
                if([posts[1] intValue] == 0){
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil]show];
                    //[self judgeBtnEnable];
                }else{
                    [self addAnnotation:posts[0] isNext:self.isNext];
                    //[self judgeBtnEnable];
                }
                [self.imageView removeFromSuperview];
                self.imageView = nil;
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                        [self getMapSearch:self.centerLocation startIndex:YES dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
                    }];
                }
                [self.imageView removeFromSuperview];
                self.imageView = nil;
            }
        } longitude:[NSString stringWithFormat:@"%lf",self.centerLocation.longitude] latitude:[NSString stringWithFormat:@"%lf",self.centerLocation.latitude] radius:[NSString stringWithFormat:@"%f",self.dis/1000] startIndex:self.tempStartIndex noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                [self getMapSearch:self.centerLocation startIndex:YES dis:[NSString stringWithFormat:@"%f",self.dis/1000]];
            }];
        }];
    }
    if (block) {
        block();
    }
}
@end



//没有定位的页面
@implementation LocationErrorView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 245, 245);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(73, 154, 173, 206)];
        imageView.image = [GetImagePath getImagePath:@"Shape-1"];
        [self addSubview:imageView];
        
        UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(107, 384, 105, 34)];
        btnImage.image = [GetImagePath getImagePath:@"重新加载"];
        [self addSubview:btnImage];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(107, 384, 105, 34);
        [button addTarget:self action:@selector(reloadMap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

-(void)reloadMap{
    if([self.delegate respondsToSelector:@selector(reloadMap)]){
        [self.delegate reloadMap];
    }
}
@end