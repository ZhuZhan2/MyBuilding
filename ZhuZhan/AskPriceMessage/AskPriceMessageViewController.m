//
//  AskPriceMessageViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import "AskPriceMessageViewController.h"
#import "AskPriceMessageCell.h"
#import "AskPriceMessageModel.h"
#import "MJRefresh.h"
@interface AskPriceMessageViewController ()
@property(nonatomic,strong)NSMutableArray *showArr;
@end

@implementation AskPriceMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"询价提醒",@"报价提醒",@"合同提醒"]  numbers:nil];
    [self initTableView];
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
}

- (void)footerRereshing
{
    
}

-(void)initNavi{
    self.title = @"交易提醒";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.needAnimaiton=YES;
}

-(NSMutableArray *)showArr{
    if(!_showArr){
        _showArr = [[NSMutableArray alloc] init];
        for(int i=0;i<10;i++){
            AskPriceMessageModel *model = [[AskPriceMessageModel alloc] init];
            model.a_title = @"您有一个报价提醒";
            model.a_time = @"2014-09-23";
            if(i%3==0){
                model.a_content = @"阿斯顿发送到发送到阿士大夫撒打发士大夫啊";
            }else if (i%3==1){
                model.a_content = @"阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊";
            }else{
                model.a_content = @"阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊阿斯顿发送到发送到阿士大夫撒打发士大夫啊";
            }
            [_showArr addObject:model];
        }
    }
    return _showArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    CGSize cellSize = [AskPriceMessageCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<CellHeightDelegate> cellToSetup) {
        AskPriceMessageModel *model = self.showArr[indexPath.row];
        [((AskPriceMessageCell *)cellToSetup) setModel:model];
        return cellToSetup;
    }];
    return cellSize.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceMessageCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AskPriceMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    AskPriceMessageModel *model = self.showArr[indexPath.row];
    cell.model = model;
    return cell;
}
@end
