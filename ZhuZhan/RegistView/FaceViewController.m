//
//  FaceViewController.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-7-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FaceViewController.h"

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "FaceLoginViewController.h"
#import "LoginSqlite.h"


@interface FaceViewController ()

@end

@implementation FaceViewController
static bool isBeginToCutFace =NO;
@synthesize delegate;
@synthesize event;

static int People =0;
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

    self.view.backgroundColor = [UIColor blackColor];
    
    
    _cameraView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 426)];
    _cameraView.center = self.view.center;
    [self.view addSubview:_cameraView];
    _imageView = [[UIImageView alloc] initWithFrame:_cameraView.frame];
    [self.view addSubview:_imageView];
    
    indicator = [[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
    [self.view addSubview:indicator];

    [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(playIndicator) userInfo:nil repeats:NO];
    event = [[LoginEvent alloc] init];
       
    [self initialize];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
//    AppDelegate* app=[AppDelegate instance];
//    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
//    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
//    AppDelegate* app=[AppDelegate instance];
//    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
//    [homeVC homePageTabBarHide];
}

-(void)playIndicator
{
    [indicator startAnimating];
}



//初始化
- (void) initialize
{
    People=0;
    
    //1.创建会话层
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPreset640x480];
    
    //2.创建、配置输入设备
	
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == AVCaptureDevicePositionFront)
        {
            NSLog(@"asdsf");
            _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            NSLog(@"==>%@",_captureInput);
        }
    }
    
    NSError *error;
	if (!_captureInput)
	{
		NSLog(@"Error: %@", error);
		return;
	}
    [_session addInput:_captureInput];
    
    ///out put
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc]
                                               init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    //captureOutput.minFrameDuration = CMTimeMake(1, 10);
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    //dispatch_release(queue);
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber
                       numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary
                                   dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    [_session addOutput:captureOutput];
    
    ///custom Layer
    self.customLayer = [CALayer layer];
    self.customLayer.frame = self.view.bounds;
    self.customLayer.transform = CATransform3DRotate(
                                                     CATransform3DIdentity, M_PI/2.0f, 0, 0, 1);
    self.customLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:self.customLayer];
    
    //3.创建、配置输出
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_captureOutput setOutputSettings:outputSettings];
	[_session addOutput:_captureOutput];
    
    ////////////
    _preview = [AVCaptureVideoPreviewLayer layerWithSession: _session];
    _preview.frame = CGRectMake(0, 0, self.cameraView.frame.size.width, self.cameraView.frame.size.height);
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.cameraView.layer addSublayer:_preview];
    [_session startRunning];
    

    
    
}

//从摄像头缓冲区获取图像
#pragma mark -
#pragma mark AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    
   
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress,
                                                    width, height, 8, bytesPerRow, colorSpace,
                                                    kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    
    
    
    UIImage *image= [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationLeftMirrored];
    
    CGImageRelease(newImage);
    
    image = [event fixOrientation:image]; //图像反转
    
    [self performSelectorOnMainThread:@selector(detectForFacesInUIImage:)
                           withObject: (id) image waitUntilDone:NO];
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
}

/////人脸识别
-(void)detectForFacesInUIImage:(UIImage *)facePicture
{
    CIImage* image = [CIImage imageWithCGImage:facePicture.CGImage];
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyLow forKey:CIDetectorAccuracy]];
    NSArray* features = [detector featuresInImage:image];
    for(int j=0;m_highlitView[j]!=nil;j++)
    {
        m_highlitView[j].hidden = YES;
    }
    int i=0;
    for(CIFaceFeature* faceObject in features)
    {
        NSLog(@"found face");
        CGRect modifiedFaceBounds = faceObject.bounds;
        modifiedFaceBounds.origin.y = facePicture.size.height-faceObject.bounds.size.height-faceObject.bounds.origin.y;
        modifiedFaceBounds.origin.x = facePicture.size.width-faceObject.bounds.size.width-faceObject.bounds.origin.x;

        [self addSubViewWithFrame:faceObject.bounds index:i image:facePicture];
       
        i++;
    }

}

///自画图像
-(void)addSubViewWithFrame:(CGRect)frame  index:(int)_index image:(UIImage *)image
{
   
    if(m_highlitView[_index]==nil)
    {
        
        m_highlitView[_index]= [[UIView alloc] initWithFrame:frame];
        m_highlitView[_index].layer.borderWidth = 2;
        m_highlitView[_index].layer.borderColor = [[UIColor redColor] CGColor];
        [self.imageView addSubview:m_highlitView[_index]];
        
        
        m_transform[_index] = m_highlitView[_index].transform;
    }
    frame.origin.x = frame.origin.x/1.5;
    frame.origin.y = frame.origin.y/1.5;
    frame.size.width = frame.size.width/1.5;
    frame.size.height = frame.size.height/1.5;
    m_highlitView[_index].frame = frame;
    
    
    ///根据头像大小缩放自画View
    float scale = frame.size.width/220;
    CGAffineTransform transform = CGAffineTransformScale(m_transform[_index], scale,scale);
    m_highlitView[_index].transform = transform;
    
    m_highlitView[_index].hidden = NO;
    
    //判定截图的条件
    if (m_highlitView[_index].center.x>80&&m_highlitView[_index].center.x<240&&m_highlitView[_index].center.y>100&&m_highlitView[_index].center.x<400&&m_highlitView[_index].frame.size.width>60&&m_highlitView[_index].frame.size.width<280&&m_highlitView[_index].frame.size.height>80&&m_highlitView[_index].frame.size.height<440) {
        isBeginToCutFace =YES;//截图的bool值为YES，开始执行截图函数
        [self performSelector:@selector(delayTojudge:) withObject:image afterDelay:1.0];
    }
    
}


- (void)delayTojudge:(UIImage *)image
{
    People++;//传入的image的数量
    if (isBeginToCutFace ==YES) {
        isBeginToCutFace =NO;
        [_session stopRunning];
        _session = nil;
        _captureInput = nil;
        _captureOutput = nil;
        _preview = nil;
        _device = nil;
        _imageView.image = image;
        
        if([[LoginSqlite getdata:@"isFaceRegister"] isEqualToString:@"1"]){//识别登录
                [event detectWithImage:image With:People];
            
        }else{
            if([delegate respondsToSelector:@selector(addImage:)]){//未注册时进行
            [delegate addImage:image];

            }
        }

    }
    
}


- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
