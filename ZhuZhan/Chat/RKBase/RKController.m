//
//  RKController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/22.
//
//

#import "RKController.h"
#import "MJRefresh.h"
#import "RKViewFactory.h"
@interface RKController()
@property(nonatomic,copy)NSString* notiName;
@end

@implementation RKController
@synthesize notiName=_notiName;
- (instancetype)initWithNavi:(UINavigationController *)navi{
    if (self = [super init]) {
        self.navigationController = navi;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    [self.view addSubview:self.tableView];
}

- (void)setUpRefreshWithNeedHeaderRefresh:(BOOL)needHeaderRefresh needFooterRefresh:(BOOL)needFooterRefresh{
    if (needHeaderRefresh) [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    if (needFooterRefresh) [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)headerRereshing{
    
}

- (void)footerRereshing{
    
}

- (void)startLoading{
    if ([self.delegate respondsToSelector:@selector(controllerStartLoading)]) {
        [self.delegate controllerStartLoading];
    }
}

- (void)endLoading{
    if ([self.delegate respondsToSelector:@selector(controllerEndLoading)]) {
        [self.delegate controllerEndLoading];
    }
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _view;
}

- (RKBaseTableView*)tableView{
    if (!_tableView) {
        _tableView=[[RKBaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.noDataView = self.tableViewNoDataView;
        _tableView.backgroundColor = AllBackDeepGrayColor;
    }
    return _tableView;
}

- (UIView *)tableViewNoDataView{
    return [RKViewFactory noSearchResultsViewWithTop:140];
}

- (void)setViewFrame:(CGRect)frame{
    self.view.frame = frame;
    self.tableView.frame = self.view.bounds;
}

- (void)setNeedHeaderRefreshing:(BOOL)needHeaderRefreshing{
    if (needHeaderRefreshing&&!_needHeaderRefreshing) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerRereshing) name:self.notiName object:nil];
    }else if (!needHeaderRefreshing&&_needHeaderRefreshing){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:self.notiName object:nil];
    }
}

- (void)setNotiName:(NSString *)notiName{
    if ([_notiName isEqualToString:notiName]) return;
    if (_notiName) [[NSNotificationCenter defaultCenter] removeObserver:self name:_notiName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerRereshing) name:notiName object:nil];
    _notiName = notiName;
}
@end
