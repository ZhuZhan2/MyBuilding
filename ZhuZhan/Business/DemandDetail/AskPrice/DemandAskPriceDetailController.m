//
//  DemandAskPriceDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandAskPriceDetailController.h"
#import "AskPriceApi.h"
#import "MJRefresh.h"
#import "RKImageModel.h"
@interface DemandAskPriceDetailController ()
@property(nonatomic)int startIndex;
@end

@implementation DemandAskPriceDetailController

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
        }
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:nil];
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
        cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self category:DemandControllerCategoryAskPriceController];
    }
    QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
    DemandDetailCellModel* cellModel=[self cellModelWithDataModel:dataModel];
    cellModel.isFinish=self.isFinish;
    cellModel.userDescribe = dataModel.a_quoteIsVerified;
    cellModel.indexPath=indexPath;
    cell.model=cellModel;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"leftBtnClickedWithIndexPath");
    if ([self.delegate respondsToSelector:@selector(demandDetailControllerLeftBtnClicked)]) {
        [self.delegate demandDetailControllerLeftBtnClicked];
    }
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
    NSMutableDictionary* dic=[@{@"id":dataModel.a_id}mutableCopy];
    [AskPriceApi AcceptQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"采纳成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil]show];
        }
    } dic:dic noNetWork:nil];
    NSLog(@"rightBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)closeBtnClicked{
    NSMutableDictionary* dic=[@{@"createdBy":self.quotesModel.a_loginId,
                                @"bookBuildingId":self.askPriceModel.a_id
                                }mutableCopy];
    [AskPriceApi CloseQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关闭成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } dic:dic noNetWork:nil];
    NSLog(@"closeBtnClicked");
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
        }
        [self.tableView headerEndRefreshing];
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:nil];
}

- (void)footerRereshing
{
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.detailModels addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
        [self.tableView footerEndRefreshing];
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:self.startIndex+1 noNetWork:nil];
}
@end
