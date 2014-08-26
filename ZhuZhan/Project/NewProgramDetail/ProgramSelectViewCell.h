//
//  ProgramSelectViewCell.h
//  programDetail
//
//  Created by 孙元侃 on 14-8-9.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProgramSelectViewCellDelegate <NSObject>
-(void)selectCancel;
@end

@interface ProgramSelectViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* stageLabel;
@property(nonatomic,strong)UIView* threeIconsView;
@property(nonatomic,weak)id<ProgramSelectViewCellDelegate>delegate;

+(ProgramSelectViewCell*)dequeueReusableCellWithTabelView:(UITableView*)tableView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath firstIcon:(BOOL)firstIcon secondIcon:(BOOL)secondIcon;
@end
