//
//  MarketViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/5/5.
//
//

#import <UIKit/UIKit.h>
@protocol MarketViewDelegate <NSObject>
-(void)gotoContactView;
@end
@interface MarketViewController : UIViewController
@property(nonatomic,weak)id<MarketViewDelegate>delegate;
@end
