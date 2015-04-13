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
#import "AppDelegate.h"
#import "JSONKit.h"
#import "LoginSqlite.h"
#import "ChatMessageApi.h"
@interface ChatListViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong)NSMutableArray* models;
@end

@implementation ChatListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSocket];
    [self firstNetWork];
    [self initNavi];
    //[self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self initTableView];
}

-(void)initSocket{
    AppDelegate *app = [AppDelegate instance];
    
    [app.socket connectToServer:@socketServer withPort:44455];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"event" forKey:@"msgType"];
    [dic setObject:@"login" forKey:@"event"];
    [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    [app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [app.socket readDataWithTimeout:-1 tag:0];
}

-(void)firstNetWork{
    [ChatMessageApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.models = posts;
            [self.tableView reloadData];
        }
    } noNetWork:nil];
}

-(void)initNavi{
    self.title=@"会话";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"发起群聊"];
    self.needAnimaiton=YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChatListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" needRightBtn:YES];
    }
    ChatListModel* model=self.models[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListModel* model=self.models[indexPath.row];
    ChatViewController* vc=[[ChatViewController alloc]init];
    if([model.a_type isEqualToString:@"01"]){
        vc.contactId = model.a_loginId;
    }else{
        vc.contactId = model.a_groupId;
    }
    vc.type = model.a_type;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        ChatListModel* model=self.models[indexPath.row];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if([model.a_type isEqualToString:@"01"]){
            [dic setObject:model.a_loginId forKey:@"userId"];
        }else{
            [dic setObject:model.a_groupId forKey:@"userId"];
        }
        [ChatMessageApi DelMessageListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"删除成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
                [self.models removeObjectAtIndex:indexPath.row];
                NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }
        } dic:dic noNetWork:nil];
    }
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
