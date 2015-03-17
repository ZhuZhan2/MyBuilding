//
//  AskPriceViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "AskPriceViewController.h"
#import "RKStageChooseView.h"
#import "RKTwoView.h"
#import "AskPriceViewCell.h"
#import "ChooseProductBigStage.h"
@interface AskPriceViewController ()

@end

@implementation AskPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    [self initStageChooseView];
}

-(void)initTableView{
    [super initTableView];
    CGRect frame=self.tableView.frame;
    frame.origin.y+=48;
    frame.size.height-=48;
    self.tableView.frame=frame;
}

-(void)initStageChooseView{
    UIView* view=[RKStageChooseView stageChooseViewWithStages:
                  @[@"全部",@"进行中",@"已采纳",@"已关闭"]];
    CGRect frame=view.frame;
    frame.origin=CGPointMake(0, 64);
    view.frame=frame;
    
    [self.view addSubview:view];
}

-(void)initNavi{
    self.title=@"询价需求表";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AskPriceViewCell carculateTotalHeightWithContents:@[@"参与用户啊啊啊啊啊啊啊啊啊啊啊啊啊啊",@"水泥啊水泥",@"产品分类",@"程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班"]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AskPriceViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    cell.contents=@[@"参与用户啊啊啊啊啊啊啊啊啊啊啊啊啊啊",@"水泥啊水泥",@"产品分类",@"程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //[cell setModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseProductBigStage* vc=[[ChooseProductBigStage alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
