//
//  DemandProvidePriceDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandProvidePriceDetailController.h"
#import "AskPriceApi.h"
#import "LoginSqlite.h"
#import "MJRefresh.h"
#import "RKImageModel.h"
#import "WebViewController.h"
@interface DemandProvidePriceDetailController ()<UIAlertViewDelegate>
@property(nonatomic)int startIndex;
@end

@implementation DemandProvidePriceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self setupRefresh];
    [self loadList];
}

-(void)loadList{
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.detailModels=posts;
            [self.tableView reloadData];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } providerId:[LoginSqlite getdata:@"userId"] tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:nil];
}

-(NSMutableArray *)detailModels{
    if (!_detailModels) {
        _detailModels=[NSMutableArray array];
    }
    return _detailModels;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
    DemandDetailCellModel* cellModel=[self cellModelWithDataModel:dataModel];
    return [DemandDetailViewCell carculateTotalHeightWithModel:cellModel];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self category:DemandControllerCategoryProvidePriceController];
    }
    QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
    DemandDetailCellModel* cellModel=[self cellModelWithDataModel:dataModel];
//    cellModel.isFinish=self.isFinish;
//    cellModel.indexPath=indexPath;
    cell.model=cellModel;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(demandDetailControllerLeftBtnClicked)]) {
        [self.delegate demandDetailControllerLeftBtnClicked];
    }
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    ProvidePriceInfoController* vc=[[ProvidePriceInfoController alloc]init];
    vc.askPriceModel = self.askPriceModel;
    [self.superViewController.navigationController pushViewController:vc animated:YES];
}

-(void)closeBtnClicked{
    NSMutableDictionary* dic=[@{@"createdBy":[LoginSqlite getdata:@"userId"],
                                @"bookBuildingId":self.askPriceModel.a_id
                                }mutableCopy];
    [AskPriceApi CloseQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关闭成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } dic:dic noNetWork:nil];
    NSLog(@"closeBtnClicked");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.delegate respondsToSelector:@selector(backView)]) {
        [self.delegate backView];
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.detailModels removeAllObjects];
            self.detailModels=posts;
            [self.tableView reloadData];
        }else{
            [LoginAgain AddLoginView:NO];
        }
        [self.tableView headerEndRefreshing];
    } providerId:[LoginSqlite getdata:@"userId"] tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:nil];
}

- (void)footerRereshing
{
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.detailModels addObjectsFromArray:posts];
            [self.tableView reloadData];
        }else{
            [LoginAgain AddLoginView:NO];
        }
        [self.tableView footerEndRefreshing];
    } providerId:[LoginSqlite getdata:@"userId"] tradeCode:self.askPriceModel.a_tradeCode startIndex:self.startIndex+1 noNetWork:nil];
}

-(void)imageCilckWithDemandDetailViewCell:(RKImageModel *)model{
    WebViewController *view = [[WebViewController alloc] init];
    view.url = model.bigImageUrl;
    view.type = model.type;
    view.name = model.name;
    [self.superViewController.navigationController pushViewController:view animated:YES];
}
@end
