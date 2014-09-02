//
//  HomePageViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactViewController.h"
#import "ProjectTableViewController.h"
#import "CompanyViewController.h"
//#import "TradeViewController.h"
#import "QuadCurveMenu.h"
#import "ProductViewController.h"
@interface HomePageViewController : UIViewController<QuadCurveMenuDelegate>{
    UIButton *contactBtn;
    UIButton *projectBtn;
    UIButton *companyBtn;
    UIButton *tradeBtn;
    UIButton *moreBtn;
    UIView *contentView;
    UIView *toolView;
    ContactViewController *contactview;
    ProjectTableViewController *projectview;
    CompanyViewController *companyview;
    ProductViewController *productView;
    UINavigationController *nav;
    QuadCurveMenu *menu;
}
-(void)homePageTabBarHide;
-(void)homePageTabBarRestore;
@end
