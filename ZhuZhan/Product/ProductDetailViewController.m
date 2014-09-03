//
//  ProductDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "ProductDetailViewController.h"
#import "ProductCommentView.h"
@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* myTableView;

@property(nonatomic,strong)UIImage* productImage;//产品图片
@property(nonatomic,copy)NSString* productText;//产品介绍文字
@property(nonatomic,strong)UIView* productView;//产品图片和产品介绍文字的superView

@property(nonatomic,strong)NSMutableArray* commentModels;//评论数组，元素为评论实体类
@property(nonatomic,strong)NSMutableArray* commentViews;//cell中的内容视图
@end

@implementation ProductDetailViewController

-(instancetype)initWithImage:(UIImage*)productImage text:(NSString*)productText comments:(NSMutableArray*)comments{
    self=[super init];
    if (self) {
        self.productImage=productImage;
        self.productText=productText;
        self.commentModels=comments;
        self.commentViews=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self getProductIntroduce];
    [self initNavi];
    [self getTableViewContents];
    [self initMyTableView];
}

-(void)getTableViewContents{
    for (int i=0; i<self.commentModels.count; i++) {
        ProductCommentView* view=[[ProductCommentView alloc]initWithCommentModel:self.commentModels[i]];
        [self.commentViews addObject:view];
    }
}

-(void)getProductIntroduce{
    self.productView=[[UIView alloc]initWithFrame:CGRectZero];
    CGFloat tempHeight=0;
    
    //imageView部分
    CGFloat scale=320.0/self.productImage.size.width;
    CGFloat height=self.productImage.size.height*scale;
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, height)];
    imageView.image=self.productImage;
    
    UIImage* image=[UIImage imageNamed:@"人脉_66a.png"];
    CGRect frame=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
    UIImageView* tempImageView=[[UIImageView alloc]initWithFrame:frame];
    tempImageView.image=image;
    tempImageView.center=CGPointMake(320-30, height-30);
    [imageView addSubview:tempImageView];
    
    UIButton* button=[[UIButton alloc]initWithFrame:tempImageView.frame];
    [button addTarget:self action:@selector(chooseComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.productView addSubview:button];
    
    [self.productView addSubview:imageView];
    tempHeight+=imageView.frame.size.height;
    
    //文字label部分
    UIFont* font=[UIFont systemFontOfSize:15];
    CGRect bounds=[self.productText boundingRectWithSize:CGSizeMake(270, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    UILabel* textLabel=[[UILabel alloc]initWithFrame:bounds];
    textLabel.numberOfLines=0;
    textLabel.font=font;
    textLabel.text=self.productText;
    textLabel.textColor=RGBCOLOR(86, 86, 86);
    textLabel.center=CGPointMake(160, height+bounds.size.height*.5+15);
    [self.productView addSubview:textLabel];
    
    tempHeight+=bounds.size.height+30;
    
    //与下方tableView的分割部分
    UIImage* separatorImage=[UIImage imageNamed:@"产品－产品详情_12a@2x.png"];
    frame=CGRectMake(0, tempHeight, separatorImage.size.width*.5, separatorImage.size.height*.5);
    UIImageView* separatorImageView=[[UIImageView alloc]initWithFrame:frame];
    separatorImageView.image=separatorImage;
    separatorImageView.backgroundColor=RGBCOLOR(235, 235, 235);
    [self.productView addSubview:separatorImageView];
    
    tempHeight+=frame.size.height;
    
    self.productView.frame=CGRectMake(0, 0, 320, tempHeight);
    
}

-(void)chooseComment:(UIButton*)button{
    NSLog(@"chooseComment");
}


//=========================================================================
//=========================================================================
//=========================================================================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentViews.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return self.productView.frame.size.height;
    }else{
        return [self.commentViews[indexPath.row-1] frame].size.height;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        if (cell.contentView.subviews.count) {
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [cell.contentView addSubview:self.productView];
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"myCell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        }
        
        if (cell.contentView.subviews.count) {
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [cell.contentView addSubview:self.commentViews[indexPath.row-1]];
        cell.layer.masksToBounds=YES;
        cell.contentView.layer.masksToBounds=YES;
        cell.backgroundColor=[UIColor clearColor];
        //cell.contentView.backgroundColor=[UIColor redColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//=========================================================================
//=========================================================================
//=========================================================================
-(void)initMyTableView{
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-49) style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor=RGBCOLOR(235, 235, 235);
    [self.view addSubview:self.myTableView];
}

-(void)initNavi{
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=@"产品详情";
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
