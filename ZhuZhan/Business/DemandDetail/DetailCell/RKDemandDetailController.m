//
//  RKDemandDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "RKDemandDetailController.h"


@interface RKDemandDetailController ()

@end

@implementation RKDemandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self reloadTableViewExtra];
    NSLog(@"detailModels ===>%@",self.detailModels);
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
