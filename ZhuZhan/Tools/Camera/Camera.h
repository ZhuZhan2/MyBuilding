//
//  Camera.h
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import <UIKit/UIKit.h>

@protocol CameraDelegate <NSObject>

@optional
-(void)changeUserIcon:(NSString *)imageStr AndImage:(UIImage *)image imageData:(NSData *)imageData;
-(void)changeBackgroundImage:(NSString*)imageStr AndImage:(UIImage*)image imageData:(NSData *)imageData;
-(void)publishImage:(NSString *)imageStr andImage:(UIImage *)image imageData:(NSData *)imageData;
-(void)openKeyBoard;

@end

@interface Camera : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) id<CameraDelegate> delegate;

-(void)modifyUserIconWithButtonIndex:(int)index WithButtonTag:(int)tag;

@end
