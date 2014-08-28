//
//  ViewController.h
//  CycleScrollDemo
//
//  Created by Weever Lu on 12-6-14.
//  Copyright (c) 2012年 linkcity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
@interface ViewController : UIViewController<CycleScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray* imagesArray;
@end
