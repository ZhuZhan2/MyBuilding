//
//  ChooseProductSmallStage.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductSmallStage.h"
#import "ChooseProductSmallCell.h"

@interface ChooseProductSmallStage ()
@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic,strong)NSMutableArray* selectedArr;
@end

@implementation ChooseProductSmallStage
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    //[self setUpSearchBarWithNeedTableView:YES];
    [self initTableView];
}

-(void)initNavi{
    self.title=@"请选择产品大类";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"确定"];
}

-(void)rightBtnClicked{
    NSArray * arr1 = @[@""];
    NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
    NSArray * filter = [self.selectedArr filteredArrayUsingPredicate:filterPredicate];
    if([self.delegate respondsToSelector:@selector(chooseProductSmallStage:)]){
        [self.delegate chooseProductSmallStage:filter];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSMutableArray *)selectedArr{
    if(!_selectedArr){
        _selectedArr = [[NSMutableArray alloc] init];
    }
    return _selectedArr;
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
        for (int i=0; i<12; i++) {
            ChooseProductCellModel* model=[[ChooseProductCellModel alloc]init];
            model.content=@"得得得";
            [_models addObject:model];
            [self.selectedArr addObject:@""];
        }
    }
    return _models;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseProductSmallCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChooseProductSmallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model=self.models[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseProductCellModel* model=self.models[indexPath.row];
    model.isHighlight=!model.isHighlight;
    if(model.isHighlight){
        [self.selectedArr insertObject:model.content atIndex:indexPath.row];
    }else{
        [self.selectedArr removeObjectAtIndex:indexPath.row];
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
