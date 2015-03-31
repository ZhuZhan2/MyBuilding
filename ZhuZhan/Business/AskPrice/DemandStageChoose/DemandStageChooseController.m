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

-(instancetype)initWithIndex:(NSInteger)index stageNames:(NSArray*)stageNames{
    if (self=[super init]) {
        self.index=index;
        self.stageNames=stageNames;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stageNames.count;
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
        [self.delegate finishSelectedWithStageName:self.stageNames[indexPath.row] index:(int)indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
