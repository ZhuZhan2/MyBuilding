//
//  ResultsTableViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "HidePage.h"
@interface ResultsTableViewController : UITableViewController<HidePage>{
    NSMutableArray *showArr;
    int startIndex;
}
@property(nonatomic,retain)NSString *searchStr;
@property(nonatomic,weak)id<HidePage>delegate;
@end
