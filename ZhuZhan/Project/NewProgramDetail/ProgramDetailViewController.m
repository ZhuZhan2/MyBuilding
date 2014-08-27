//
//  ProgramDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-26.
//
//

#import "ProgramDetailViewController.h"
#import "ProjectApi.h"
#import "LandInfo.h"
#import "MainDesign.h"
#import "MainBuild.h"
#import "DecorationProject.h"
#import "MyIndexPath.h"
@interface ProgramDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ShowPageDelegate>
@property(nonatomic,strong)UIButton* backButton;
@property(nonatomic,strong)UITableView* contentTableView;
@property(nonatomic,strong)UITableView* selectTableView;

@property(nonatomic,strong)LandInfo* landInfo;//土地信息
@property(nonatomic,strong)MainDesign* mainDesign;//主体设计
@property(nonatomic,strong)MainBuild* mainBuild;//主体施工
@property(nonatomic,strong)DecorationProject* decorationProject;//装修

@property(nonatomic,strong)UILabel* bigStageLabel;//上导航中 大阶段label
@property(nonatomic,strong)UILabel* smallStageLabel;//上导航中 小阶段label
@property(nonatomic,strong)UIImageView* bigStageImageView;//上导航中大阶段图片

@property(nonatomic,strong)NSMutableArray* contents;
@end

@implementation ProgramDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [ProjectApi SingleProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            NSLog(@"==========%@",posts[0]);
            [self loadSelf];
        }else{
            
        }
    } projectId:self.ID];
}

-(void)loadSelf{
    [self initNavi];
    [self initTableView];
    [self initThemeView];
}

-(void)initTableView{
    self.landInfo=[LandInfo getLandInfoWithDelegate:self part:0];
    [[[self.landInfo.firstView.subviews[0] subviews][0]subviews][0] removeFromSuperview];
    
    self.contents=[NSMutableArray arrayWithObjects:self.landInfo.firstView,self.landInfo.secondView, nil];
    
    NSLog(@"%@",self.contents);
    
    self.contentTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, 320, 568-64-50) style:UITableViewStylePlain];
    self.contentTableView.delegate=self;
    self.contentTableView.dataSource=self;
    self.contentTableView.backgroundColor=RGBCOLOR(229, 229, 229);

    self.contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.contentTableView];
}

-(void)back{
    [self.backButton removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initNavi{
    self.backButton=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [self.backButton setImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.navigationController.navigationBar addSubview:self.backButton];
}

-(void)initThemeView{
    //画布themeView初始
    UIView* themeView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 50)];
    themeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:themeView];
    
    //大标题左边的大阶段图片
    UIImage* image=[UIImage imageNamed:@"XiangMuXiangQing/map@2x.png"];
    CGRect frame=CGRectMake(20, 12, image.size.width*.5, image.size.height*.5);
    self.bigStageImageView=[[UIImageView alloc]initWithFrame:frame];
    self.bigStageImageView.image=image;
    [themeView addSubview:self.bigStageImageView];
    
    //大阶段标题label
    self.bigStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 150, 30)];
    self.bigStageLabel.text=@"土地信息";
    self.bigStageLabel.font=[UIFont systemFontOfSize:16];
    [themeView addSubview:self.bigStageLabel];
    
    //小阶段标题label
    self.smallStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 110, 30)];
    self.smallStageLabel.text=@"土地规划/拍卖";
    self.smallStageLabel.textColor=[UIColor grayColor];
    self.smallStageLabel.font=[UIFont systemFontOfSize:14];
    self.smallStageLabel.textAlignment=NSTextAlignmentRight;
    [themeView addSubview:self.smallStageLabel];
    
    //右箭头imageView
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(280, 14, 25.5, 22.5)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing/more_02@2x.png"];
    [themeView addSubview:imageView];
    
    //上导航栏themeView第二部分,上导航下方阴影
    UIImageView* shadowView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 48.5, 320, 1.5)];
    shadowView.image=[UIImage imageNamed:@"XiangMuXiangQing/Shadow-top.png"];
    shadowView.alpha=.5;
    [themeView addSubview:shadowView];
    
    //使该view被点击可以触发
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [themeView addSubview:button];
}

-(void)change{
    NSLog(@"用户选择了筛选");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (cell.contentView.subviews.count) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [cell.contentView addSubview:self.contents[indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame=[self.contents[indexPath.row] frame];
    return frame.size.height;
}

//program大块 三行
-(NSArray*)getThreeLinesTitleViewWithThreeStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@"",@"",@""];
}
//图加图的数量
-(NSArray*)getImageViewWithImageAndCountWithIndexPath:(MyIndexPath*)indexPath{
    return @[0?@1:[UIImage imageNamed:@"首页_16.png"],[NSNumber numberWithInt:0]];
}

//第一行蓝，第二行黑的view
-(NSArray*)getBlueTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@"",@"",@""];
}

//联系人view
-(NSArray*)getThreeContactsViewThreeTypesFiveStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@[@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@""]];
}

//program大块 二行
-(NSArray*)getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@"",@""];
}

//硬件设备以及yes和no
-(NSArray*)getDeviceAndBoolWithDevicesAndBoolStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@"Yes",@"No",@"Yes",@"Yes",@"Yes"];
}

//第一行黑，第二行灰的view
-(NSArray*)getBlackTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    return  @[@"",@"",@""];
}

-(NSArray*)getOwnerTypeViewWithImageAndOwnersWithIndexPath:(MyIndexPath*)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
