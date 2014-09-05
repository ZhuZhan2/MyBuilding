//
//  PublishViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import <UIKit/UIKit.h>

@interface PublishViewController : UIViewController<UITextViewDelegate>
@property (nonatomic,strong) UIView *toolBar;
@property (nonatomic,strong) UITextView *inputView;
@property (nonatomic,strong) UILabel *alertLabel;
@property (nonatomic,strong) UIImageView *leftBtnImage;
@property (nonatomic,strong) UIImageView *rightBtnImage;
@end
