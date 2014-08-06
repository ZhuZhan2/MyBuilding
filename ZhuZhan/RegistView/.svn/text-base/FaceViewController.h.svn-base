//
//  FaceViewController.h
//  ZpzchinaMobile
//
//  Created by Jack on 14-7-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import "GPUImage.h"
#import "LoginEvent.h"
#import "TFIndicatorView.h"
@protocol FaceViewDelegate <NSObject>

-(void)addImage:(UIImage *)image;
-(void)beginToRecognize:(UIImage *)image;

@end
@interface FaceViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate>{
    AVCaptureSession *_session;
    AVCaptureDeviceInput *_captureInput;
    AVCaptureStillImageOutput *_captureOutput;
    AVCaptureVideoPreviewLayer *_preview;
    AVCaptureDevice *_device;
    
    UIView* m_highlitView[100];
    CGAffineTransform m_transform[100];
id<FaceViewDelegate>delegate;
        TFIndicatorView *indicator;
    
//    NSMutableArray *faceArray;
}
//@property (nonatomic)BOOL isFaceRegister;
@property (retain, nonatomic) UIView *cameraView;
@property (retain, nonatomic) UIImageView *imageView;
@property (nonatomic, retain) CALayer *customLayer;
@property (nonatomic,strong)LoginEvent *event;
@property( nonatomic, strong)id<FaceViewDelegate>delegate;

- (void) initialize;

@end
