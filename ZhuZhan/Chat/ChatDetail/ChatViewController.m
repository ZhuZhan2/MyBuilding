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
#import "ChatMessageModel.h"
#import "ChatMessageApi.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "MessageTableView.h"
@interface ChatViewController ()<UIAlertViewDelegate,MessageTableViewDelegate>
@property (nonatomic, strong)NSMutableArray* models;
@property(nonatomic,strong)MessageTableView *tableView;
@property(nonatomic)int startIndex;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self initSocket];
    [self initNavi];
    [self initMessageTableView];
    //[self initTableView];
    //集成刷新控件
    [self setupRefresh];
    [self initChatToolBar];
    [self initTableViewHeaderView];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self addKeybordNotification];
    [self firstNetWork];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessage:) name:@"newMessage" object:nil];
}

-(void)initMessageTableView{
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 64, 320,kScreenHeight-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [ChatMessageApi GetMessageListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                   NSMakeRange(0,[posts count])];
            [self.models insertObjects:posts atIndexes:indexes];
            [self.tableView reloadData];
            //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.models.count-4 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }else{
            [LoginAgain AddLoginView:NO];
        }
        [self.tableView headerEndRefreshing];
    } userId:self.contactId startIndex:self.startIndex+1 noNetWork:nil];
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

-(void)newMessage:(NSNotification*)noti{
    NSLog(@"noti=%@",noti.userInfo[@"message"]);
    ChatMessageModel* dataModel=noti.userInfo[@"message"];
    NSLog(@"%@",self.type);
    if([self.type isEqualToString:@"01"]){
        if([self.contactId isEqualToString:dataModel.a_userId]){
            [self.models addObject:noti.userInfo[@"message"]];
            [self appearNewData];
        }
    }else{
        if([self.contactId isEqualToString:dataModel.a_groupId]){
            [self.models addObject:noti.userInfo[@"message"]];
            [self appearNewData];
        }
    }
}

-(void)appearNewData{
    [self.tableView reloadData];
    if(self.models.count !=0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.models.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void)firstNetWork{
    [ChatMessageApi GetMessageListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.models = posts;
            [self appearNewData];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } userId:self.contactId startIndex:0 noNetWork:nil];
}

-(void)initNavi{
    self.title=@"用户名";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithImage:[GetImagePath getImagePath:YES?@"单人会话":@"多人会话@2x"]];
}

-(void)rightBtnClicked{
    [self.view endEditing:YES];
    AddGroupMemberController* vc=[[AddGroupMemberController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatMessageModel* model=self.models[indexPath.row];
    NSString* content=model.a_message;
    return [ChatTableViewCell carculateTotalHeightWithContentStr:content isSelf:model.a_type];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ChatMessageModel* dataModel=self.models[indexPath.row];
    ChatModel* model=[[ChatModel alloc]init];
    model.userNameStr=dataModel.a_name;
    model.chatContent=dataModel.a_message;
    model.isSelf=dataModel.a_type;
    model.time=dataModel.a_time;
    model.userImageStr=dataModel.a_avatarUrl;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    return cell;
}

-(void)chatToolSendBtnClickedWithContent:(NSString *)content{
    [self sendMessage:content];
    [self addModelWithContent:content];
}

-(void)sendMessage:(NSString*)content{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if([self.type isEqualToString:@"01"]){
        [dic setObject:@"user" forKey:@"msgType"];
    }else{
        [dic setObject:@"group" forKey:@"msgType"];
    }
    [dic setObject:@"text" forKey:@"event"];
    [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
    [dic setObject:self.contactId forKey:@"toUserId"];
    [dic setObject:content forKey:@"content"];
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    
    AppDelegate *app = [AppDelegate instance];
    [app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [app.socket readDataWithTimeout:-1 tag:0];
}

-(void)addModelWithContent:(NSString*)content{
    ChatMessageModel* model=[[ChatMessageModel alloc]init];
    model.a_name=[LoginSqlite getdata:@"userName"];
    model.a_message=content;
    model.a_type=chatTypeMe;
    model.a_avatarUrl=[LoginSqlite getdata:@"userImage"];
    
    NSDate* date=[NSDate date];
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString* time=[formatter stringFromDate:date];
    model.a_time=time;
    
    [self.models addObject:model];
    [self appearNewData];
}

-(void)initTableViewHeaderView{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    self.tableView.tableHeaderView=view;
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}

-(void)touchesBeganInMessageTableView{
    [self.view endEditing:YES];
}
@end
