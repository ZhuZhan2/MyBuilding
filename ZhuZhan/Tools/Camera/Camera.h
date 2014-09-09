//
//  Camera.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>

@protocol CameraDelegate <NSObject>

-(void)changeUserIcon:(NSString *)imageStr AndImage:(UIImage *)image;
-(void)publishImage:(NSString *)imageStr andImage:(UIImage *)image;

@end

@interface Camera : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) id<CameraDelegate> delegate;

-(void)modifyUserIconWithButtonIndex:(int)index WithButtonTag:(int)tag WithActionSheet:(UIActionSheet *)actionSheet;

@end
