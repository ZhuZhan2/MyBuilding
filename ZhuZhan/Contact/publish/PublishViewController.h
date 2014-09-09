//
//  PublishViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "Camera.h"
@interface PublishViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,CameraDelegate>
@property (nonatomic,strong) UIImageView *toolBar;
@property (nonatomic,strong) UITextView *inputView;
@property (nonatomic,strong) UILabel *alertLabel;
@property (nonatomic,strong) UIImageView *leftBtnImage;
@property (nonatomic,strong) UIImageView *rightBtnImage;
@property (nonatomic,strong) UIImageView *publishImage;
@property (nonatomic, strong) Camera *camera;
@end
