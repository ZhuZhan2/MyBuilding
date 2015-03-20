//
//  RKDemandDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "RKDemandDetailController.h"
#import "DemandDetailViewCell.h"
#import "ProvidePriceInfoController.h"


@interface RKDemandDetailController ()<DemandDetailViewCellDelegate>

@end

@implementation RKDemandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self reloadTableViewExtra];
}

-(void)initTableView{
    CGFloat y=64+46;
    CGFloat height=kScreenHeight-y;
    self.tableView=[[RKBaseTableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)reloadTableViewExtra{
    self.tableView.backgroundColor=AllBackDeepGrayColor;
    CGFloat tableFooterSpaceHeight=24;
    CGFloat shadowHeight=10;
    CGFloat btnHeight=37;
    CGFloat btnWidth=294;
    CGFloat btnX=(kScreenWidth-btnWidth)/2;
    CGFloat btnY=tableFooterSpaceHeight-shadowHeight;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, tableFooterSpaceHeight*2-shadowHeight+btnHeight)];
    view.backgroundColor=AllBackDeepGrayColor;
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnHeight)];
    [btn setBackgroundImage:[GetImagePath getImagePath:@"关--闭"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    self.tableView.tableFooterView=view;
}

-(NSMutableArray *)detailModels{
    if (!_detailModels) {
        _detailModels=[NSMutableArray array];
        for (int i=0; i<8; i++) {
            DemandDetailCellModel* model=[[DemandDetailCellModel alloc]init];
            model.userName=@"用户名啊用户名啊用户名啊";
            model.userDescribe=@"用户描述啊用户描述啊用户描述啊用";
            model.time=@"2015-01-23 11:47";
            model.numberDescribe=@"第N次报价";
            model.content=@"内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!内容啊内容，内容啊内容，这遥遥无期的代码，写到何处方到尽头啊啊啊啊啊啊啊啊啊啊!";
            model.array1=@[@"",@""];
            model.array2=@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
            model.array3=@[];
            
            [_detailModels addObject:model];
        }
    }
    return _detailModels;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DemandDetailViewCell carculateTotalHeightWithModel:self.detailModels[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self];
    }
    DemandDetailCellModel* model=self.detailModels[indexPath.row];
    model.indexPath=indexPath;
    cell.model=model;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"leftBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    ProvidePriceInfoController* vc=[[ProvidePriceInfoController alloc]init];
    [self.superViewController.navigationController pushViewController:vc animated:YES];
    NSLog(@"rightBtnClicked,indexPath==%d",(int)indexPath.row);
}

-(void)closeBtnClicked{
    NSLog(@"closeBtnClicked");
}

-(void)viewWillDisappear:(BOOL)animated{

}

-(void)viewWillAppear:(BOOL)animated{

}
@end
