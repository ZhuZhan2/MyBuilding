//
//  ProductDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "ProductDetailViewController.h"
#import "ProductDetailViewCell.h"
@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* myTableView;

@property(nonatomic,strong)UIImage* productImage;
@property(nonatomic,copy)NSString* productText;
@property(nonatomic,strong)NSMutableArray* comments;

@property(nonatomic,strong)UIView* productView;
@end

@implementation ProductDetailViewController

-(instancetype)initWithImage:(UIImage*)productImage text:(NSString*)productText comments:(NSMutableArray*)comments{
    self=[super init];
    if (self) {
        self.productImage=productImage;
        self.productText=productText;
        self.comments=comments;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self getProductIntroduce];
    [self initNavi];
    [self initMyTableView];
    // Do any additional setup after loading the view.
}

-(void)getProductIntroduce{
    self.productView=[[UIView alloc]initWithFrame:CGRectZero];
    CGFloat tempHeight=0;
    
    //imageView部分
    CGFloat scale=320.0/self.productImage.size.width;
    CGFloat height=self.productImage.size.height*scale;
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, height)];
    imageView.image=self.productImage;
    
    UIImage* image=[UIImage imageNamed:@"项目-首页_18a.png"];
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
    
    self.productView.frame=CGRectMake(0, 0, 320, tempHeight);
    
}

-(void)chooseComment:(UIButton*)button{
    NSLog(@"chooseComment");
}


//=========================================================================
//=========================================================================
//=========================================================================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return self.productView.frame.size.height;
    }else{
        return 55;
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
        ProductDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"myCell"];
        if (!cell) {
            cell=[[ProductDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        }
        cell.backgroundColor=[UIColor greenColor];
        cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
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
    self.myTableView.backgroundColor=[UIColor yellowColor];
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
