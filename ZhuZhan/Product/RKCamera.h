//
//  RKCamera.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/6.
//
//

#import <Foundation/Foundation.h>

@protocol RKCameraDelegate <NSObject>
-(void)cameraWillFinishWithLowQualityImage:(UIImage*)lowQualityimage originQualityImage:(UIImage*)originQualityImage isCancel:(BOOL)isCancel;
@end

@interface RKCamera : NSObject
+(instancetype)cameraWithType:(UIImagePickerControllerSourceType)sourceType allowEdit:(BOOL)allowEdit deleate:(id<RKCameraDelegate>)delegate presentViewController:(UIViewController *)presentViewController demandSize:(CGSize)demandSize needFullImage:(BOOL)needFullImage;
@end
