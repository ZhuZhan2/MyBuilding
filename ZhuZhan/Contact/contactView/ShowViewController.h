//
//  PanViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@protocol showControllerDelegate <NSObject>
-(void)gotoContactDetailView;
-(void)addfocus;
@end

@interface ShowViewController : UIViewController
@property(nonatomic,strong)NSString *iconUrl;
@property(nonatomic,strong)NSString *createdBy;
@property(nonatomic,strong)NSString *avatarUrl;
@property(nonatomic,strong)NSString *userNameStr;
@property(nonatomic,strong)NSString *messageStr;
@property(nonatomic,weak)id<showControllerDelegate>  delegate;

@end
