//
//  AdvancedSearchViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-28.
//
//

#import <UIKit/UIKit.h>
#import "AdvancedSearchConditionsTableViewCell.h"
#import "MultipleChoiceViewController.h"
#import "SaveConditionsViewController.h"
#import "ConditionsView.h"
#import "LoginViewController.h"
@interface AdvancedSearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AdvancedSearchConditionsDelegate,MChoiceViewDelegate,SaveConditionsViewDelegate,LoginViewDelegate>{
    UITableView *_tableView;
    NSMutableDictionary *dataDic;
    MultipleChoiceViewController *multipleChoseView;
    SaveConditionsViewController *saveView;
    ConditionsView *conditionsView;
    NSMutableArray *viewArr;
    NSMutableArray *showArr;
}

@end
