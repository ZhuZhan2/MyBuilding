//
//  TradeViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "TradeViewController.h"
#import "TradeCollectionViewCell.h"
@interface TradeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* myCollectionView;

@property(nonatomic,strong)NSDictionary* cellInfo;//cell的内容信息
@end

@implementation TradeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addtittle:@"交易"];
    [self initMyCollectionView];  //myCollectionView和layout初始化
    
    //初始化cell的内容信息（图片或文字），之后用字典传数据过去
    NSMutableArray* array=[[NSMutableArray alloc]init];
    for (int i=0; i<20; i++) {
        NSString* str=[NSString stringWithFormat:@"%d",i];
        [array addObject:str];
    }
    self.cellInfo=[NSDictionary dictionaryWithObjectsAndKeys:array,@"cellText", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyCollectionView{
    //layout初始化
    UICollectionViewFlowLayout* layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(148, 250);//每个cell的size
    layout.sectionInset=UIEdgeInsetsMake(10, 7, 20, 7);//所有cell整体的离top(顶),left(左),bottom(下),right(右)的距离
    layout.minimumInteritemSpacing=5;//cell之间的行距离y
    
    //myCollectionView初始化
    CGRect frame=self.view.bounds;
    frame.origin.y+=64;//navi和状态栏高
    frame.size.height-=64+49;//49为tabBar高
    self.myCollectionView=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    [self.myCollectionView registerClass:[TradeCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    self.myCollectionView.backgroundColor=[UIColor whiteColor];
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
    [self.view addSubview:self.myCollectionView];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TradeCollectionViewCell* cell=[TradeCollectionViewCell dequeueReusableCellWithCollectionView:collectionView reuseIdentifier:@"Cell" forIndexPath:indexPath info:self.cellInfo];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
