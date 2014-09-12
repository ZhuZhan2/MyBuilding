//
//  Camera.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "Camera.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "GTMBase64.h"
@interface Camera ()

@end

@implementation Camera

@synthesize delegate;
static int BtnTag =0;
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
}

-(void)modifyUserIconWithButtonIndex:(int)index WithButtonTag:(int)tag
{
    BtnTag =tag;
    UIImagePickerControllerSourceType sourceType;
    if (index==0) {
        NSLog(@"拍照获取图片");
        BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear];
        
        if (!isCamera) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备无摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
    }
        
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;

        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
    }
    if (index==1) {
        NSLog(@"通过相册获取图片");
        //用户相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;

        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    if (index==2) {//取消
        
        [self.view removeFromSuperview];
    }
    
}


#pragma mark ----UIImagePickerController delegate----
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [self fixOrientation:image];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    NSString* imageStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
   
    
    if (BtnTag == 2014090201) {//更换背景
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self.view removeFromSuperview];
        
    }
    if (BtnTag == 2014090202) {//更改用户头像
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self.view removeFromSuperview];
        [delegate changeUserIcon:imageStr AndImage:image];
        
    }
    if (BtnTag == 110120) {//发布时获取照片
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self.view removeFromSuperview];
        [delegate publishImage:imageStr andImage:image];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [delegate openKeyBoard];
    [self.view removeFromSuperview];
    
}


- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)dealloc{
    NSLog(@"camera dealloc");
}
@end
