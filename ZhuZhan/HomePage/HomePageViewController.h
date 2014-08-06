//
//  HomePageViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactViewController.h"
#import "ProjectViewController.h"
#import "CompanyViewController.h"
#import "TradeViewController.h"
@interface HomePageViewController : UIViewController{
    UIButton *contactBtn;
    UIButton *projectBtn;
    UIButton *companyBtn;
    UIButton *tradeBtn;
    UIButton *moreBtn;
    UIView *contentView;
    UIView *toolView;
    ContactViewController *contactview;
    ProjectViewController *projectview;
    CompanyViewController *companyview;
    TradeViewController *tradeview;
    UINavigationController *nav;
}

@end
