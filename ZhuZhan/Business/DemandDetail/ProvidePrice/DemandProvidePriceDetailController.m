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
@interface DemandProvidePriceDetailController ()

@end

@implementation DemandProvidePriceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        cellModel.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
        cellModel.time=dataModel.a_createdTime;
        cellModel.numberDescribe=[NSString stringWithFormat:@"第%@次报价",dataModel.a_quoteTimes];
        cellModel.content=dataModel.a_quoteContent;
        cellModel.array1=@[@"",@""];
        cellModel.array2=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        cellModel.array3=@[];
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
        cellModel.userName=dataModel.a_quoteUser;
        cellModel.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
        cellModel.time=dataModel.a_createdTime;
        cellModel.numberDescribe=[NSString stringWithFormat:@"第%@次报价",dataModel.a_quoteTimes];
        cellModel.content=dataModel.a_quoteContent;
        cellModel.array1=@[@"",@""];
        cellModel.array2=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        cellModel.array3=@[];
    }
    cellModel.indexPath=indexPath;
    cell.model=cellModel;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"leftBtnClicked,indexPath==%d",(int)indexPath.row);
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
        
    } dic:dic noNetWork:nil];
    NSLog(@"closeBtnClicked");
}
@end
