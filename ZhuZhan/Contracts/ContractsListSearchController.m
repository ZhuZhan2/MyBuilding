//
//  ContractsListSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/31.
//
//

#import "ContractsListSearchController.h"

@interface ContractsListSearchController ()
@property(nonatomic,strong)NSString *statusStr;
@property(nonatomic,strong)NSString *otherStr;
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation ContractsListSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)loadList{
    
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    AskPriceModel *model = self.models[indexPath.row];
//    return [AskPriceViewCell carculateTotalHeightWithContents:@[model.a_invitedUser,model.a_productBigCategory,model.a_productCategory,model.a_remark]];
    return 0;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    AskPriceViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell=[[AskPriceViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.clipsToBounds=YES;
//    }
//    AskPriceModel *model = self.models[indexPath.row];
//    cell.contents=@[model.a_invitedUser,model.a_productBigCategory,model.a_productCategory,model.a_remark,model.a_category,model.a_tradeStatus,model.a_tradeCode];
    return nil;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AskPriceModel *model = self.models[indexPath.row];
//    if([model.a_category isEqualToString:@"0"]){
//        NSLog(@"自己发");
//        AskPriceDetailViewController *view = [[AskPriceDetailViewController alloc] init];
//        view.askPriceModel = model;
//        [self.navigationController pushViewController:view animated:YES];
//    }else{
//        NSLog(@"别人发");
//        QuotesDetailViewController *view = [[QuotesDetailViewController alloc] init];
//        view.askPriceModel = model;
//        [self.navigationController pushViewController:view animated:YES];
//    }
//    self.searchBarAnimationBackView.hidden=YES;
}
@end
