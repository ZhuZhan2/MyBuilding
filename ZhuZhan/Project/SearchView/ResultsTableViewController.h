//
//  ResultsTableViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
@interface ResultsTableViewController : UITableViewController{
    NSMutableArray *showArr;
    int startIndex;
}
@property(nonatomic,retain)NSString *searchStr;
@end
