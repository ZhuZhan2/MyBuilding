//
//  ConstractListController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ConstractListController.h"
#import "AskPriceViewCell.h"
#import "ContractsBaseViewController.h"

@interface ConstractListController ()
@property(nonatomic,strong)NSMutableArray *showArr;
@end

@implementation ConstractListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStageChooseViewWithStages:@[@"全部",@"待审核",@"待确认",@"已关闭",@"已完成"]  numbers:nil];
    [self initTableView];
}

-(NSMutableArray *)showArr{
    if (!_showArr) {
        _showArr=[NSMutableArray array];
        for (int i=0;i<15;i++) {
            [_showArr addObject:@[@"用户名",@"bigCategory",@"model.a_productCategory",@"model.a_remark",@"model.a_category",@"model.a_tradeStatus",@"model.a_tradeCode"]];
        }
    }
    return _showArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AskPriceViewCell carculateTotalHeightWithContents:self.showArr[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AskPriceViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    cell.contents=self.showArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractsBaseViewController* vc=[[ContractsBaseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    
}
@end
