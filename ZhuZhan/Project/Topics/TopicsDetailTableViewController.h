//
//  TopicsDetailTableViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "TopicsModel.h"
#import "ProjectTableViewCell.h"
@interface TopicsDetailTableViewController : UITableViewController<ProjectTableViewCellDelegate>{
    NSMutableArray *showArr;
}
@property (nonatomic,retain) TopicsModel *model;
@end
