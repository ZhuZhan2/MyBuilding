//
//  SearchViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import <UIKit/UIKit.h>
#import "toolBarView.h"
#import "ResultsTableViewController.h"
#import "AdvancedSearchViewController.h"
#import "BaiDuMapViewController.h"
#import "UnderstandViewController.h"
@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,toolBarViewDelegate>{
    UISearchBar *_searchBar;
    UITableView *_tableView;
    NSMutableArray *showArr;
    toolBarView *toolbarView;
    UnderstandViewController *understandVC;
}

@end
