//
//  AskPriceDetailViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/21.
//
//

#import "AskPriceDetailViewController.h"
#import "CatoryTableViewCell.h"
#import "ClassificationView.h"
@interface AskPriceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)ClassificationView *classificationView;
@property(nonatomic)int classificationViewHeight;
@end

@implementation AskPriceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showArr = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate =self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = AllBackLightGratColor;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(ClassificationView *)classificationView{
    if(!_classificationView){
        _classificationView = [[ClassificationView alloc] init];
        [_classificationView GetHeightWithBlock:^(double height) {
            _classificationView.frame = CGRectMake(0, 0, 320, height);
            self.classificationViewHeight = height;
        } str:@"阿斯顿发生法士大阿斯顿发送到发沙发沙发沙发法撒旦法师打发士大夫撒飞洒发生发送到发送到发送到发送到法撒旦法师打"];
    }
    return _classificationView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3+self.showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 70;
    }else if (indexPath.row == 1){
        return self.classificationViewHeight;
    }else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"CatoryTableViewCell"];
        CatoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[CatoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        //cell.catoryStr = self.askPriceModel.a_productBigCategory;
        cell.catoryStr = @"分类";
        return cell;
    }else if(indexPath.row == 1){
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:self.classificationView];
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        return cell;
    }
    return nil;
}
@end
