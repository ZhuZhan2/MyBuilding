//
//  BaiDuMapViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "BaiDuMapViewController.h"
#import <MapKit/MapKit.h>
#import "ProjectApi.h"
#import "projectModel.h"
#import "ErrorView.h"
#import "MBProgressHUD.h"
#import "ProjectStage.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "ProgramDetailViewController.h"
@interface BaiDuMapViewController ()
@property(nonatomic)BOOL isSelect;
@end

@implementation BaiDuMapViewController
int j;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    hasProject = 0;
    [self loadSelf];
}

-(void)loadSelf{
    j=0;
    numberArr = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    showArr = [[NSMutableArray alloc] init];
    logArr = [[NSMutableArray alloc] init];
    latArr = [[NSMutableArray alloc] init];
    pointArr = [[NSMutableArray alloc] init];
    coordinates = [[NSMutableArray alloc] init];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    _mapView.zoomEnabled = YES;//允许Zoom
    _mapView.scrollEnabled = YES;//允许Scroll
    _mapView.mapType = BMKMapTypeStandard;//地图类型为标准，可以为卫星，可以开启或关闭交通
    [_mapView setZoomLevel:15];
    [self.view addSubview:_mapView];
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    CLLocationCoordinate2D coor;
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.02f, 0));
    //调整后适合当前地图窗口显示的经纬度范围
    BMKCoordinateRegion adjusteRegion = [_mapView regionThatFits:viewRegion];
    // *设定当前地图的显示范围
    [_mapView setRegion:adjusteRegion animated:YES];
    
    btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, 66, 220)];
    drawBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    drawBtn.frame = CGRectMake(10,20, 40, 40);
    [drawBtn setBackgroundImage:[GetImagePath getImagePath:@"mapsearch-1"] forState:UIControlStateNormal];
    [drawBtn addTarget:self action:@selector(drawFunction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:drawBtn];
    
    [self.view addSubview:btnView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [self myViewWillAppear];
}

-(void)myViewWillAppear{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
//    _mapView = nil;
//    _locService = nil;
//    _geocodesearch = nil;
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)showContentView:(UIButton *)button{
    if(showArr.count !=0){
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-64)];
        [bgView setBackgroundColor:[UIColor clearColor]];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *bgViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [bgViewtapGestureRecognizer addTarget:self action:@selector(closeBgview)];
        [bgViewtapGestureRecognizer setNumberOfTapsRequired:1];
        [bgViewtapGestureRecognizer setNumberOfTouchesRequired:1];
        [bgView addGestureRecognizer:bgViewtapGestureRecognizer];
        [self.view addSubview:bgView];
        projectModel *model = [showArr objectAtIndex:button.tag];
        _MapContent = [[MapContentView alloc] initWithFrame:CGRectMake(0, 568, 320, 190) model:model number:[numberArr objectAtIndex:button.tag]];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoProgramDetailView:)];
        [_MapContent addGestureRecognizer:tap];
        _MapContent.tag=button.tag;
        _MapContent.userInteractionEnabled = YES;
        [self.view addSubview:_MapContent];
        [UIView animateWithDuration:0.5 animations:^{
            _MapContent.frame = CGRectMake(0, 378, 611, 260);
        }];
    }else{
        if(!self.isSelect){
            [_mapView selectAnnotation:annotationPoint animated:YES];
            self.isSelect = YES;
        }else{
            [_mapView deselectAnnotation:annotationPoint animated:YES];
            self.isSelect = NO;
        }
        imageView.userInteractionEnabled = NO;
    }
}

//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
//    NSLog(@"didSelectAnnotationView");
//    if(showArr.count !=0){
//        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-64)];
//        [bgView setBackgroundColor:[UIColor clearColor]];
//        bgView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *bgViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
//        [bgViewtapGestureRecognizer addTarget:self action:@selector(closeBgview)];
//        [bgViewtapGestureRecognizer setNumberOfTapsRequired:1];
//        [bgViewtapGestureRecognizer setNumberOfTouchesRequired:1];
//        [bgView addGestureRecognizer:bgViewtapGestureRecognizer];
//        [self.view addSubview:bgView];
//        projectModel *model = [showArr objectAtIndex:view.tag];
//        _MapContent = [[MapContentView alloc] initWithFrame:CGRectMake(0, 568, 320, 190) model:model number:[numberArr objectAtIndex:view.tag]];
//        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoProgramDetailView:)];
//        [_MapContent addGestureRecognizer:tap];
//        _MapContent.tag=view.tag;
//        _MapContent.userInteractionEnabled = YES;
//        [self.view addSubview:_MapContent];
//        [UIView animateWithDuration:0.5 animations:^{
//            _MapContent.frame = CGRectMake(0, 378, 611, 260);
//        }];
//    }else{
//        imageView.userInteractionEnabled = NO;
//    }
//}

-(void)gotoProgramDetailView:(UITapGestureRecognizer*)tap{
    projectModel *model = [showArr objectAtIndex:tap.view.tag];
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    vc.projectId=model.a_id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)closeBgview{
    [bgView removeFromSuperview];
    bgView=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _MapContent.frame = CGRectMake(0, 568, 611, 260);
        [_MapContent removeFromSuperview];
        _MapContent = nil;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//6跟新用户当前位置的代理方法  (地图用的时内部子程序时定位的)
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"定位跟新");
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView) {
        _mapView.region = region;
        NSLog(@"当前的坐标  维度:%f,经度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        //_mapView.showsUserLocation = YES;//显示定位图层
        [_mapView updateLocationData:userLocation];
        
        isGeoSearch = false;
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        /*if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
         pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
         }*/
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
        [_locService stopUserLocationService];
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    annotationPoint = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = result.location.latitude;
    coor.longitude = result.location.longitude;
    testLocation.latitude=result.location.latitude;//设定测试点的坐标是当前位置
    testLocation.longitude=result.location.longitude;
    annotationPoint.coordinate = coor;
    annotationPoint.title = result.address;
    [_mapView addAnnotation:annotationPoint];
    [_mapView setZoomLevel:14];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
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
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28.5, 30)];
//        label.textColor = [UIColor whiteColor];
//        label.font = [UIFont fontWithName:nil size:14];
//        label.text = [numberArr objectAtIndex:j];
//        label.textAlignment = NSTextAlignmentCenter;
//        [annotationView addSubview:label];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 28.5, 30)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:[numberArr objectAtIndex:j] forState:UIControlStateNormal];
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
    if(showArr.count !=0){
        annotationView.canShowCallout = NO;
    }else{
        annotationView.canShowCallout = YES;
    }
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    j++;
    return annotationView;
}

-(void)drawFunction{
    j=0;
    if(imageView == nil){
        topCount = 0;
        [topBgView removeFromSuperview];
        topBgView = nil;
        [countLabel removeFromSuperview];
        countLabel = nil;
        imageView=[[UIImageView alloc] initWithFrame:_mapView.frame];
        [imageView setImage:[GetImagePath getImagePath:@"地图搜索_02"]];
        imageView.userInteractionEnabled=YES;
        [self.view insertSubview:imageView atIndex:1];
        [self removeAnnotationsOnTheMap];
        UIGraphicsBeginImageContext(imageView.frame.size);
        
        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 50, 79, 133, 1.0);
        
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4);
        
        [coordinates removeAllObjects];
        [self removeAnnotationsOnTheMap];
    }else{
        [imageView removeFromSuperview];
        imageView = nil;
        if(topBgView == nil){
            topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320,40)];
            [topBgView setBackgroundColor:[UIColor grayColor]];
            [self.view addSubview:topBgView];
            topBgView.alpha = 0.5;
            countLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 69.5, 160, 30)];
            NSLog(@"%d",topCount);
            countLabel.text = [NSString stringWithFormat:@"%d条结果",topCount];
            countLabel.textColor = [UIColor blackColor];
            countLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:countLabel];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    //创建path
    
    pathRef=CGPathCreateMutable();
    
    CGPathMoveToPoint(pathRef, NULL, location.x, location.y);
    
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    CGPoint pastLocation = [touch previousLocationInView:imageView];
    
    //画线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pastLocation.x, pastLocation.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), location.x, location.y);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);  //颜色
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    
    //更新Path
    
    CGPathAddLineToPoint(pathRef, NULL, location.x, location.y);
    
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:imageView];
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    
    NSInteger numberOfPoints = [coordinates count];
    
    if (numberOfPoints > 2)
    {
        double maxLongitude=-9999;
        double minLongitude=9999;
        double maxLatitude=-9999;
        double minLatitude=9999;
        
        CLLocationCoordinate2D points[numberOfPoints];
        for (NSInteger i = 0; i < numberOfPoints; i++) {
            points[i] = [coordinates[i] MKCoordinateValue];
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
        polygon = [BMKPolygon polygonWithCoordinates:points count:numberOfPoints];
        [_mapView addOverlay:polygon];
        
        CLLocationCoordinate2D centerLocation=CLLocationCoordinate2DMake((maxLatitude+minLatitude)*0.5, (maxLongitude+minLongitude)*.5);

        [self getMapSearch:centerLocation];
    }
}

-(void)getMapSearch:(CLLocationCoordinate2D)centerLocation{
    [ProjectApi GetMapSearchWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            CGPathCloseSubpath(pathRef);
            showArr=posts;
            int count = 0;
            if(posts.count>26){
                count = 26;
            }else{
                count = posts.count;
            }
            //地理坐标转换成点
            for(int i=0;i<count;i++){
                projectModel *model = posts[i];
                testLocation.latitude = [model.a_latitude floatValue];
                testLocation.longitude = [model.a_longitude floatValue];
                NSLog(@"lat==%fm,long==%f",testLocation.latitude,testLocation.longitude);
                locationConverToImage=[_mapView convertCoordinate:testLocation toPointToView:imageView];
                //NSLog(@"%f====%f",locationConverToImage.x,locationConverToImage.y);
                if (CGPathContainsPoint(pathRef, NULL, locationConverToImage, NO)) {
                    
                    NSLog(@"point in path!");
                    annotationPoint = [[BMKPointAnnotation alloc]init];
                    CLLocationCoordinate2D coor;
                    coor.latitude = testLocation.latitude;
                    coor.longitude = testLocation.longitude;
                    annotationPoint.coordinate = coor;
                    annotationPoint.title = model.a_landName;
                    annotationPoint.subtitle = model.a_landAddress;
                    [_mapView addAnnotation:annotationPoint];
                    topCount++;
    
                }
            }
            [self drawFunction];
        }
    } longitude:[NSString stringWithFormat:@"%lf",centerLocation.longitude] latitude:[NSString stringWithFormat:@"%lf",centerLocation.latitude] noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568) superView:self.view reloadBlock:^{
            [self getMapSearch:centerLocation];
        }];
    }];
    
}


//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
		return circleView;
    }
    
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3.0;
		return polylineView;
    }
	
	if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =3.5;
		return polygonView;
    }
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
		return groundView;
    }
	return nil;
}

-(void)removeAnnotationsOnTheMap
{
    NSArray *annArray = [[NSArray alloc]initWithArray:_mapView.annotations];
    [_mapView removeAnnotations: annArray];
    [_mapView removeOverlay:polygon];
}
@end
