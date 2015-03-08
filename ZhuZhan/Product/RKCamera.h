//
//  RKCamera.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/6.
//
//

#import <Foundation/Foundation.h>

@protocol RKCameraDelegate <NSObject>
-(void)cameraWillFinishWithImage:(UIImage*)image isCancel:(BOOL)isCancel;
@end

@interface RKCamera : NSObject
+(id)cameraWithType:(UIImagePickerControllerSourceType)sourceType allowEdit:(BOOL)allowEdit deleate:(id<RKCameraDelegate>)delegate presentViewController:(UIViewController*)presentViewController;
@end
