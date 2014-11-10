//
//  PorjectCommentTableViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import <UIKit/UIKit.h>
#import "ACTimeScroller.h"
#import "ProjectCommentView.h"
#import "AddCommentViewController.h"
#import "LoginViewController.h"
@interface PorjectCommentTableViewController : UITableViewController<ACTimeScrollerDelegate,AddCommentDelegate,ProjectCommentViewDelegate,LoginViewDelegate>{
    NSString *projectId;
    NSString *projectName;
    ACTimeScroller *_timeScroller;
    NSMutableArray *_datasource;
    NSMutableArray *showArr;
    NSMutableArray *viewArr;
    ProjectCommentView *projectCommentView;
    AddCommentViewController *addCommentView;
}
@property(nonatomic,strong)NSString *projectId;
@property(nonatomic,strong)NSString *projectName;
@end
