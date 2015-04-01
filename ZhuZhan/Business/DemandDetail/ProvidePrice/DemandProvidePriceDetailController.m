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
@interface DemandProvidePriceDetailController ()
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
    DemandDetailCellModel* cellModel=[[DemandDetailCellModel alloc]init];
    {
        QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
        cellModel.userName=dataModel.a_quoteUser;
        cellModel.userDescribe=dataModel.a_quoteIsVerified;
        cellModel.time=dataModel.a_createdTime;
        cellModel.numberDescribe=[NSString stringWithFormat:@"第%@次报价",dataModel.a_quoteTimes];
        cellModel.content=dataModel.a_quoteContent;
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        [dataModel.a_quoteAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
            RKImageModel *imageModel = [[RKImageModel alloc] init];
            imageModel.imageUrl =  model.a_location;
            imageModel.isUrl = model.a_isUrl;
            [array1 addObject:imageModel];
        }];
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        [dataModel.a_qualificationsAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
            RKImageModel *imageModel = [[RKImageModel alloc] init];
            imageModel.imageUrl =  model.a_location;
            imageModel.isUrl = model.a_isUrl;
            [array2 addObject:imageModel];
        }];
        NSMutableArray *array3 = [[NSMutableArray alloc] init];
        [dataModel.a_otherAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
            RKImageModel *imageModel = [[RKImageModel alloc] init];
            imageModel.imageUrl =  model.a_location;
            imageModel.isUrl = model.a_isUrl;
            [array3 addObject:imageModel];
        }];
        cellModel.array1=array1;
        cellModel.array2=array2;
        cellModel.array3=array3;
        cellModel.isFinish=![dataModel.a_status isEqualToString:@"0"];
    }
    return [DemandDetailViewCell carculateTotalHeightWithModel:cellModel];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self category:DemandControllerCategoryProvidePriceController];
    }
    DemandDetailCellModel* cellModel=[[DemandDetailCellModel alloc]init];
    {
        QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
        
        NSLog(@"dataModel===%@",dataModel);

        
        cellModel.userName=dataModel.a_quoteUser;
        cellModel.userDescribe=dataModel.a_quoteIsVerified;
        cellModel.time=dataModel.a_createdTime;
        cellModel.numberDescribe=[NSString stringWithFormat:@"第%@次报价",dataModel.a_quoteTimes];
        cellModel.content=dataModel.a_quoteContent;
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        [dataModel.a_quoteAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
            RKImageModel *imageModel = [[RKImageModel alloc] init];
            imageModel.imageUrl =  model.a_location;
            imageModel.isUrl = model.a_isUrl;
            [array1 addObject:imageModel];
        }];
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        [dataModel.a_qualificationsAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
            RKImageModel *imageModel = [[RKImageModel alloc] init];
            imageModel.imageUrl =  model.a_location;
            imageModel.isUrl = model.a_isUrl;
            [array2 addObject:imageModel];
        }];
        NSMutableArray *array3 = [[NSMutableArray alloc] init];
        [dataModel.a_otherAttachmentsArr enumerateObjectsUsingBlock:^(ImagesModel *model, NSUInteger idx, BOOL *stop) {
            RKImageModel *imageModel = [[RKImageModel alloc] init];
            imageModel.imageUrl =  model.a_location;
            imageModel.isUrl = model.a_isUrl;
            [array3 addObject:imageModel];
        }];
        cellModel.array1=array1;
        cellModel.array2=array2;
        cellModel.array3=array3;
        cellModel.isFinish=![dataModel.a_status isEqualToString:@"0"];
    }
    cellModel.indexPath=indexPath;
    cell.model=cellModel;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(demandDetailControllerLeftBtnClicked)]) {
        [self.delegate demandDetailControllerLeftBtnClicked];
    }
    NSLog(@"leftBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"rightBtnClicked,indexPath==%d",(int)indexPath.row);
    ProvidePriceInfoController* vc=[[ProvidePriceInfoController alloc]init];
    vc.askPriceModel = self.askPriceModel;
    [self.superViewController.navigationController pushViewController:vc animated:YES];
}

-(void)closeBtnClicked{
    NSMutableDictionary* dic=[@{@"createdBy":[LoginSqlite getdata:@"userId"],
                                @"bookBuildingId":self.askPriceModel.a_id
                                }mutableCopy];
    [AskPriceApi CloseQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        
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
    } providerId:[LoginSqlite getdata:@"userId"] tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:nil];
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
    } providerId:[LoginSqlite getdata:@"userId"] tradeCode:self.askPriceModel.a_tradeCode startIndex:self.startIndex+1 noNetWork:nil];
}
@end
