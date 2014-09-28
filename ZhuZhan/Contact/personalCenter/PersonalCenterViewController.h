//
//  PersonalCenterViewController.h
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHPathCover.h"
#import "ACTimeScroller.h"
@interface PersonalCenterViewController : UITableViewController<ACTimeScrollerDelegate,XHPathCoverDelegate>
{
    NSMutableArray *_datasource;
    ACTimeScroller *_timeScroller;
    NSMutableArray *showArr;
    NSMutableArray* contentViews;
    NSInteger startIndex;
}
@property (nonatomic, strong) XHPathCover *pathCover;
@end
