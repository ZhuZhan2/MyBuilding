//
//  MyPointDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/7/13.
//
//

#import "MyPointDetailViewController.h"
#import "MyPointApi.h"
@interface MyPointDetailViewController ()

@end

@implementation MyPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"今天",@"昨天",@"全部"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
    [self initTableView];
    [self firestNetWork];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?CGRectGetHeight(self.stageChooseView.frame):70;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view.backgroundColor = [UIColor redColor];
    return section?self.stageChooseView:view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?10:0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"暂无数据";
    return cell;
}

- (void)initTableView{
    CGFloat y=64;

    CGFloat height=kScreenHeight-y;
    self.tableView=[[RKBaseTableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
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
@end
