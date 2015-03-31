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
@property (nonatomic)NSInteger index;
@property (nonatomic, strong)NSArray* stageNames;
@end

@implementation DemandStageChooseController

-(instancetype)initWithIndex:(NSInteger)index{
    if (self=[super init]) {
        self.index=index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
}

-(void)initNavi{
    self.title=self.stageNames[self.index];
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSArray *)stageNames{
    if (!_stageNames) {
        _stageNames=@[@"全部需求列表",@"报价需求列表",@"询价需求列表"];
    }
    return _stageNames;
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
    
    model.stageName=self.stageNames[indexPath.row];
    model.isHighlight=self.index==indexPath.row;
    cell.model=model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(finishSelectedWithStageName:index:)]) {
        [self.delegate finishSelectedWithStageName:@[@"全部需求列表",@"报价需求列表",@"询价需求列表"][indexPath.row] index:(int)indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
