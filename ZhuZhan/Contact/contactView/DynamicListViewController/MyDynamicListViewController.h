//
//  MyDynamicListViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/1.
//
//

#import <UIKit/UIKit.h>
#import "ShowViewController.h"
@interface MyDynamicListViewController : UIViewController{
    ShowViewController *showVC;
}
@property (nonatomic, strong)UIViewController* nowViewController;
@end
