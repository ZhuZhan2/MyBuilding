//
//  ActiveViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import <UIKit/UIKit.h>

@protocol ActiveViewControllerDelegate <NSObject>
-(void)backGotoMarketView;
@end

@interface ActiveViewController : UIViewController
@property(nonatomic,weak)id<ActiveViewControllerDelegate>delegate;
@end
