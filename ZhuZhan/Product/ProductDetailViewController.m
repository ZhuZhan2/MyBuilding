//
//  ProductDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-3.
//
//

#import "ProductDetailViewController.h"
#import "ProductCommentView.h"
#import "AddCommentViewController.h"
#import "AppDelegate.h"
#import "UIViewController+MJPopupViewController.h"
#import "CommentApi.h"
#import "CommentModel.h"
@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,AddCommentDelegate>
@property(nonatomic,strong)UITableView* myTableView;

@property(nonatomic,strong)UIImage* productImage;//产品图片
@property(nonatomic,copy)NSString* productText;//产品介绍文字
@property(nonatomic,strong)UIView* productView;//产品图片和产品介绍文字的superView

@property(nonatomic,strong)NSMutableArray* commentModels;//评论数组，元素为评论实体类
@property(nonatomic,strong)NSMutableArray* commentViews;//cell中的内容视图

@property(nonatomic,strong)AddCommentViewController* vc;

@property(nonatomic,copy)NSString* a_id;

@end

@implementation ProductDetailViewController

-(instancetype)initWithImage:(UIImage*)productImage text:(NSString*)productText productID:(NSString *)productID{
    self=[super init];
    if (self) {
        self.productImage=productImage;
        self.productText=productText;
        self.commentModels=[[NSMutableArray alloc]init];
        self.commentViews=[[NSMutableArray alloc]init];
        self.a_id=productID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [CommentApi GetEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSLog(@"%@,%@",posts,self.a_id);
        for (int i=0; i<posts.count; i++) {
            NSLog(@"%@",[posts[i] a_name]);
            [self.commentModels addObject:posts[i]];
        }
        [self getTableViewContents];
        [self myTableViewReloadData];
        //[self.myTableView reloadData];
        
    } entityId:self.a_id entityType:@"Product"];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];
    [self initMyTableView];
    [self getProductView];
    

}

-(void)myTableViewReloadData{
    [self getProductView];
    [self.myTableView reloadData];
}

-(void)getTableViewContents{
    for (int i=0; i<self.commentModels.count; i++) {
        
        ProductCommentView* view=[[ProductCommentView alloc]initWithCommentModel:self.commentModels[i]];
        [self.commentViews addObject:view];
    }
}

-(void)getProductView{
    self.productView=[[UIView alloc]initWithFrame:CGRectZero];
    CGFloat tempHeight=0;
    
    //imageView部分
    CGFloat scale=320.0/self.productImage.size.width;
    CGFloat height=self.productImage.size.height*scale;
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, height)];
    imageView.image=self.productImage;
    NSLog(@"%f",imageView.frame.size.width);
    
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
    if (self.commentViews.count) {
        UIImage* separatorImage=[UIImage imageNamed:@"产品－产品详情_12a@2x.png"];
        frame=CGRectMake(0, tempHeight, separatorImage.size.width*.5, separatorImage.size.height*.5);
        UIImageView* separatorImageView=[[UIImageView alloc]initWithFrame:frame];
        separatorImageView.image=separatorImage;
        separatorImageView.backgroundColor=RGBCOLOR(235, 235, 235);
        [self.productView addSubview:separatorImageView];
        
        tempHeight+=frame.size.height;
    }
    self.productView.frame=CGRectMake(0, 0, 320, tempHeight);
    
}

-(void)chooseComment:(UIButton*)button{
    self.vc=[[AddCommentViewController alloc]init];
    self.vc.delegate=self;
    [self.navigationController presentPopupViewController:self.vc animationType:MJPopupViewAnimationFade flag:2];
}

//=========================================================================
//AddCommentDelegate
//=========================================================================
-(void)cancelFromAddComment{
    NSLog(@"cancelFromAddComment");
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
//// "EntityId": ":entity ID", （项目，产品，公司，动态等）
// "entityType": ":”entityType", Personal,Company,Project,Product 之一
// "CommentContents": "评论内容",
// "CreatedBy": ":“评论人"
// }
-(void)sureFromAddCommentWithComment:(NSString *)comment{
    NSLog(@"sureFromAddCommentWithCommentModel:");
    NSLog(@"%@",comment);
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self addTableViewContentWithContent:comment];
            [self.myTableView reloadData];
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        }
        NSLog(@"sucess");
    } dic:[@{@"EntityId":self.a_id,@"entityType":@"Product",@"CommentContents":comment,@"CreatedBy":@"f483bcfc-3726-445a-97ff-ac7f207dd888"} mutableCopy]];
}


-(void)addTableViewContentWithContent:(NSString*)content{
    CommentModel* model=[[CommentModel alloc]init];
    model.a_content=content;
        ProductCommentView* view=[[ProductCommentView alloc]initWithCommentModel:model];
    [self.commentViews insertObject:view atIndex:0];
}
//=========================================================================
//UITableViewDataSource,UITableViewDelegate
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
        
        CGFloat height=[cell.contentView.subviews.lastObject frame].size.height;
        
        //第一个cell,添加下方长方形区域,遮盖圆角
        if (indexPath.row==1) {
            [cell.contentView.subviews.lastObject layer].cornerRadius=7;
            UIView* view=[self getCellSpaceView];
                        view.center=CGPointMake(160, height-5);
            [cell.contentView insertSubview:view atIndex:0];
            
        //最后一个cell,添加上方长方形区域,遮盖圆角
        }else if (indexPath.row==self.commentViews.count){
            [cell.contentView.subviews.lastObject layer].cornerRadius=7;
            UIView* view=[self getCellSpaceView];
            view.center=CGPointMake(160, 5);
            [cell.contentView insertSubview:view atIndex:0];

        //其他cell,处理圆角
        }else{
            if ([cell.contentView.subviews.lastObject layer].cornerRadius>0) {
                [cell.contentView.subviews.lastObject layer].cornerRadius=0;
            }
        }
        
        //处理分割线
        if (indexPath.row!=self.commentViews.count) {
            UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 308, 1)];
            separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
            separatorLine.center=CGPointMake(160, height-.5);
            [cell.contentView addSubview:separatorLine];
        }
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(UIView*)getCellSpaceView{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 308, 10)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
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
    self.myTableView.showsVerticalScrollIndicator=NO;
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
