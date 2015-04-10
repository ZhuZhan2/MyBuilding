//
//  SearchBarTableViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import "ChatBaseViewController.h"

@interface SearchBarTableViewController : UIViewController
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,weak)id<SearchBarTableViewDelegate>delegate;
-(void)reloadSearchBarTableViewData;
-(instancetype)initWithTableViewBounds:(CGRect)bounds;
@end
