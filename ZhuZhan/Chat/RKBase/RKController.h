//
//  RKController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import <Foundation/Foundation.h>
#import "RKBaseTableView.h"

@protocol RKControllerDelegate <NSObject>
- (void)controllerStartLoading;
- (void)controllerEndLoading;
@end

@interface RKController : NSObject<RKBaseTableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIActivityIndicatorView* indicatorView;

- (instancetype)initWithNavi:(UINavigationController*)navi;
@property(nonatomic,strong)UINavigationController* navigationController;

@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic)NSInteger startIndex;

@property(nonatomic,strong)UIView* view;
- (void)setViewFrame:(CGRect)frame;

@property(nonatomic,strong)RKBaseTableView* tableView;
@property(nonatomic,strong)UIView* tableViewNoDataView;

- (void)setUp;

@property(nonatomic,weak)id<RKControllerDelegate> delegate;
- (void)startLoading;
- (void)endLoading;

- (void)setUpRefreshWithNeedHeaderRefresh:(BOOL)needHeaderRefresh needFooterRefresh:(BOOL)needFooterRefresh;
- (void)headerRereshing;
- (void)footerRereshing;
@end
