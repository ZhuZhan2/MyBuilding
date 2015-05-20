//
//  ProjectTableViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-26.
//
//

#import <UIKit/UIKit.h>
#import "TopicsTableViewController.h"
#import "SearchViewController.h"
#import "ProjectTableViewCell.h"
#import "PorjectCommentTableViewController.h"
#import "LoadingView.h"
@interface ProjectTableViewController : UITableViewController{
    NSMutableArray *showArr;
    int startIndex;
    LoadingView *loadingView;
    int sectionHeight;
    BOOL isReload;
}
@end
