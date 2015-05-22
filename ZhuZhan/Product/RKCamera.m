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
@property(nonatomic)BOOL needFullImage;

@property(nonatomic)UIStatusBarStyle statusBarStyle;
@end

@implementation RKCamera
+(instancetype)cameraWithType:(UIImagePickerControllerSourceType)sourceType allowEdit:(BOOL)allowEdit deleate:(id<RKCameraDelegate>)delegate presentViewController:(UIViewController *)presentViewController demandSize:(CGSize)demandSize needFullImage:(BOOL)needFullImage{

    RKCamera* camera = [[RKCamera alloc] init];
    camera.delegate = delegate;
    camera.presentViewController = presentViewController;
    camera.allowsEditing = allowEdit;
    camera.sourceType = sourceType;
    camera.demandSize = demandSize;
    camera.needFullImage = needFullImage;
    camera.statusBarStyle = [UIApplication sharedApplication].statusBarStyle;
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
    [presentViewController presentViewController:imagePickerController animated:YES completion:^{
        if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self cameraFinishWithPicker:picker info:info isCancel:NO];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self cameraFinishWithPicker:picker info:nil isCancel:YES];
}

-(void)cameraFinishWithPicker:(UIImagePickerController*)picker info:(NSDictionary*)info isCancel:(BOOL)isCancel{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarStyle = self.statusBarStyle;

    if ([self.delegate respondsToSelector:@selector(cameraWillFinishWithLowQualityImage:originQualityImage:isCancel:)]) {
        UIImage* originQualityImage=isCancel?nil:(info[self.allowsEditing?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage]);
        
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            UIImageWriteToSavedPhotosAlbum(originQualityImage, self,nil, nil);
        }
        
        //原图的一半
        CGFloat originWidth=originQualityImage.size.width;
        CGFloat originHeight=originQualityImage.size.height;
        UIView* originImageView=[self getImageViewWithImage:originQualityImage size:CGSizeMake(originWidth, originHeight)];
        originQualityImage = [RKViewFactory convertViewAsImage:originImageView];
        
        UIImage* lowQualityImage = [self setUpLowQualityImageWithOriginImage:originQualityImage];
        
        if ([self.delegate respondsToSelector:@selector(cameraWillFinishWithLowQualityImage:originQualityImage:isCancel:)]) {
            [self.delegate cameraWillFinishWithLowQualityImage:lowQualityImage originQualityImage:originQualityImage isCancel:isCancel];
        }
    }
}

- (UIImage*)setUpLowQualityImageWithOriginImage:(UIImage*)originQualityImage{
    if (CGSizeEqualToSize(self.demandSize, CGSizeZero)) {
        return originQualityImage;
    }
    if (self.needFullImage) {
        UIImageView* lowQualityImageView=[self getImageViewWithImage:originQualityImage size:self.demandSize];
        return [RKViewFactory convertViewAsImage:lowQualityImageView];
    }
    //以下为 needFullImage == NO 的情况
    CGFloat imageScale = originQualityImage.size.height / originQualityImage.size.width;
    
    BOOL isRelyHeight;
    if (!(self.demandSize.width*self.demandSize.height)) {
        isRelyHeight = self.demandSize.height;
    }else if (originQualityImage.size.width <= self.demandSize.width && originQualityImage.size.height <= self.demandSize.height){
        return originQualityImage;
    }else{
        CGFloat demandScale = self.demandSize.height / self.demandSize.width;
        isRelyHeight = imageScale > demandScale ;
    }
    
    CGFloat scale = isRelyHeight ? (self.demandSize.height/originQualityImage.size.height) : (self.demandSize.width/originQualityImage.size.width);
    
    CGSize lowQualityImageSize = CGSizeMake(originQualityImage.size.width*scale, originQualityImage.size.height*scale);
    UIView* lowQualityImageView=[self getImageViewWithImage:originQualityImage size:lowQualityImageSize];
    return [RKViewFactory convertViewAsImage:lowQualityImageView];
}

-(UIImageView*)getImageViewWithImage:(UIImage*)image size:(CGSize)size{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image=image;
    return imageView;
}

- (void)setDemandSize:(CGSize)demandSize{
    _demandSize = CGSizeMake(demandSize.width*2, demandSize.height*2);
}
@end
