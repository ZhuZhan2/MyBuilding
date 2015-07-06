//
//  ForwardListViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/7/1.
//
//

#import "ForwardListViewController.h"
#import "ChatMessageApi.h"
#import "ChatListViewCell.h"
#import "MyTableView.h"
#import "ForwardListCell.h"
#import "ForwardChooseContactsController.h"
@interface ForwardListViewController ()<UITableViewDelegate,UITableViewDataSource,ForwardChooseContactsControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *modelsArr;

@property (nonatomic, copy)NSString* targetId;
@end

@implementation ForwardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    [self.view addSubview:self.tableView];
    [self loadList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 50, 22)];
    //[leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    }
    return _tableView;
}

-(NSMutableArray *)modelsArr{
    if(!_modelsArr){
        _modelsArr = [NSMutableArray array];
    }
    return _modelsArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }else{
        return 20;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    customView.backgroundColor = AllBackLightGratColor;
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 20)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.text = @"最近聊天";
    headerLabel.font = [UIFont systemFontOfSize:12];
    headerLabel.textColor = AllLightGrayColor;
    
    [customView addSubview:headerLabel];
    
    return customView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return self.modelsArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"创建新的聊天";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ForwardListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ForwardListCell"];
        if (!cell) {
            cell=[[ForwardListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ForwardListCell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        ChatListModel* model=self.modelsArr[indexPath.row];
        cell.model = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ForwardChooseContactsController* vc = [[ForwardChooseContactsController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    ChatListModel* model = self.modelsArr[indexPath.row];
    NSString* targetId = [model.a_type isEqualToString:@"01"]?model.a_loginId:model.a_groupId;
    NSString* targetName = [model.a_type isEqualToString:@"01"]?model.a_loginName:model.a_groupName;
    [self forwardMessageToTargetId:targetId targetName:targetName];
}

-(void)loadList{
    [ChatMessageApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.modelsArr = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
    } noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)forwardChooseTargetId:(NSString *)targetId isGroup:(BOOL)isGroup targetName:(NSString *)targetName{
    [self forwardMessageToTargetId:targetId targetName:targetName];
}

- (void)forwardMessageToTargetId:(NSString*)targetId targetName:(NSString*)targetName{
    self.targetId = targetId;
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"确定发送给：" message:targetName delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex != 1) return;
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        [dic setObject:self.messageId forKey:@"chatlogIds"];
        [dic setObject:self.targetId forKey:@"forword"];
        
        [ChatMessageApi forwardWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"转发成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertView.tag = 2;
                [alertView show];
                if ([self.delegate respondsToSelector:@selector(forwardMessageIdSuccess:targetId:)]) {
                    [self.delegate forwardMessageIdSuccess:self.messageId targetId:self.targetId];
                }
            }
        } dic:dic noNetWork:nil];
    }else if (alertView.tag == 2){
        [self leftBtnClick];
    }
}
@end
