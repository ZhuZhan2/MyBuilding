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
#import "Pan.h"
@interface ContactViewController : UITableViewController<ACTimeScrollerDelegate,XHPathCoverDelegate,PanDelegate>{
    NSMutableArray *_datasource;
    ACTimeScroller *_timeScroller;

    
}
@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic,strong) NSArray *comments;
@property (nonatomic,strong) Pan *pan;
@property (nonatomic,strong) UIView *transparent;
@end
