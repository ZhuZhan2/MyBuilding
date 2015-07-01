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

@interface ForwardListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *modelsArr;
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
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 22)];
    //[leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [rightButton setTitle:@"创建" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)rightBtnClick{
    ChooseContactsViewController* vc = [[ChooseContactsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
@end
