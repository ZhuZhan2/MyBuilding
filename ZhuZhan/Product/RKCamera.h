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
//demandSize和needFullImage只影响lowQualityImage的返回
/*
 图片所有内容都保留，图片可能会变形
 if (needFullImage == YES ){
 if (demandSize != zero){
 按尺寸返图
 
 }else if (demandSize == zero){
 返原图
 }
 
 图片所有内容都保留，图片不变形
 }else {
 if (demandSize.width != 0 && demandSize.height != 0){
 if  (originImageSize.width <= demandSize.width && originImageSize.height <= demandSize.height){
 返原图
 }else{
 返回的图片满足以下规则
 returnImageSize.width <= originImageSize.width && returnImageSize.height <= originImageSize.height && (returnImageSize.width == originImageSize.width || returnImageSize.height == originImageSize.height)
 }
 }else if (demandSize == zero ){
 返原图
 
 }else if (demandSize.width和demandSize.height只有一个为0){
 返回的图片满足以下规则(只限制不为0的那个参数)
 returnImageSize.width <= originImageSize.width || retunImageSize.height <= originImageSize.height
 }
 }
 */
+(instancetype)cameraWithType:(UIImagePickerControllerSourceType)sourceType allowEdit:(BOOL)allowEdit deleate:(id<RKCameraDelegate>)delegate presentViewController:(UIViewController *)presentViewController demandSize:(CGSize)demandSize needFullImage:(BOOL)needFullImage;

+ (UIImage*)setUpLowQualityImageWithOriginImage:(UIImage*)originQualityImage demandSize:(CGSize)demandSize needFullImage:(BOOL)needFullImage;
@end
