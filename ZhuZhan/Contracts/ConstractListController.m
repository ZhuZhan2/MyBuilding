//
//  ConstractListController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ConstractListController.h"
#import "ContractListCell.h"
#import "ContractsBaseViewController.h"
#import "DemandStageChooseController.h"
#import "ContractsListSearchController.h"
#import "OverProvisionalViewController.h"

@interface ConstractListController ()<DemandStageChooseControllerDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property (nonatomic)NSInteger nowStage;
@end

@implementation ConstractListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"全部",@"待审核",@"待确认",@"已关闭",@"已完成"]  numbers:nil];
    [self initTableView];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithImage:[GetImagePath getImagePath:@"搜索按钮"]];
    [self initTitleViewWithTitle:@"佣金合同列表"];
}

-(void)initTitleViewWithTitle:(NSString*)title{
    NSString* titleStr=title;
    UIFont* font=[UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    UILabel* titleLabel=[[UILabel alloc]init];
    titleLabel.text=titleStr;
    titleLabel.font=font;
    titleLabel.textColor=[UIColor whiteColor];
    CGSize size=[titleStr boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    titleLabel.frame=CGRectMake(0, 0, size.width, size.height);
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, 15, 9)];
    imageView.center=CGPointMake(CGRectGetMaxX(titleLabel.frame)+CGRectGetWidth(imageView.frame)*0.5+5, CGRectGetMidY(titleLabel.frame));
    imageView.image=[GetImagePath getImagePath:@"交易_页头箭头"];
    
    CGRect frame=titleLabel.frame;
    frame.size.width+=CGRectGetWidth(imageView.frame);
    
    UIButton* button=[[UIButton alloc]initWithFrame:frame];
    [button addTarget:self action:@selector(selectStage) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:titleLabel];
    [button addSubview:imageView];
    
    self.navigationItem.titleView=button;
}

-(void)selectStage{
    DemandStageChooseController* vc=[[DemandStageChooseController alloc]initWithIndex:self.nowStage stageNames:@[@"全部佣金合同",@"主要合同条款",@"供应商佣金合同",@"销售佣金合同"]];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightBtnClicked{
    UIViewController* vc=[[ContractsListSearchController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:YES completion:nil];
}

-(NSMutableArray *)showArr{
    if (!_showArr) {
        _showArr=[NSMutableArray array];
        for (int i=0;i<15;i++) {
            [_showArr addObject:@[@"发起者",@"接收者",@"甲  方",@"乙  方",@"金  额",@"合同条款",@"状态"]];
        }
    }
    return _showArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ContractListCell carculateTotalHeightWithContents:self.showArr[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ContractListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    cell.contents=self.showArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        ContractsBaseViewController* vc=[[ContractsBaseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        OverProvisionalViewController *overView = [[OverProvisionalViewController alloc] initWithIsMainView:YES];
        [self.navigationController pushViewController:overView animated:YES];
    }
}

-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    self.nowStage=stageNumber;
}

-(void)finishSelectedWithStageName:(NSString *)stageName index:(int)index{
    self.nowStage=index;
    [self initTitleViewWithTitle:stageName];
}
@end
