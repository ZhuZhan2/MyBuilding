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
@interface ChatViewController ()<UIAlertViewDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
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
    
    AddGroupMemberController* vc=[[AddGroupMemberController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return;
//    UIView* view=[AlertTextFieldView alertTextFieldViewWithName:@"群聊名称" sureBtnTitle:@"确认" cancelBtnTitle:@"取消" originY:111  delegate:self];
//    [self.navigationController.view addSubview:view];
    
//    NSMutableArray* array=[NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        DiscussionGroupModel* model=[[DiscussionGroupModel alloc]init];
//        model.memberName=@[@"范俊",@"汪洋",@"高大人",@"朱总",@"老板",@"深集科技"][arc4random()%6];
//        [array addObject:model];
//    }
//
//    
//    DiscussionGroupView* view=[DiscussionGroupView discussionGroupViewWithTitle:@"讨论组名称" members:[array copy] newNotification:NO delegate:self];
//    [self.navigationController.view addSubview:view];
    return;
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"群聊名称" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];
    alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
    alertView.delegate=self;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        UITextField* textField=[alertView textFieldAtIndex:0];
        NSLog(@"==%@",textField.text);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

#define testContents @[@"开发部的都是好人，产品部设计部测试部都是坏人",@"范俊是帅哥",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"高凌露是美女",@"老板是好人",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发"]
static BOOL testIsSelfs[6] = {1,1,0,0,1,0};
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
