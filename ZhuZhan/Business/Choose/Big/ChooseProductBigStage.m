//
//  ChooseProductBigStage.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductBigStage.h"
#import "ChooseProductBigCell.h"
@interface ChooseProductBigStage ()
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation ChooseProductBigStage
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
}

-(void)initNavi{
    self.title=@"请选择产品大类";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
        for (int i=0; i<12; i++) {
            ChooseProductCellModel* model=[[ChooseProductCellModel alloc]init];
            model.content=@"得得得";
            [_models addObject:model];
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
    ChooseProductBigCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChooseProductBigCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model=self.models[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseProductCellModel* model=self.models[indexPath.row];
    model.isHighlight=YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if ([self.delegate respondsToSelector:@selector(chooseProductBigStage)]) {
        [self.delegate chooseProductBigStage];
    }
    //设计(魏清清)要停个0.3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
