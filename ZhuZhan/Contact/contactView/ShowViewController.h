//
//  PanViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "LoginViewController.h"
@protocol showControllerDelegate <NSObject>
-(void)gotoContactDetailView:(NSString *)contactId;
@end

@interface ShowViewController : UIViewController<LoginViewDelegate>{
    UIButton *concernBtn;
    int isFoucsed;
}
@property(nonatomic,strong)NSString *createdBy;
@property(nonatomic,weak)id<showControllerDelegate>  delegate;

@end
