//
//  PersonalCenterViewController.h
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *personaltableView;
@property (nonatomic,strong)NSMutableArray *personalArray;
@end
