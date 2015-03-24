//
//  RKDemandChatController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "RKDemandChatController.h"
#import "DemandChatViewCell.h"
#import "AskPriceApi.h"
@interface RKDemandChatController ()

@end

@implementation RKDemandChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initChatToolBar];
    [self addKeybordNotification];
    [self loadList];
}

-(void)loadList{
    [AskPriceApi GetCommentListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            
        }
    } tradeId:self.askPriceModel.a_id tradeUserAndCommentUser:[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId] startIndex:0 noNetWork:nil];
}

-(void)initTableView{
    CGFloat y=64+46;
    CGFloat height=kScreenHeight-y;
    self.tableView=[[RKBaseTableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=AllBackDeepGrayColor;
}

-(NSMutableArray *)chatModels{
    if (!_chatModels) {
        _chatModels=[NSMutableArray array];
        for (int i=0; i<8; i++) {
            DemandChatViewCellModel* model=[[DemandChatViewCellModel alloc]init];
            model.userName=@"用户名啊用户名啊用户名啊";
            model.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
            model.time=@"2015-01-23 11:47";
            model.isSelf=arc4random()%2;
            model.content=@"内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!";
            [_chatModels addObject:model];
        }
    }
    return _chatModels;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DemandChatViewCell carculateTotalHeightWithModel:self.chatModels[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandChatViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    if (!cell) {
        cell=[[DemandChatViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
    }
    DemandChatViewCellModel* model=self.chatModels[indexPath.row];
    cell.model=model;
    return cell;
}
-(void)viewWillDisappear:(BOOL)animated{

}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)chatToolSendBtnClicked{
    NSLog(@"22");
}
@end
