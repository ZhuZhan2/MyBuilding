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
#import "VIPhotoView.h"
#import "ChatSendImageView.h"
#import "ForwardListViewController.h"
#import "ChatImageSqlite.h"

@interface ChatViewController ()<UIAlertViewDelegate,ChatTableViewCellDelegate,ChatImageCellDelegate,VIPhotoViewDelegate,ChatSendImageViewDelegate,ForwardListViewControllerDelegate>
@property (nonatomic, strong)NSMutableArray* models;
@property(nonatomic,strong)RKBaseTableView *tableView;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)NSString *lastId;
@property (nonatomic)NSInteger popViewControllerIndex;
@property(nonatomic,strong)AppDelegate *app;
@property(nonatomic,strong)VIPhotoView *photoView;
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
    [ChatImageSqlite delAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self initSocket];
    [self initNavi];
    [self initTableView];
    self.tableView.isChatType = YES;
    self.view.backgroundColor = AllBackLightGratColor;
    //集成刷新控件
    [self setupRefresh];
    [self initChatToolBarWithNeedAddBtn:YES];
    self.chatToolBar.maxTextCountInChat = 1000;
    [self initTableViewHeaderView];
    [self addKeybordNotification];
    [self firstNetWork];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessage:) name:@"newMessage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendMessageResult:) name:@"sendMessageResult" object:nil];
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
            //ChatMessageModel* dataModel=[posts firstObject];
            //self.lastId = dataModel.a_id;
            [self.tableView reloadData];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    uint16_t port = [[userDefaults objectForKey:@"socketPort"] intValue];
    [self.app.socket connectToServer:[userDefaults objectForKey:@"socketServer"] withPort:port];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"event" forKey:@"msgType"];
    [dic setObject:@"login" forKey:@"event"];
    [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    [self.app.socket readDataWithTimeout:-1 tag:0];
    [self.app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
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

-(void)sendMessageResult:(NSNotification*)noti{
    NSLog(@"message=%@",noti.userInfo[@"message"]);
    NSDictionary* messageDic = noti.userInfo[@"message"];
    ChatMessageModel* model = [self findModelWithLocalId:messageDic[@"tempId"]];
    model.messageStatus = [messageDic[@"msgType"] isEqualToString:@"success"]?ChatMessageStatusSucess:ChatMessageStatusFail;
    model.a_id = messageDic[@"fromId"];
    [self.tableView reloadData];
}

- (ChatMessageModel*)findModelWithLocalId:(NSString*)localId{
    __block ChatMessageModel* dataModel;
    [self.models enumerateObjectsUsingBlock:^(ChatMessageModel* model, NSUInteger idx, BOOL *stop) {
        BOOL isSame = [model.a_localId isEqualToString:localId];
        if (isSame){
            dataModel = model;
            *stop = YES;
        }
    }];
    return dataModel;
}

- (ChatMessageModel*)findModelWithServerId:(NSString*)serverId{
    __block ChatMessageModel* dataModel;
    [self.models enumerateObjectsUsingBlock:^(ChatMessageModel* model, NSUInteger idx, BOOL *stop) {
        BOOL isSame = [model.a_id isEqualToString:serverId];
        if (isSame){
            dataModel = model;
            *stop = YES;
        }
    }];
    return dataModel;
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
        return 65+model.a_imageHeight/2;
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
        model.messageStatus = dataModel.messageStatus;
        model.time=dataModel.a_time;
        model.userImageStr=dataModel.a_avatarUrl;
        model.ID = dataModel.a_userId;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=model;
        cell.indexPath = indexPath;
        cell.delegate = self;
        return cell;
    }else{
        ChatImageCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ChatImageCell"];
        if (!cell) {
            cell=[[ChatImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatImageCell"];
            cell.clipsToBounds=YES;
        }
        cell.model = dataModel;
        cell.indexPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}

- (void)failBtnClicked:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
    ChatMessageModel *model = self.models[indexPath.row];
    if([model.a_msgType isEqualToString:@"01"]){
        [self sendMessage:model.a_message timestamp:model.a_localId];
    }else{
        //UIImage *img = [UIImage imageWithContentsOfFile:model.a_localBigImageUrl];
        //NSData *imageData = UIImageJPEGRepresentation(img, 1);
        NSData *imageData = [ChatImageSqlite loadList:model.a_localId];
        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
        [imageArr addObject:imageData];
        [ChatMessageApi AddImageWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [imageArr removeAllObjects];
                NSDictionary* messageDic = posts[0][@"data"];
                ChatMessageModel* model = [self findModelWithLocalId:messageDic[@"tempId"]];
                model.messageStatus = ChatMessageStatusSucess;
                model.a_id = messageDic[@"chatlogId"];
                [self.tableView reloadData];
            }else{
                ChatMessageModel* model = [self findModelWithLocalId:model.a_localId];
                model.messageStatus = ChatMessageStatusFail;
                [self.tableView reloadData];
            }
        } dataArr:imageArr dic:[@{@"userId":self.contactId,@"userType":self.type,@"id":model.a_localId} mutableCopy] noNetWork:^{
            ChatMessageModel* model = [self findModelWithLocalId:model.a_localId];
            model.messageStatus = ChatMessageStatusFail;
            [self.tableView reloadData];
        }];
    }
    [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(sendMessageTimeOut:) userInfo:@{@"timesId":model.a_localId} repeats:NO];
}

- (void)forwardBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    ChatMessageModel* dataModel=self.models[indexPath.row];
    if([dataModel.a_msgType isEqualToString:@"01"]){
        ForwardListViewController *view = [[ForwardListViewController alloc] init];
        view.delegate = self;
        view.messageId = dataModel.a_id;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
        nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
        [self.view.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
}

-(void)gotoForwardListView:(NSString *)messageId{
    ForwardListViewController *view = [[ForwardListViewController alloc] init];
    view.messageId = messageId;
    view.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    nav.navigationBar.barTintColor = RGBCOLOR(85, 103, 166);
    [self.view.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)chatToolBarImagePasted:(UIImage *)image{
    ChatSendImageView* sendView = [[ChatSendImageView alloc] initWithFrame:self.view.bounds];
    sendView.mainImageView.image = image;
    sendView.delegate = self;
    [self.navigationController.view addSubview:sendView];
    
    [self.view endEditing:YES];
}

- (void)chatSendImage:(UIImage *)image{
    UIImage* lowQualityImage = [RKCamera setUpLowQualityImageWithOriginImage:image demandSize:CGSizeMake(200, 200) needFullImage:NO];
    [self sendImageWithLowQualityImage:lowQualityImage originQualityImage:image];
}

-(void)chatToolSendBtnClickedWithContent:(NSString *)content{
    NSLog(@"isConnected===>%d",self.app.socket.isConnected);
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
    }else{
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        NSString *timeId = [NSString stringWithFormat:@"%llu", recordTime];
        NSLog(@"tmeId==>%@",timeId);
        if(self.app.socket.isConnected){
            [self sendMessage:content timestamp:timeId];
            [self addModelWithContent:content timestamp:timeId];
        }else{
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            uint16_t port = [[userDefaults objectForKey:@"socketPort"] intValue];
            [self.app.socket connectToServer:[userDefaults objectForKey:@"socketServer"] withPort:port];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:@"event" forKey:@"msgType"];
            [dic setObject:@"login" forKey:@"event"];
            [dic setObject:[NSString stringWithFormat:@"%@:%@",[LoginSqlite getdata:@"userId"],[LoginSqlite getdata:@"token"]] forKey:@"fromUserId"];
            NSString *str = [dic JSONString];
            str = [NSString stringWithFormat:@"%@\r\n",str];
            [self.app.socket readDataWithTimeout:-1 tag:0];
            [self.app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
            
            [self sendMessage:content timestamp:timeId];
            [self addModelWithContent:content timestamp:timeId];
        }
    }
}

-(void)sendMessage:(NSString*)content timestamp:(NSString *)timestamp{
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
    [dic setObject:timestamp forKey:@"id"];
    NSLog(@"%@",dic);
    NSString *str = [dic JSONString];
    str = [NSString stringWithFormat:@"%@\r\n",str];
    
    AppDelegate *app = [AppDelegate instance];
    [app.socket readDataWithTimeout:-1 tag:0];
    [app.socket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}

- (void)chatMoreSelectViewClickedWithIndex:(NSInteger)index{
    self.camera = [RKCamera cameraWithType:index allowEdit:NO deleate:self presentViewController:self.view.window.rootViewController demandSize:CGSizeMake(100, 100) needFullImage:NO];
}

- (void)cameraWillFinishWithLowQualityImage:(UIImage *)lowQualityimage originQualityImage:(UIImage *)originQualityImage isCancel:(BOOL)isCancel{
    if(!isCancel){
        [self sendImageWithLowQualityImage:lowQualityimage originQualityImage:originQualityImage];
    }
}

- (void)sendImageWithLowQualityImage:(UIImage*)lowQualityImage originQualityImage:(UIImage *)originQualityImage{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeId = [NSString stringWithFormat:@"%llu", recordTime];
    NSData *imageData = UIImageJPEGRepresentation(originQualityImage, 1);
    if((double)imageData.length/(1024*1024)>5){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"图片不能大于5M" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [ChatImageSqlite InsertData:imageData imageId:timeId];
    [self addModelWithImage:lowQualityImage bigImageUrl:nil timestamp:timeId];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    [imageArr addObject:imageData];
    [ChatMessageApi AddImageWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [imageArr removeAllObjects];
            //NSLog(@"%@",posts[0][@"data"]);
            NSDictionary* messageDic = posts[0][@"data"];
            ChatMessageModel* model = [self findModelWithLocalId:messageDic[@"tempId"]];
            model.messageStatus = ChatMessageStatusSucess;
            model.a_id = messageDic[@"chatlogId"];
            [self.tableView reloadData];
        }else{
            ChatMessageModel* model = [self findModelWithLocalId:timeId];
            model.messageStatus = ChatMessageStatusFail;
            [self.tableView reloadData];
        }
    } dataArr:imageArr dic:[@{@"userId":self.contactId,@"userType":self.type,@"id":timeId} mutableCopy] noNetWork:^{
        ChatMessageModel* model = [self findModelWithLocalId:timeId];
        model.messageStatus = ChatMessageStatusFail;
        [self.tableView reloadData];
    }];
}

-(void)addModelWithContent:(NSString*)content timestamp:(NSString *)timestamp{
    ChatMessageModel* model=[[ChatMessageModel alloc]init];
    model.a_name=[LoginSqlite getdata:@"userName"];
    model.a_message=content;
    model.a_type=chatTypeMe;
    model.a_avatarUrl=[LoginSqlite getdata:@"userImage"];
    model.a_msgType = @"01";
    model.a_localId = timestamp;
    model.messageStatus = ChatMessageStatusProcess;
    NSDate* date=[NSDate date];
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString* time=[formatter stringFromDate:date];
    model.a_time=[ProjectStage ChatMessageTimeStage:time];
    
    [self.models addObject:model];
    [self appearNewData];
    [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(sendMessageTimeOut:) userInfo:@{@"timesId":timestamp} repeats:NO];
}

-(void)addModelWithImage:(UIImage *)image bigImageUrl:(NSString *)bigImageUrl timestamp:(NSString *)timestamp{
    ChatMessageModel *model = [[ChatMessageModel alloc] init];
    model.a_name=[LoginSqlite getdata:@"userName"];
    model.a_localImage = image;
    //model.a_localBigImageUrl = bigImageUrl;
    model.a_type=chatTypeMe;
    model.a_avatarUrl=[LoginSqlite getdata:@"userImage"];
    model.a_isLocal = YES;
    model.messageStatus = ChatMessageStatusProcess;
    model.a_localId = timestamp;
    NSDate* date=[NSDate date];
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString* time=[formatter stringFromDate:date];
    model.a_time=[ProjectStage ChatMessageTimeStage:time];
    
    model.a_imageWidth = image.size.width;
    model.a_imageHeight = image.size.height;
    model.a_msgType = @"02";
    [self.models addObject:model];
    [self appearNewData];
    [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(sendMessageTimeOut:) userInfo:@{@"timesId":timestamp} repeats:NO];
}

- (void)forwardMessageIdSuccess:(NSString *)messageId targetId:(NSString *)targetId{
    if (![self.contactId isEqualToString:targetId]) return;
    ChatMessageModel* model = [self findModelWithServerId:messageId];
    ChatMessageModel* newModel = [[ChatMessageModel alloc] init];
    newModel.a_type = chatTypeMe;
    newModel.dict = model.dict;
    
    NSDate* date=[NSDate date];
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString* time=[formatter stringFromDate:date];
    newModel.a_time=[ProjectStage ChatMessageTimeStage:time];
    
    [self.models addObject:newModel];
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

-(void)gotoBigImage:(NSInteger)index{
    NSLog(@"gotoBigImage");
    ChatMessageModel *model = self.models[index];
    if(!self.photoView){
        if(model.a_isLocal){
            NSData *imageData = [ChatImageSqlite loadList:model.a_localId];
            self.photoView = [[VIPhotoView alloc] initWithFrame:self.view.frame andImageData:imageData];
        }else{
            self.photoView = [[VIPhotoView alloc] initWithFrame:self.view.frame imageUrl:model.a_bigImageUrl];
        }
        self.photoView.bigImageDelegate = self;
        self.photoView.autoresizingMask = (1 << 6) -1;
        self.photoView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.photoView];
        self.navigationController.navigationBarHidden = YES;
    }
}

-(void)closeBigImage{
    [self.photoView removeFromSuperview];
    self.photoView = nil;
    self.navigationController.navigationBarHidden = NO;
}

-(void)sendMessageTimeOut:(NSTimer *)timer{
    NSLog(@"sendMessageTimeOut");
    NSString *localId = [timer userInfo][@"timesId"];
    NSLog(@"%@",localId);
    ChatMessageModel *model = [self findModelWithLocalId:localId];
    NSLog(@"%u",model.messageStatus);
    if(model.messageStatus != ChatMessageStatusSucess){
        model.messageStatus = ChatMessageStatusFail;
        [self.tableView reloadData];
    }
}
@end
