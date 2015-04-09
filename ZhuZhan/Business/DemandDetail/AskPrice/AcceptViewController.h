//
//  AcceptViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/8.
//
//

#import <UIKit/UIKit.h>
@protocol AcceptViewControllerDelegate <NSObject>
-(void)acceptViewSureBtnClicked:(NSMutableArray *)arr;
-(void)acceptViewCancelBtnClicked;
@end
@interface AcceptViewController : UIViewController
@property(nonatomic)NSInteger sequnce;
@property(nonatomic,strong)NSMutableArray* invitedUserArr;
@property(nonatomic,weak)id<AcceptViewControllerDelegate>delegate;
@end
