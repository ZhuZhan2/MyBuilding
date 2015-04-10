//
//  ChatViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "AddGroupMemberController.h"
#import "ChatToolBar.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "JSONKit.h"
@interface ChatViewController ()<UIAlertViewDelegate>
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    [self initChatToolBar];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self addKeybordNotification];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"user" forKey:@"msgType"];
    [dic setObject:@"text" forKey:@"event"];
    [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
    [dic setObject:@"2765fb48-405c-4648-8b9f-d03957260e0e" forKey:@"toUserId"];
    [dic setObject:@"老板让我来草死你" forKey:@"content"];
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    NSLog(@"%@",str);
    AppDelegate *app = [AppDelegate instance];
    [app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [app.socket readDataWithTimeout:-1 tag:0];
}

-(void)initNavi{
    self.title=@"用户名";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithImage:[GetImagePath getImagePath:YES?@"单人会话":@"多人会话@2x"]];
}

-(void)sureBtnClickedWithContent:(NSString *)content{
    NSLog(@"content=%@",content);
}

-(void)rightBtnClicked{
    [self.view endEditing:YES];
    AddGroupMemberController* vc=[[AddGroupMemberController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    return;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        UITextField* textField=[alertView textFieldAtIndex:0];
        NSLog(@"==%@",textField.text);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

#define testContents @[@"开发部的都是好人，产品部设计部测试部都是坏人",@"范俊是帅哥",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"高凌露是美女",@"老板是好人",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"开发部的都是好人，产品部设计部测试部都是坏人",@"范俊是帅哥",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"高凌露是美女",@"老板是好人",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发"]
static BOOL testIsSelfs[12] = {1,1,0,0,1,0,1,1,0,0,1,0};
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* content=testContents[indexPath.row];
    return [ChatTableViewCell carculateTotalHeightWithContentStr:content isSelf:testIsSelfs[indexPath.row]];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ChatModel* model=[[ChatModel alloc]init];
    model.userNameStr=@"大家都是好人";
    model.chatContent=testContents[indexPath.row];
    model.isSelf=testIsSelfs[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    return cell;
}
@end
