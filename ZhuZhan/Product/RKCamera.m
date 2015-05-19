//
//  RKCamera.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/6.
//
//

#import "RKCamera.h"
#import "RKViewFactory.h"
@interface RKCamera ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,weak)id<RKCameraDelegate>delegate;
@property(nonatomic)UIImagePickerControllerSourceType sourceType;
@property(nonatomic,weak)UIViewController* presentViewController;
@property(nonatomic)BOOL allowsEditing;
@property(nonatomic)CGSize demandSize;
@end

@implementation RKCamera
+(id)cameraWithType:(UIImagePickerControllerSourceType)sourceType allowEdit:(BOOL)allowEdit deleate:(id<RKCameraDelegate>)delegate presentViewController:(UIViewController *)presentViewController demandSize:(CGSize)demandSize{
    
    RKCamera* camera=[[RKCamera alloc]init];
    camera.delegate=delegate;
    camera.presentViewController=presentViewController;
    camera.allowsEditing=allowEdit;
    camera.sourceType=sourceType;
    camera.demandSize=demandSize;
    [camera setUp];
    return camera;
}

-(void)setUp{
    [self setUpImagePickerControllerWithAllowsEditing:self.allowsEditing sourceType:self.sourceType presentViewController:self.presentViewController];
}

-(void)setUpImagePickerControllerWithAllowsEditing:(BOOL)allowsEditing sourceType:(UIImagePickerControllerSourceType)sourceType presentViewController:(UIViewController*)presentViewController{
    UIImagePickerController* imagePickerController=[[UIImagePickerController alloc]init];
    imagePickerController.sourceType=sourceType;
    imagePickerController.delegate=self;
    imagePickerController.allowsEditing=allowsEditing;
    [presentViewController presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self cameraFinishWithPicker:picker info:info isCancel:NO];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self cameraFinishWithPicker:picker info:nil isCancel:YES];
}
 
-(void)cameraFinishWithPicker:(UIImagePickerController*)picker info:(NSDictionary*)info isCancel:(BOOL)isCancel{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(cameraWillFinishWithLowQualityImage:originQualityImage:isCancel:)]) {
        UIImage* originQualityImage=isCancel?nil:(info[self.allowsEditing?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage]);
        
        if(picker.sourceType !=0){
            UIImageWriteToSavedPhotosAlbum(originQualityImage, self,nil, nil);
        }
        
        //原图的一半
        CGFloat width=originQualityImage.size.width;
        CGFloat height=originQualityImage.size.height;
        UIView* view=[self getImageViewWithImage:originQualityImage size:CGSizeMake(width, height)];
        originQualityImage = [RKViewFactory convertViewAsImage:view];
        width=self.demandSize.width?2*self.demandSize.width:originQualityImage.size.width;
        height=self.demandSize.height?2*self.demandSize.height:originQualityImage.size.height;
        view=[self getImageViewWithImage:originQualityImage size:CGSizeMake(width, height)];
        UIImage* lowQualityImage= [RKViewFactory convertViewAsImage:view];
        
        [self.delegate cameraWillFinishWithLowQualityImage:lowQualityImage originQualityImage:originQualityImage isCancel:isCancel];
    }
}

-(UIImageView*)getImageViewWithImage:(UIImage*)image size:(CGSize)size{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image=image;
    return imageView;
}
@end
