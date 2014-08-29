//
//  ShowPageDelegate.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShowPageDelegate <NSObject>
-(NSArray*)getThreeLinesTitleViewWithThreeStrsWithIndexPath:(MyIndexPath*)indexPath;//program大块 三行
-(NSArray*)getImageViewWithImageAndCountWithIndexPath:(MyIndexPath*)indexPath;//图加图的数量
-(NSArray*)getBlueTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath;//第一行蓝，第二行黑的view
-(NSMutableArray*)getThreeContactsViewThreeTypesFiveStrsWithIndexPath:(MyIndexPath*)indexPath;//联系人view
-(NSArray*)getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:(MyIndexPath*)indexPath;//program大块 二行
-(NSArray*)getDeviceAndBoolWithDevicesAndBoolStrsWithIndexPath:(MyIndexPath*)indexPath;//硬件设备以及yes和no
-(NSArray*)getBlackTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath;//第一行黑，第二行灰的view
-(NSArray*)getOwnerTypeViewWithImageAndOwnersWithIndexPath:(MyIndexPath*)indexPath;

-(void)chooseImageViewWithIndexPath:(MyIndexPath*)indexPath;
@end
