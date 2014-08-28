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
@interface AdvancedSearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AdvancedSearchConditionsDelegate>{
    UITableView *_tableView;
    NSMutableDictionary *dataDic;
    MultipleChoiceViewController *multipleChoseView;
}

@end
