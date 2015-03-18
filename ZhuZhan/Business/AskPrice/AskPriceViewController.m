//
//  AskPriceViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import "AskPriceViewController.h"
#import "RKStageChooseView.h"
#import "RKTwoView.h"
#import "AskPriceViewCell.h"
#import "ChooseProductBigStage.h"
#import "ChooseProductSmallStage.h"
@interface AskPriceViewController ()

@end

@implementation AskPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseView];
    [self initTableView];
}

-(void)initTableView{
    [super initTableView];
    CGRect frame=self.tableView.frame;
    frame.origin.y+=48;
    frame.size.height-=48;
    self.tableView.frame=frame;
}

-(void)initStageChooseView{
    UIView* view=[RKStageChooseView stageChooseViewWithStages:
                  @[@"全部",@"进行中",@"已采纳",@"已关闭"]];
    CGRect frame=view.frame;
    frame.origin=CGPointMake(0, 64);
    view.frame=frame;
    
    [self.view addSubview:view];
}

-(void)initNavi{
//    self.title=@"询价需求表";
    NSString* titleStr=@"需求表";
    UIFont* font=[UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    UILabel* titleLabel=[[UILabel alloc]init];
    titleLabel.text=titleStr;
    titleLabel.font=font;
    titleLabel.textColor=[UIColor whiteColor];
    CGSize size=[titleStr boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    titleLabel.frame=CGRectMake(0, 0, size.width, size.height);
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, 20, 20)];
    imageView.backgroundColor=[UIColor whiteColor];
    
    CGRect frame=titleLabel.frame;
    frame.size.width+=CGRectGetWidth(imageView.frame);
    
    UIButton* button=[[UIButton alloc]initWithFrame:frame];
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:titleLabel];
    [button addSubview:imageView];
    
    self.navigationItem.titleView=button;
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AskPriceViewCell carculateTotalHeightWithContents:@[@"参与用户啊啊啊啊啊啊啊啊啊啊啊啊啊啊",@"水泥啊水泥",@"产品分类",@"程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班"]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AskPriceViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    cell.contents=@[@"参与用户啊啊啊啊啊啊啊啊啊啊啊啊啊啊",@"水泥啊水泥",@"产品分类",@"程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班,程序不做完，产品设计一起加班"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //[cell setModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (arc4random()%2) {
        ChooseProductBigStage* vc=[[ChooseProductBigStage alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChooseProductSmallStage* vc=[[ChooseProductSmallStage alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
