//
//  MyPointDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointDetailViewController.h"
#import "MyPointApi.h"
#import "MyPointDetailView.h"
#import "RKShadowView.h"
#import "MyPointDetailCell.h"
#import "RKViewFactory.h"
#import "PointDetailModel.h"

@interface MyPointDetailViewController ()
@property (nonatomic, strong)MyPointDetailView* myPointDetailView;
@property (nonatomic, strong)NSMutableArray* modelArr;
/**
 *  用于接口的查询条件,今天，昨天，全部
 */
@property (nonatomic, copy)NSString* timeStr;

/**
 *  分页计数变量
 */
@property (nonatomic)NSInteger startIndex;
@property (nonatomic, strong)UIView* noneDataView;
@property (nonatomic, strong)PointDetailModel* pointModel;
@end

@implementation MyPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"今天",@"昨天",@"全部"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
    [self initTableView];
    [self setUpRefreshWithNeedHeaderRefresh:YES needFooterRefresh:YES];
    [self firstNetWork];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat heights[3] = {CGRectGetHeight(self.myPointDetailView.frame),CGRectGetHeight(self.stageChooseView.frame),self.modelArr.count?0:CGRectGetHeight(self.noneDataView.frame)};
    return heights[section];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return @[self.myPointDetailView,self.stageChooseView,self.noneDataView][section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count[3] = {0,self.modelArr.count,0};
    return count[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPointHistoryModel* model = self.modelArr[indexPath.row];
    return [MyPointDetailCell carculateModel:model];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPointDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[MyPointDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    MyPointHistoryModel* model = self.modelArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)initTableView{
    CGFloat y=64;

    CGFloat height=kScreenHeight-y;
    self.tableView=[[RKBaseTableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.noDataView = self.tableViewNoDataView;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.tableView];
}

/**
 *  重写stageChooseView
 */
- (void)initStageChooseViewWithStages:(NSArray *)stages numbers:(NSArray *)numbers underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor{
    self.stageChooseView=[RKStageChooseView stageChooseViewWithStages:
                          stages numbers:numbers delegate:self underLineIsWhole:underLineIsWhole normalColor:normalColor highlightColor:highlightColor];
}

- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    NSDate* todayDate = [NSDate date];
    NSDate* yestodayDate = [todayDate dateByAddingTimeInterval:-24*3600];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString* todayDateStr = [dateFormatter stringFromDate:todayDate];
    NSString* yestodayDateStr = [dateFormatter stringFromDate:yestodayDate];

    NSArray* timeArr = @[todayDateStr,yestodayDateStr,@""];
    self.timeStr = timeArr[stageNumber];
    
    self.startIndex = 0;
    [self.modelArr removeAllObjects];
    [self.tableView reloadData];
    [self netWorkGetPointsWithTimeStr:self.timeStr finishBlock:nil startIndex:0];
}

- (void)headerRereshing{
    [self netWorkGetPointsWithTimeStr:self.timeStr finishBlock:^{
        self.startIndex = 0;
        [self.modelArr removeAllObjects];
    } startIndex:0];
}

- (void)footerRereshing{
    [self netWorkGetPointsWithTimeStr:self.timeStr finishBlock:^{
        self.startIndex ++;
    } startIndex:self.startIndex+1];
}

/**
 *  请求历史记录
 *
 *  @param timeStr    目标时间，精确到日
 *  @param block      完结时会调用的block
 *  @param startIndex 记录分页的变量
 */
- (void)netWorkGetPointsWithTimeStr:(NSString*)timeStr finishBlock:(void(^)())block startIndex:(NSInteger)startIndex{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:timeStr forKey:@"datetime"];
    
    [MyPointApi GetPointsLogWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            if (block) {
                block();
            }
            [self.modelArr addObjectsFromArray:posts];
            [self.tableView reloadData];
            [self endHeaderRefreshing];
            [self endFooterRefreshing];
        }
    } dic:dic startIndex:startIndex noNetWork:nil];
}

/**
 *  积分详情接口
 */
- (void)firstNetWork{
    [MyPointApi GetPointDetailWithBlock:^(PointDetailModel *model, NSError *error) {
        if (!error) {
            self.pointModel = model;
            self.myPointDetailView = nil;
            [self.tableView reloadData];
        }
    } noNetWork:nil];
}

/**
 *  导航栏设置
 */
- (void)initNavi{
    self.title = @"积分明细";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

- (MyPointDetailView *)myPointDetailView{
    if (!_myPointDetailView) {
        NSString* subTitle = [NSString stringWithFormat:@"%d",self.pointModel.a_points];
        _myPointDetailView = [MyPointDetailView myPointDetailViewWithMainTitle:@"我的积分" subTitle:subTitle];
        UIView* sepe = [RKShadowView seperatorLineDoubleWithHeight:10 top:0];
        _myPointDetailView.bottomView = sepe;
    }
    return _myPointDetailView;
}

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (UIView *)noneDataView{
    if (!_noneDataView) {
        _noneDataView = [RKViewFactory noDataViewWithTop:80];
        _noneDataView.backgroundColor = [UIColor clearColor];
        _noneDataView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    }
    return _noneDataView;
}
@end
