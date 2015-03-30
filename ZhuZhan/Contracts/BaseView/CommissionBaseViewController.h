//
//  CommissionBaseViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import <UIKit/UIKit.h>

@interface CommissionBaseViewController : UIViewController
@property(nonatomic)BOOL needAnimaiton;
@property(nonatomic)BOOL leftBtnIsBack;
-(void)setRightBtnWithImage:(UIImage*)image;
-(void)setRightBtnWithText:(NSString*)text;
-(void)setLeftBtnWithImage:(UIImage*)image;
-(void)setLeftBtnWithText:(NSString*)text;
-(void)rightBtnClicked;
-(void)leftBtnClicked;
@end
