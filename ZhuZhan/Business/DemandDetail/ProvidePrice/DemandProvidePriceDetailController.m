//
//  DemandProvidePriceDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandProvidePriceDetailController.h"
#import "AskPriceApi.h"
@interface DemandProvidePriceDetailController ()

@end

@implementation DemandProvidePriceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSMutableArray *)detailModels{
    if (!_detailModels) {
        _detailModels=[NSMutableArray array];
        for (int i=0; i<8; i++) {
            DemandDetailCellModel* model=[[DemandDetailCellModel alloc]init];
            model.userName=@"用户名啊用户名啊用户名啊";
            model.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
            model.time=@"2015-01-23 11:47";
            model.numberDescribe=@"第N次报价";
            model.content=@"内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!";
            model.array1=@[@"",@""];
            model.array2=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
            model.array3=@[];
            
            [_detailModels addObject:model];
        }
    }
    return _detailModels;
}

-(void)setDetailModels:(NSMutableArray *)detailModels{
    NSLog(@"==>%@",detailModels);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DemandDetailViewCell carculateTotalHeightWithModel:self.detailModels[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self category:DemandControllerCategoryAskPriceController];
    }
    DemandDetailCellModel* model=self.detailModels[indexPath.row];
    model.indexPath=indexPath;
    cell.model=model;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"leftBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary* dic=[@{@"id":@""}mutableCopy];
    [AskPriceApi AcceptQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        
    } dic:dic noNetWork:nil];
    NSLog(@"rightBtnClicked,indexPath==%d",(int)indexPath.row);
}
//    + (NSURLSessionDataTask *)CloseQuotesWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dic:(NSMutableDictionary *)dic noNetWork:(void(^)())noNetWork;

-(void)closeBtnClicked{
    NSMutableDictionary* dic=[@{@"createdBy":@"",
                                @"bookBuildingId":@""
                                }mutableCopy];
    [AskPriceApi CloseQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        
    } dic:dic noNetWork:nil];
    NSLog(@"closeBtnClicked");
}
@end
