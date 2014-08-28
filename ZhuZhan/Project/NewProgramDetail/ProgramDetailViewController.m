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
#import "EGOImageView.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProgramSelectViewCell.h"
#import "ViewController.h"
@interface ProgramDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ShowPageDelegate,UIScrollViewDelegate,ProgramSelectViewCellDelegate>
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

//以下4属性用于sectionHeader被点击时所需要传参数时用的东西
@property(nonatomic,strong)NSMutableArray* sectionButtonArray;

@property(nonatomic,strong)NSMutableArray* bigStageStandardY;
@property(nonatomic,strong)NSMutableArray* smallStageStandardY;

@end

@implementation ProgramDetailViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [ProjectApi SingleProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.model getContacts:posts[0]];
            [self.model getImages:posts[1]];
            [self loadSelf];
        }else{

        }
    } projectId:self.model.a_id];
}

-(void)loadSelf{
    [self initNavi];
    [self initLoadingView];
    [self initContentTableView];
    [self initThemeView];
    [self initAnimationView];
    [self initSelectTableView];
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

-(void)initContentTableView{
    self.landInfo=[LandInfo getLandInfoWithDelegate:self part:0];
    [[[self.landInfo.firstView.subviews[0] subviews][0]subviews][0] removeFromSuperview];
//    self.contents=[NSMutableArray arrayWithObjects:self.landInfo.firstView,self.landInfo.secondView, self.loadingView,nil];
    self.contents=[[NSMutableArray alloc]init];
    [self contentsAddObject:self.landInfo];
    
    self.contentTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, 320, 568-64-50) style:UITableViewStylePlain];
    self.contentTableView.delegate=self;
    self.contentTableView.dataSource=self;
    self.contentTableView.backgroundColor=RGBCOLOR(229, 229, 229);
    
    self.contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.contentTableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.contentTableView];
}

-(void)back{
    //[self.backButton removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initNavi{
    self.backButton=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [self.backButton setImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.backButton];//[[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    //[self.navigationController.navigationBar addSubview:self.backButton];
    
    self.navigationItem.title=@"项目详情";
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

-(void)initSelectTableView{
    self.selectTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64) style:UITableViewStylePlain];
    self.selectTableView.delegate=self;
    self.selectTableView.dataSource=self;
    self.selectTableView.center=CGPointMake(160, -(568-64)*.5);
    [self.selectTableView registerClass:[ProgramSelectViewCell class] forCellReuseIdentifier:@"Cell"];
    self.selectTableView.showsVerticalScrollIndicator=NO;
    self.selectTableView.scrollEnabled=NO;
    self.selectTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.selectTableView.backgroundColor=[UIColor colorWithWhite:1 alpha:.95];
    
    [self.view addSubview:self.selectTableView];
    //用于存放使sectionHeader可以被点击的button的array
    self.sectionButtonArray=[NSMutableArray array];
}

//**********************************************************************
//**********************************************************************
//**********************************************************************

-(void)change{
    NSLog(@"用户选择了筛选");
    self.isNeedAnimation=NO;
    //暂时移除观察者,避免加新view时有动画
    [self.view addSubview:self.selectTableView];
    [UIView animateWithDuration:0.5 animations:^{
        self.selectTableView.center=CGPointMake(160, (568-64.5)*.5+64.5);
    }];
}

-(CGFloat)loadNewViewStandardY{
    if (!self.mainDesign) {
        return self.landInfo.frame.size.height+56;
    }else if (!self.mainBuild){
        return self.landInfo.frame.size.height+self.mainDesign.frame.size.height+56;
    }else if (!self.decorationProject){
        return  self.landInfo.frame.size.height+self.mainDesign.frame.size.height+self.mainBuild.frame.size.height+56;
    }else{
        return CGFLOAT_MAX;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y+568-64-50>=self.loadNewViewStandardY) {
        if (!self.mainDesign) {
            self.mainDesign=[MainDesign getMainDesignWithDelegate:self part:1];
            [self addNewView:self.mainDesign scrollView:scrollView];
        }else if (!self.mainBuild){
            self.mainBuild=[MainBuild getMainBuildWithDelegate:self part:2];
            [self addNewView:self.mainBuild scrollView:scrollView];
        }else if(!self.decorationProject){
            self.decorationProject=[DecorationProject getDecorationProjectWithDelegate:self part:3];
            [self addNewView:self.decorationProject scrollView:scrollView];
        }
    }
    
    NSArray* smallTitles=@[@"土地规划/拍卖",@"项目立项",@"地勘阶段",@"设计阶段",@"出图阶段",@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化",@""];
    NSArray* bigTitles=@[@"土地信息",@"主体设计阶段",@"主体施工阶段",@"装修阶段"];
    NSArray* bigStageImageNames=@[@"XiangMuXiangQing/map@2x.png",@"XiangMuXiangQing_1/pen_01@2x.png",@"XiangMuXiangQing_2/Subject_01@2x.png",@"XiangMuXiangQing_3/paint_01@2x.png"];
    
    for (int i=0; i<self.bigStageStandardY.count; i++) {
        if (scrollView.contentOffset.y+568-64-50<[self.bigStageStandardY[i] floatValue]) {
            //大阶段名称
            self.bigStageLabel.text=bigTitles[i];
            
            //大阶段左边图标
            UIImage* image=[UIImage imageNamed:bigStageImageNames[i]];
            CGPoint center=self.bigStageImageView.center;
            CGRect frame=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
            self.bigStageImageView.frame=frame;
            self.bigStageImageView.image=image;
            self.bigStageImageView.center=center;
            
            break;
        }
    }
    
    for (int i=0; i<self.smallStageStandardY.count; i++) {
        //小阶段名称
        if (scrollView.contentOffset.y+568-64-50<[self.smallStageStandardY[i] floatValue]) {
            self.smallStageLabel.text=smallTitles[i];
            break;
        }
    }
}

-(void)addNewView:(UIView*)view scrollView:(UIScrollView*)scrollView{
    //根据是否需要动画情况进行加载
    if (self.isNeedAnimation) {
        self.animationView.center=CGPointMake(160, scrollView.contentSize.height-40);
        if (!self.animationView.isAnimating) {
            [self.animationView startAnimating];
        }
        
        //动画区域显示正在加载哪个view的label
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        NSString* tempStr;
        if (view==self.mainDesign) {
            tempStr=@"主体设计";
        }else if(view==self.mainBuild){
            tempStr=@"主体施工";
        }else{
            tempStr=@"装修";
        }
        tempStr=[NSString stringWithFormat:@"正在加载 %@ 阶段",tempStr];
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(82, 125, 237) range:NSMakeRange(4, tempStr.length-6)];
        label.attributedText=[attStr copy];
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentCenter;
        label.center=CGPointMake(160, self.contentTableView.contentSize.height-20);
        [self.contentTableView addSubview:label];


        CGRect frame=self.animationView.frame;
        frame.size.height+=.000001;
        [UIView animateWithDuration:2 animations:^{
            self.animationView.frame=frame;
        } completion:^(BOOL finished) {
            if (self.animationView.isAnimating) {
                [self.animationView stopAnimating];
            }
            [label removeFromSuperview];
            [self contentsAddObject:view];
        }];
    }else{
        //将内容添加进cell的内容数组
        [self contentsAddObject:view];
    }
}

-(void)contentsAddObject:(UIView*)view{
    //用于判断现在是哪个大阶段和小阶段的标准线
    if (!self.bigStageStandardY) {
        self.bigStageStandardY=[[NSMutableArray alloc]init];
        self.smallStageStandardY=[[NSMutableArray alloc]init];
    }
    
    CGFloat height=0;
    for (int i=0; i<view.subviews.count; i++) {
        height+=[view.subviews[i] frame].size.height;
        CGFloat tempHeight=self.bigStageStandardY.count>0?[self.bigStageStandardY.lastObject floatValue]:0;
        
        [self.smallStageStandardY addObject:[NSNumber numberWithFloat:(tempHeight+height)]];
    }
    
    height=0;
    height=self.bigStageStandardY.count?[self.bigStageStandardY.lastObject floatValue]:0;
    height+=view.frame.size.height;
    [self.bigStageStandardY addObject:[NSNumber numberWithFloat:height]];

    
    if (self.contents.count) {
        [self.contents removeLastObject];
    }
    for (int i=0; i<view.subviews.count; i++) {
        [self.contents addObject:view.subviews[i]];
    }
    if (view!=self.decorationProject) {
        [self.contents addObject:self.loadingView];
    }
    if (view!=self.landInfo) {
        [self.contentTableView reloadData];
    }
}

//筛选界面拉回去
-(void)selectCancel{
    self.isNeedAnimation=YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.selectTableView.center=CGPointMake(160, -(568-64)*.5);
    } completion:^(BOOL finished){
        [self.selectTableView removeFromSuperview];
    }];
}

//**********************************************************************
//**********************************************************************
//**********************************************************************

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
    }else{
        //为了让sectionHeader可以被点击,所以将cell被点击之后实现的跳转加载功能封装到其他方法
        [self didchangeStageSection:indexPath.section row:indexPath.row];
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray* path=@[@"XiangMuXiangQing_ShaiXuan/map@2x.png",@"XiangMuXiangQing_ShaiXuan/pen_01@2x.png",@"XiangMuXiangQing_2/Subject_01@2x.png",@"XiangMuXiangQing_3/paint_01@2x.png"];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    
    UIImage* image=[UIImage imageNamed:path[section]];
    CGRect frame=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.center=CGPointMake(23.5, 37.5*.5);
    imageView.image=image;
    [view addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(47, 12, 200, 16)];
    NSArray* ary=@[@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段"];
    label.text=ary[section];
    label.font=[UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(47, 36.5, 273, 1)];
    separatorLine.backgroundColor=RGBCOLOR(96, 96, 96);
    [view addSubview:separatorLine];
    
    //使该sectionHeader可以被点击
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    [button addTarget:self action:@selector(selectSection:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.sectionButtonArray addObject:button];
    
    return view;
}

//判断用户点击的是哪个sectionHeader,然后将section传过去
-(void)selectSection:(id)button{
    NSLog(@"%d",[self.sectionButtonArray indexOfObject:button]);
    [self didchangeStageSection:[self.sectionButtonArray indexOfObject:button] row:0];
}

-(void)didchangeStageSection:(NSInteger)section row:(NSInteger)row{
    NSLog(@"%f",self.contentTableView.contentOffset.y);
    for (int i=1; i<=section; i++) {//土地信息阶段必存在，不用判断和操作
        if (!self.mainDesign&&i==1) {
            //加载主体设计
            self.mainDesign=[MainDesign getMainDesignWithDelegate:self part:1];
            [self addNewView:self.mainDesign scrollView:self.contentTableView];
            
        }else if(!self.mainBuild&&i==2){
            //加载主体施工
            self.mainBuild=[MainBuild getMainBuildWithDelegate:self part:2];
            [self addNewView:self.mainBuild scrollView:self.contentTableView];
        }else if(!self.decorationProject&&i==3){
            //加载装修
            self.decorationProject=[DecorationProject getDecorationProjectWithDelegate:self part:3];
            [self addNewView:self.decorationProject scrollView:self.contentTableView];
        }
    }
    //如果导致装修的界面需要被动画加载出来，则进行无动画加载装修view
    if (!self.decorationProject&&section==2&&row==3) {//计算坐标比较复杂，直接从结果中判断是否需要加载装修页面,判断下来,当用户点击第三大阶段第四小阶段时,需要无动画加载装修
        self.decorationProject=[DecorationProject getDecorationProjectWithDelegate:self part:3];
        [self addNewView:self.decorationProject scrollView:self.contentTableView];
    }
    
    NSInteger count[4]={0,2,5,9};
    CGFloat height=0;
    NSInteger sum=count[section]+row;
    for (int i=0; i<sum; i++) {
        height+=[self.contents[i] frame].size.height;
    }
    [self.contentTableView setContentOffset:CGPointMake(0, height) animated:YES];
    [self selectCancel];
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
        return NO;
    }else{
        if (indexPath.section==3) {
            return NO;
        }else{
            return YES;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.contentTableView) {
        return 1;
    }else{
        return 4;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.contentTableView) {
        return self.contents.count;
    }else{
        NSInteger count[4]={2,3,4,1};
        return count[section];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
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
    }else{
        BOOL first,second;
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                first=self.model.auctionContacts.count?YES:NO;
                second=self.model.auctionImages.count?YES:NO;
            }else{
                first=self.model.ownerContacts.count?YES:NO;
                second=NO;
            }
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                first=self.model.explorationContacts.count?YES:NO;
                second=self.model.explorationImages.count?YES:NO;
            }else if (indexPath.row==1){
                first=self.model.designContacts.count?YES:NO;
                second=NO;
            }else{
                first=self.model.ownerContacts.count?YES:NO;
                second=NO;
            }
        }else{
            if (indexPath.row==0){
                first=self.model.constructionContacts.count?YES:NO;
                second=self.model.constructionImages.count?YES:NO;
            }else if (indexPath.row==1){
                first=self.model.pileContacts.count?YES:NO;
                second=self.model.pileImages.count?YES:NO;
            }else if (indexPath.row==2){
                first=NO;
                second=self.model.mainBulidImages.count?YES:NO;
            }else{
                first=NO;
                second=NO;
            }
        }
        
        ProgramSelectViewCell* cell=[ProgramSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath firstIcon:first secondIcon:second];
        cell.delegate=self;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
        CGRect frame=[self.contents[indexPath.row] frame];
        return frame.size.height;
    }else{
        if (indexPath.section==3) {
            return 40;
        }else{
            return 34;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.contentTableView) {
        return 0;
    }else{
        return 37.5;
    }
}

-(void)chooseImageViewWithIndexPath:(MyIndexPath *)indexPath{
    NSArray* part0=@[self.model.auctionImages];
    NSArray* part1=@[self.model.explorationImages];
    NSArray* part2=@[self.model.constructionImages,self.model.pileImages,self.model.mainBulidImages];
    NSArray* part3=@[self.model.decorationImages];
    NSArray* array=@[part0,part1,part2,part3];
    
     //array[indexPath.part][indexPath.section];
//    NSLog(@"%d,%d",indexPath.part,indexPath.section);
    
//    NSData* data=[NSData dataWithContentsOfURL:url];
//    UIImage* image=[UIImage imageWithData:data];
    ViewController* vc=[[ViewController alloc]init];
    for (int i=0; i<[array[indexPath.part][indexPath.section] count]; i++) {
        NSURL* url=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,array[indexPath.part][indexPath.section][i]]];
        [vc.imagesArray addObject:url];
    }
    [self presentViewController:vc animated:NO completion:nil];
}

//**********************************************************************
//**********************************************************************
//**********************************************************************

//program大块 三行
-(NSArray*)getThreeLinesTitleViewWithThreeStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.section==0) {
        return @[self.model.a_landName,[NSString stringWithFormat:@"%@ %@ %@",self.model.a_province,self.model.a_city,self.model.a_district],self.model.a_landAddress];
    }else{
        return @[self.model.a_projectName,[NSString stringWithFormat:@"%@ %@ %@",self.model.a_city,self.model.a_district,self.model.a_landAddress],self.model.a_description];
    }
}

//图加图的数量
-(NSArray*)getImageViewWithImageAndCountWithIndexPath:(MyIndexPath*)indexPath{
    NSArray* part0=@[self.model.auctionImages];
    NSArray* part1=@[self.model.explorationImages];
    NSArray* part2=@[self.model.constructionImages,self.model.pileImages,self.model.mainBulidImages];
    NSArray* part3=@[self.model.decorationImages];
    NSArray* array=@[part0,part1,part2,part3];
    return array[indexPath.part][indexPath.section];
}

//第一行蓝，第二行黑的view
-(NSArray*)getBlueTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.section==0) {
        return @[[self.model.a_area stringByAppendingString:@"㎡"],[self.model.a_plotRatio stringByAppendingString:@"%"],self.model.a_usage];
    }else{
        return @[self.model.a_exceptStartTime,[self.model.a_storeyHeight stringByAppendingString:@"M"],self.model.a_foreignInvestment,self.model.a_exceptFinishTime,self.model.a_investment,[self.model.a_storeyArea stringByAppendingString:@"㎡"]];
    }
}

//联系人view
-(NSArray*)getThreeContactsViewThreeTypesFiveStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.part==0) {
        NSArray* array=@[self.model.auctionContacts,self.model.ownerContacts];
        return [self loadContacts:array[indexPath.section]];
    }else if (indexPath.part==1){
        NSArray* array=@[self.model.explorationContacts,self.model.designContacts,self.model.ownerContacts];
        return [self loadContacts:array[indexPath.section]];
    }else{
        NSArray* array=@[self.model.constructionContacts,self.model.pileContacts];
        return [self loadContacts:array[indexPath.section]];
    }
}

//处理model中的联系人,如果不满3个则补默认格式的联系人过去显示
-(NSArray*)loadContacts:(NSMutableArray*)contacts{
    NSMutableArray* array=[NSMutableArray arrayWithArray:contacts];
    for (int i=0; i<3-contacts.count; i++) {
        NSArray* tempAry=@[@"联系人",@"职位",@"单位名称",@"单位地址",@""];
        [array addObject:tempAry];
    }
    return array;
}

//program大块 二行
-(NSArray*)getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.part==1) {
        NSArray* array=@[@[self.model.a_mainDesignStage],@[self.model.a_exceptStartTime,self.model.a_exceptFinishTime]];
        return array[indexPath.section-1];
    }else{
        NSArray* array=@[self.model.a_actureStartTime];
        return array;
    }
}

//硬件设备以及yes和no
-(NSArray*)getDeviceAndBoolWithDevicesAndBoolStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[self.model.a_elevator,self.model.a_airCondition,self.model.a_heating,self.model.a_externalWallMeterial,self.model.a_stealStructure];
}

//第一行黑，第二行灰的view
-(NSArray*)getBlackTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.part==2) {
        return @[self.model.a_fireControl,self.model.a_green];
    }else{
        return @[self.model.a_electorWeakInstallation,self.model.a_decorationSituation,self.model.a_decorationProcess];
    }
}

//业主类型内容
-(NSArray*)getOwnerTypeViewWithImageAndOwnersWithIndexPath:(MyIndexPath*)indexPath{
    return [self.model.a_ownerType componentsSeparatedByString:@","];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
