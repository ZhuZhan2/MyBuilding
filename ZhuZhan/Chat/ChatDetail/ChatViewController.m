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
#import "PersonalDetailViewController.h"
#import "ProjectStage.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "ChatImageCell.h"
@interface ChatViewController ()<UIAlertViewDelegate,ChatTableViewCellDelegate>
@property (nonatomic, strong)NSMutableArray* models;
@property(nonatomic,strong)RKBaseTableView *tableView;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)NSString *lastId;
@property (nonatomic)NSInteger popViewControllerIndex;
@property(nonatomic,strong)AppDelegate *app;
@end

@implementation ChatViewController

-(instancetype)initWithPopViewControllerIndex:(NSInteger)index{
    if (self=[super init]) {
        self.popViewControllerIndex=index;
    }
    return self;
}

-(void)popNavi{
    if([self.fromView isEqualToString:@"qun"]){
        UIViewController* vc=self.navigationController.viewControllers[1];
        [self.navigationController popToViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadList" object:nil];
    }else{
        UIViewController* vc=self.navigationController.viewControllers[self.popViewControllerIndex];
        [self.navigationController popToViewController:vc animated:YES];
        if([self.delegate respondsToSelector:@selector(reloadList)]){
            [self.delegate reloadList];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self initSocket];
    [self initNavi];
    [self initTableView];
    self.tableView.isChatType = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //集成刷新控件
    [self setupRefresh];
    [self initChatToolBarWithNeedAddBtn:YES];
    self.chatToolBar.maxTextCountInChat = 1000;
    [self initTableViewHeaderView];
    [self addKeybordNotification];
    [self firstNetWork];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessage:) name:@"newMessage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(errorMessage) name:@"errorMessage" object:nil];
}

-(void)leftBtnClicked{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"02" forKey:@"deviceType"];
    [ChatMessageApi LogoutWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
             NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
            [dic2 setObject:self.contactId forKey:@"userId"];
            [ChatMessageApi LeaveWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [self popNavi];
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic2 noNetWork:^{
                [ErrorCode alert];
            }];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    }dic:dic noNetWork:^{
        [ErrorCode alert];
    }];
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
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self.tableView headerEndRefreshing];
    } userId:self.contactId chatlogId:self.lastId startIndex:self.startIndex+1 noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)initSocket{
    self.app = [AppDelegate instance];
    
    [self.app.socket connectToServer:@socketServer withPort:socketPort];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"event" forKey:@"msgType"];
    [dic setObject:@"login" forKey:@"event"];
    [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    [self.app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [self.app.socket readDataWithTimeout:-1 tag:0];
}

-(void)newMessage:(NSNotification*)noti{
    ChatMessageModel* dataModel=noti.userInfo[@"message"];
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

-(void)errorMessage{
    [self.navigationController popViewControllerAnimated:YES];
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
            ChatMessageModel* dataModel=[self.models lastObject];
            self.lastId = dataModel.a_id;
            [self appearNewData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } userId:self.contactId chatlogId:@"" startIndex:0 noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)initNavi{
    self.title=self.titleStr;
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    if ([self.type isEqualToString:@"02"]) {
        [self setRightBtnWithImage:[GetImagePath getImagePath:NO?@"单人会话":@"多人会话@2x"]];
    }
}

-(void)rightBtnClicked{
    [self.view endEditing:YES];
    AddGroupMemberController* vc=[[AddGroupMemberController alloc]init];
    vc.contactId=self.contactId;
    vc.titleStr = self.titleStr;
    vc.type = self.type;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatMessageModel* model=self.models[indexPath.row];
    if([model.a_msgType isEqualToString:@"01"]){
        NSString* content=model.a_message;
        return [ChatTableViewCell carculateTotalHeightWithContentStr:content isSelf:model.a_type];

    }else{
        CGSize defaultSize = DEFAULT_CELL_SIZE;
        CGSize cellSize = [ChatImageCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<CellHeightDelegate> cellToSetup) {
            [((ChatImageCell *)cellToSetup) setModel:model];
            return cellToSetup;
        }];
        return cellSize.height;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatMessageModel* dataModel=self.models[indexPath.row];
    if([dataModel.a_msgType isEqualToString:@"01"]){
        ChatTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        ChatModel* model=[[ChatModel alloc]init];
        model.userNameStr=dataModel.a_name;
        model.chatContent=dataModel.a_message;
        model.isSelf=dataModel.a_type;
        model.time=dataModel.a_time;
        model.userImageStr=dataModel.a_avatarUrl;
        model.ID = dataModel.a_userId;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=model;
        cell.delegate = self;
        return cell;
    }else{
        ChatImageCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ChatImageCell"];
        if (!cell) {
            cell=[[ChatImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatImageCell"];
            cell.clipsToBounds=YES;
        }
        cell.model = dataModel;
        cell.selectionStyle = NO;
        return cell;
    }
}

-(void)chatToolSendBtnClickedWithContent:(NSString *)content{
    NSLog(@"isConnected===>%d",self.app.socket.isConnected);
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
    }else{
        if(self.app.socket.isConnected){
            [self sendMessage:content];
            [self addModelWithContent:content];
        }else{
            [self.app.socket connectToServer:@socketServer withPort:socketPort];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:@"event" forKey:@"msgType"];
            [dic setObject:@"login" forKey:@"event"];
            [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
            NSString *str = [dic JSONString];
            str = [NSString stringWithFormat:@"%@\r\n",str];
            [self.app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
            [self.app.socket readDataWithTimeout:-1 tag:0];
            
            [self sendMessage:content];
            [self addModelWithContent:content];
        }
    }
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
    NSLog(@"%@",dic);
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    
    AppDelegate *app = [AppDelegate instance];
    [app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [app.socket readDataWithTimeout:-1 tag:0];
}

- (void)cameraWillFinishWithLowQualityImage:(UIImage *)lowQualityimage originQualityImage:(UIImage *)originQualityImage isCancel:(BOOL)isCancel{
    NSLog(@"lowQualityimage=%@",lowQualityimage);
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
    model.a_time=[ProjectStage ChatMessageTimeStage:time];
    
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

-(NSInteger)popViewControllerIndex{
    if (!_popViewControllerIndex) {
        _popViewControllerIndex=self.navigationController.viewControllers.count-2;
    }
    return _popViewControllerIndex;
}

-(void)gotoContactDetailView:(NSString *)contactId{
    PersonalDetailViewController *personalVC = [[PersonalDetailViewController alloc] init];
    personalVC.contactId = contactId;
    personalVC.fromViewName = @"chatView";
    personalVC.chatType = self.type;
    [self.navigationController pushViewController:personalVC animated:YES];
}
@end
