//
//  RKCamera.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/6.
//
//

#import "RKCamera.h"

@interface RKCamera ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,weak)id<RKCameraDelegate>delegate;
@property(nonatomic)UIImagePickerControllerSourceType sourceType;
@property(nonatomic,weak)UIViewController* presentViewController;
@property(nonatomic)BOOL allowsEditing;
@end

@implementation RKCamera
+(id)cameraWithType:(UIImagePickerControllerSourceType)sourceType allowEdit:(BOOL)allowEdit deleate:(id<RKCameraDelegate>)delegate presentViewController:(UIViewController *)presentViewController{
    
    RKCamera* camera=[[RKCamera alloc]init];
    camera.delegate=delegate;
    camera.presentViewController=presentViewController;
    camera.allowsEditing=allowEdit;
    camera.sourceType=sourceType;
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
    [presentViewController presentViewController:imagePickerController animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImageView *preview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
    [preview setImage:image];
    image = [self convertViewAsImage:preview];
    if(picker.sourceType !=0){
   //     UIImageWriteToSavedPhotosAlbum(image, self,nil, nil);
    }
    [self cameraFinishWithPicker:picker info:info isCancel:NO];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self cameraFinishWithPicker:picker info:nil isCancel:YES];
}

-(void)cameraFinishWithPicker:(UIImagePickerController*)picker info:(NSDictionary*)info isCancel:(BOOL)isCancel{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(cameraWillFinishWithImage:isCancel:)]) {
        UIImage* image=isCancel?nil:(info[self.allowsEditing?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage]);
        [self.delegate cameraWillFinishWithImage:image isCancel:isCancel];
    }
}

- (UIImage *)convertViewAsImage:(UIView *)aview {
    UIGraphicsBeginImageContext(aview.bounds.size);
    [aview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
