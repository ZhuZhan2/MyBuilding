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
@property(nonatomic,weak)NSString *searchStr;
@property(nonatomic,weak)NSMutableDictionary *dic;
@property(nonatomic)int flag;
@end
