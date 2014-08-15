//
//  CompanyViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HidePage.h"
@interface CompanyViewController : UIViewController{
    id<HidePage>hideDelegate;
}
@property(nonatomic,strong)id<HidePage>hideDelegate;
@end
