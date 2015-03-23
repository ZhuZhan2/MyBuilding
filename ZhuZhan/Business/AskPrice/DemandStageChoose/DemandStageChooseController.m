//
//  DemandStageChooseController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "DemandStageChooseController.h"
#import "DemandStageCell.h"
@interface DemandStageChooseController ()

@end

@implementation DemandStageChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
}

-(void)initNavi{
    self.title=@"需求列表分类";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandStageCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[DemandStageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    DemandStageCellModel* model=[[DemandStageCellModel alloc]init];
    
    model.stageName=@[@"全部需求列表",@"报价需求列表",@"询价需求列表"][indexPath.row];
    model.isHighlight=indexPath.row%2;
    cell.model=model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(finishSelectedWithStageName:)]) {
        [self.delegate finishSelectedWithStageName:@[@"全部需求列表",@"报价需求列表",@"询价需求列表"][indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
