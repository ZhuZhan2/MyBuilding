//
//  ChooseProductBigStage.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChooseProductBigStage.h"
#import "ChooseProductBigCell.h"
#import "AskPriceApi.h"
#import "CategoryModel.h"
@interface ChooseProductBigStage ()
@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic,strong)NSMutableArray* selectedArr;
@end

@implementation ChooseProductBigStage
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    [self loadList];
}

-(void)initNavi{
    self.title=@"请选择产品大类";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(void)loadList{
    [AskPriceApi GetChildsListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            for (int i=0; i<posts.count; i++) {
                CategoryModel *categoryModel = posts[i];
                ChooseProductCellModel* model=[[ChooseProductCellModel alloc]init];
                model.content=categoryModel.a_name;
                model.aid = categoryModel.a_id;
                [self.models addObject:model];
            }
            [self.tableView reloadData];
        }
    } parentId:@"0" noNetWork:nil];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}

-(NSMutableArray *)selectedArr{
    if(!_selectedArr){
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
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
    ChooseProductCellModel *model = self.models[indexPath.row];
    model.isHighlight=YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [AskPriceApi GetChildsListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            for (int i=0; i<posts.count; i++) {
                CategoryModel *categoryModel = posts[i];
                ChooseProductCellModel* model=[[ChooseProductCellModel alloc]init];
                model.content=categoryModel.a_name;
                model.aid = categoryModel.a_id;
                [self.selectedArr addObject:model];
            }
            if ([self.delegate respondsToSelector:@selector(chooseProductBigStage:catroyId:allClassificationArr:)]) {
                [self.delegate chooseProductBigStage:model.content catroyId:model.aid allClassificationArr:self.selectedArr];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } parentId:model.aid noNetWork:nil];
}
@end
