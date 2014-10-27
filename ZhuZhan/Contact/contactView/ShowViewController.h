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
@property(nonatomic,strong)NSString *createdBy;
@property(nonatomic,weak)id<showControllerDelegate>  delegate;

@end
