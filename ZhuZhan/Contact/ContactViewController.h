//
//  ContactViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPathCover.h"
#import "ACTimeScroller.h"
#import "HidePage.h"
@interface ContactViewController : UITableViewController<ACTimeScrollerDelegate>{
    NSMutableArray *_datasource;
    ACTimeScroller *_timeScroller;
    id<HidePage>hideDelegate;
}
@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic, strong) id<HidePage>hideDelegate;
@end
