//
//  ResultsTableViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "ProjectTableViewCell.h"
#import "LoadingView.h"
@interface ResultsTableViewController : UITableViewController{
    NSMutableArray *showArr;
    int startIndex;
    NSString *allCount;
    LoadingView *loadingView;
}
@property(nonatomic,strong)NSString *searchStr;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic)int flag;
@end
