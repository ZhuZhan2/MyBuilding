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
@interface TopicsDetailTableViewController : UITableViewController{
    NSMutableArray *showArr;
    int startIndex;
}
@property (nonatomic,retain) TopicsModel *model;
@end
