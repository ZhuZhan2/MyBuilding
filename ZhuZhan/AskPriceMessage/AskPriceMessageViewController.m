//
//  AskPriceMessageViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import "AskPriceMessageViewController.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavi{
    self.title = @"交易提醒";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.needAnimaiton=YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    return cell;
}
@end
