//
//  RecommendListViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "RecommendListViewController.h"

@interface RecommendListViewController ()

@end

@implementation RecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    //[self setUpSearchBarWithNeedTableView:YES];
   //[self initTableView];
}

-(void)initNavi{
    self.title=@"推荐信列表";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"清空"];
    self.needAnimaiton=YES;
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 11;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ChatListViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell=[[ChatListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" needRightBtn:YES];
//    }
//    NSDictionary* dic=@{@"loginName":@"用户名",@"userImage":@"",@"isFocused":arc4random()%2?@"1":@"0",@"department":@"部门",@"company":@"一分以前哦"};
//    
//    
//    EmployeesModel* model=[[EmployeesModel alloc]init];
//    [model setDict:dic];
//    
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    [cell setModel:model];
//    return cell;
//}
@end
