//
//  PanViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import <UIKit/UIKit.h>
#import "HeadImageDelegate.h"

@protocol showControllerDelegate <NSObject>

-(void)jumpToGoToDetail:(UIButton *)button;
-(void)jumpToGotoConcern:(UIButton *)button;
-(void)jumpToGetRecommend:(NSDictionary *)dic;

@end

@interface ShowViewController : UIViewController<showControllerDelegate>

@property (nonatomic,strong) id<showControllerDelegate>  delegate;

@end
