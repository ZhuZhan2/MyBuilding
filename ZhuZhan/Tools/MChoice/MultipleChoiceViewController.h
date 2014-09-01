//
//  MultipleChoiceViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MChoiceViewDelegate;
@interface MultipleChoiceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *showArr;
    NSMutableArray *dataArr;
}
@property(retain,nonatomic)NSMutableArray *showArr;
@property(retain,nonatomic)NSMutableArray *dataArr;
@property(retain,nonatomic)NSMutableArray *arr;
@property(nonatomic ,weak)id<MChoiceViewDelegate>delegate;
@property(nonatomic)int flag;
@end
@protocol MChoiceViewDelegate <NSObject>
-(void)choiceData:(NSMutableArray *)arr index:(int)index;
-(void)backMChoiceViewController;
@end