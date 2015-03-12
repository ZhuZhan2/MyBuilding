//
//  ChatListViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "ChatListViewController.h"
#import "ChatListViewCell.h"
#import "SearchBarCell.h"
#import "ChatViewController.h"
#import "ChooseContactsViewController.h"

@implementation ChatListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES];
    [self initTableView];
}

-(void)initNavi{
    self.title=@"会话";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"发起"];
    self.needAnimaiton=YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChatListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" needRightBtn:YES];
    }
    NSDictionary* dic=@{@"userName":@"用户名",@"userImage":@"",@"isFocused":arc4random()%2?@"1":@"0",@"department":@"部门",@"company":@"一分以前哦"};
    
    
    EmployeesModel* model=[[EmployeesModel alloc]init];
    [model setDict:dic];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController* vc=[[ChatViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchBarCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SearchBarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    SearchBarCellModel* model=[[SearchBarCellModel alloc]init];
    model.mainLabelText=@"用户名显示";
    
    [cell setModel:model];
    return cell;
}

-(void)leftBtnClicked{
    [self.searchBar resignFirstResponder];
    [super leftBtnClicked];
}

-(void)rightBtnClicked{
    ChooseContactsViewController* vc=[[ChooseContactsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
