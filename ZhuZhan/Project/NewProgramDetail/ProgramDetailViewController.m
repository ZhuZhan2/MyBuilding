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
#import "ProjectImageModel.h"
#import "ProjectContactModel.h"

@interface ProgramDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ShowPageDelegate,UIScrollViewDelegate>
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

@property(nonatomic,strong)UIActivityIndicatorView* animationView;//加载新view时的菊花动画
@property(nonatomic,strong)UIView* loadingView;
@property(nonatomic)BOOL isNeedAnimation;

@property(nonatomic)CGFloat loadNewViewStandardY;//判断是否需要加载新大阶段view的标准线

@end

@implementation ProgramDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [ProjectApi SingleProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            //            NSLog(@"==========%@",posts);
            //            //posts下标0是联系人数组 下标1是图片数组
            //            for(int i=0;i<[posts[0] count];i++){
            //                ProjectContactModel *contactModel = posts[0][i];
            //                NSLog(@"%@",contactModel.a_category);
            //            }
            //
            //            for(int i=0;i<[posts[1] count];i++){
            //                ProjectImageModel *imageModel = posts[1][i];
            //                NSLog(@"%@",imageModel.a_imageCategory);
            //            }
            //NSLog(@"==========%@",posts[0]);
            [self loadSelf];
        }else{
            
        }
    } projectId:self.ID];
}

-(void)loadSelf{
    [self initNavi];
    [self initLoadingView];
    [self initTableView];
    [self initThemeView];
    [self initAnimationView];
    
}

-(void)initLoadingView{
    self.loadingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    self.loadingView.backgroundColor=RGBCOLOR(229, 229, 229);
    UIImageView* shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3.5)];
    shadow.image=[UIImage imageNamed:@"XiangMuXiangQing/Shadow-bottom.png"];
    [self.loadingView addSubview:shadow];
}

-(void)initAnimationView{
    //动画view控制初始
    self.animationView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.animationView.color=[UIColor blackColor];
    [self.contentTableView addSubview:self.animationView];
    
    //是否需要动画初始
    self.isNeedAnimation=YES;
}

-(void)initTableView{
    self.landInfo=[LandInfo getLandInfoWithDelegate:self part:0];
    [[[self.landInfo.firstView.subviews[0] subviews][0]subviews][0] removeFromSuperview];
    
    self.contents=[NSMutableArray arrayWithObjects:self.landInfo.firstView,self.landInfo.secondView, self.loadingView,nil];
    
    //NSLog(@"%@",self.contents);
    
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

-(CGFloat)loadNewViewStandardY{
    if (!self.mainDesign) {
        return self.mainDesign.frame.size.height;
    }else if (!self.mainBuild){
        return self.mainBuild.frame.size.height+self.mainDesign.frame.size.height;
    }else if (!self.decorationProject){
        return  self.decorationProject.frame.size.height+self.mainBuild.frame.size.height+self.mainDesign.frame.size.height;
    }else{
        return CGFLOAT_MAX;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y+568-64-50>=scrollView.contentSize.height) {
        NSLog(@"0");
        if (!self.mainDesign) {
            NSLog(@"1");
            self.mainDesign=[MainDesign getMainDesignWithDelegate:self part:1];
            [self contentsAddObject:self.mainDesign scrollView:scrollView];
        }else if (!self.mainBuild){
            NSLog(@"2");
            self.mainBuild=[MainBuild getMainBuildWithDelegate:self part:2];
            [self contentsAddObject:self.mainBuild scrollView:scrollView];
        }else if(!self.decorationProject){
            NSLog(@"3");
            self.decorationProject=[DecorationProject getDecorationProjectWithDelegate:self part:3];
            [self contentsAddObject:self.decorationProject scrollView:scrollView];
        }
    }
}

-(void)contentsAddObject:(UIView*)view scrollView:(UIScrollView*)scrollView{
    //将内容添加进cell的内容数组
    [self.contents removeLastObject];
    for (int i=0; i<view.subviews.count; i++) {
        [self.contents addObject:view.subviews[i]];
    }
    [self.contents addObject:self.loadingView];
    
    //根据是否需要动画情况进行加载
    if (self.isNeedAnimation) {
        self.animationView.center=CGPointMake(160, scrollView.contentSize.height-25);
        if (!self.animationView.isAnimating) {
            [self.animationView startAnimating];
        }
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(add) userInfo:nil repeats:NO];
    }else{
        [self.contentTableView reloadData];
    }
    
}

-(void)add{
    if (self.animationView.isAnimating) {
        [self.animationView stopAnimating];
    }
    [self.contentTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contents.count;
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
    return @[@"111",@"111",@"111"];
}
//图加图的数量
-(NSArray*)getImageViewWithImageAndCountWithIndexPath:(MyIndexPath*)indexPath{
    return @[0?@1:[UIImage imageNamed:@"首页_16.png"],[NSNumber numberWithInt:0]];
}

//第一行蓝，第二行黑的view
-(NSArray*)getBlueTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.section==0) {
        return @[@"111",@"111",@"111"];
    }else{
        return @[@"111",@"111",@"111",@"111",@"111",@"111"];
    }
}

//联系人view
-(NSArray*)getThreeContactsViewThreeTypesFiveStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@[@"111",@"111",@"111",@"111",@"111"],@[@"111",@"111",@"111",@"111",@"111"],@[@"111",@"111",@"111",@"111",@"111"]];
}

//program大块 二行
-(NSArray*)getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@"111",@"111"];
}

//硬件设备以及yes和no
-(NSArray*)getDeviceAndBoolWithDevicesAndBoolStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[@"Yes",@"No",@"Yes",@"Yes",@"Yes"];
}

//第一行黑，第二行灰的view
-(NSArray*)getBlackTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    return  @[@"111",@"111",@"111"];
}

-(NSArray*)getOwnerTypeViewWithImageAndOwnersWithIndexPath:(MyIndexPath*)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
