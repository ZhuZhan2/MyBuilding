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
@interface MyPointDetailViewController ()
@property (nonatomic, strong)MyPointDetailView* myPointDetailView;
@end

@implementation MyPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AllBackLightGratColor;
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"今天",@"昨天",@"全部"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
    [self initTableView];
    [self firestNetWork];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?CGRectGetHeight(self.stageChooseView.frame):CGRectGetHeight(self.myPointDetailView.frame);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return section?self.stageChooseView:self.myPointDetailView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?10:0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPointDetailCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[MyPointDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyPointHistoryModel* model;
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
    [self.view addSubview:self.tableView];
}

/**
 *  重写stageChooseView
 */
- (void)initStageChooseViewWithStages:(NSArray *)stages numbers:(NSArray *)numbers underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor{
    self.stageChooseView=[RKStageChooseView stageChooseViewWithStages:
                          stages numbers:numbers delegate:self underLineIsWhole:underLineIsWhole normalColor:normalColor highlightColor:highlightColor];
}

/**
 *  进入页面后第一次网络请求
 */
- (void)firestNetWork{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    
    [MyPointApi GetPointsLogWithBlock:^(NSMutableArray *posts, NSError *error) {
        
    } dic:nil noNetWork:nil];
}

- (void)secondNetWork{

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
        _myPointDetailView = [MyPointDetailView myPointDetailViewWithMainTitle:@"我的积分" subTitle:@"123456789"];
        UIView* sepe = [RKShadowView seperatorLineDoubleWithHeight:14 top:0];
        _myPointDetailView.bottomView = sepe;
    }
    return _myPointDetailView;
}
@end
