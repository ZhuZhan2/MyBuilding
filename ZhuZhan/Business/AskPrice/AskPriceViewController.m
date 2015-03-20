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
#import "DemanDetailViewController.h"
#import "AskPriceApi.h"
@interface AskPriceViewController ()
@property(nonatomic,strong)NSString *statusStr;
@end

@implementation AskPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusStr = @"";
    [self initNavi];
    [self loadList];
    [self initStageChooseViewWithStages:@[@"全部",@"进行中",@"已采纳",@"已关闭"]  numbers:@[@"99",@"88",@"0",@"1111"]];

    [self setUpSearchBarWithNeedTableView:NO isTableViewHeader:YES];
    [self initTableView];
    [self initTableViewHeader];
    self.tableView.backgroundColor=AllBackDeepGrayColor;
}

-(void)loadList{
    [AskPriceApi GetAskPriceWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            NSLog(@"%@,%@",posts[0],posts[1]);
        }
    } status:self.statusStr startIndex:0 noNetWork:nil];
}

-(void)initTableViewHeader{
    CGRect frame=self.searchBar.frame;
    frame.origin=CGPointZero;
    self.searchBar.frame=frame;
    self.tableView.tableHeaderView=self.searchBar;
}

-(void)initNavi{
    [self initTitleViewWithTitle:@"全部需求表"];
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
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
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, 15, 7)];
    imageView.center=CGPointMake(CGRectGetMaxX(titleLabel.frame)+CGRectGetWidth(imageView.frame)*0.5+5, CGRectGetMidY(titleLabel.frame));
    imageView.image=[GetImagePath getImagePath:@"导航下三角"];
    
    CGRect frame=titleLabel.frame;
    frame.size.width+=CGRectGetWidth(imageView.frame);
    
    UIButton* button=[[UIButton alloc]initWithFrame:frame];
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:titleLabel];
    [button addSubview:imageView];
    
    self.navigationItem.titleView=button;
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
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DemanDetailViewController* vc=[[DemanDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    if (indexPath.row%2) {
        ChooseProductBigStage* vc=[[ChooseProductBigStage alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChooseProductSmallStage* vc=[[ChooseProductSmallStage alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
