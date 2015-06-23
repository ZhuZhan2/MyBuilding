//
//  MarketListSearchViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/9.
//
//

#import <UIKit/UIKit.h>
#import "ChatBaseViewController.h"

@interface MarketListSearchViewController : ChatBaseViewController
@property(nonatomic)BOOL isPublic;//yes为全部需求列表进入，no我的需求列表进入
@property(nonatomic)BOOL isOpen;//yes为对所有人公开的，no只有客服可见的
@end
