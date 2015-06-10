//
//  SearchBarTableViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import "ChatBaseViewController.h"

@class RKBaseTableView;
@interface SearchBarTableViewController : NSObject<RKBaseTableViewDelegate>
@property(nonatomic,strong)UIView* view;
@property(nonatomic,strong)RKBaseTableView* tableView;
@property(nonatomic,strong)UIView* noDataView;
@property(nonatomic,weak)id<SearchBarTableViewDelegate>delegate;
-(void)reloadSearchBarTableViewData;
-(instancetype)initWithTableViewBounds:(CGRect)bounds;
- (void)setUp;
@end
