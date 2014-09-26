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
#import "ACTimeScroller.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "ContactCommentModel.h"
#import "ProjectCommentModel.h"
@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,AddCommentDelegate>//,ACTimeScrollerDelegate>
@property(nonatomic,strong)UITableView* myTableView;

@property(nonatomic,strong)ProductModel* productModel;//产品详情模型
@property(nonatomic,strong)ActivesModel* activesModel;//动态详情模型
//@property(nonatomic,strong)NSString* activesEntityUrl;//动态详情模型url

@property(nonatomic,strong)UIView* productView;//产品图片和产品介绍文字的superView

@property(nonatomic,strong)NSMutableArray* commentModels;//评论数组，元素为评论实体类
@property(nonatomic,strong)NSMutableArray* commentViews;//cell中的内容视图

@property(nonatomic,strong)AddCommentViewController* vc;

//@property(nonatomic,strong)ACTimeScroller* timeScroller;
@end

@implementation ProductDetailViewController

-(instancetype)initWithProductModel:(ProductModel *)productModel{
    self=[super init];
    if (self) {
        self.productModel=productModel;
        self.commentViews=[[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype)initWithActivesModel:(ActivesModel *)activesModel{
    self=[super init];
    if (self) {
        self.activesModel=activesModel;
        self.commentViews=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.productModel) {
        [CommentApi GetEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.commentModels=posts;
                [self getTableViewContents];
                [self myTableViewReloadData];
                //self.timeScroller=[[ACTimeScroller alloc]initWithDelegate:self];;
                //[self.myTableView reloadData];
            }
        } entityId:self.productModel.a_id entityType:@"Product"];
        self.view.backgroundColor=[UIColor whiteColor];
        [self initNavi];
        [self initMyTableView];
        [self getProductView];
    }else{
        [CommentApi ProjectUrlWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.activesModel=posts[0];
                if (!self.commentModels) self.commentModels=[[NSMutableArray alloc]init];
                for (int i=0; i<self.activesModel.a_commentsArr.count; i++) {
                    if ([self.activesModel.a_commentsArr[i] isKindOfClass:[ContactCommentModel class]] ) {
                        [self.commentModels addObject:self.activesModel.a_commentsArr[i]];
                    }
                }

                [self getTableViewContents];
                [self myTableViewReloadData];
            }
        } url:self.activesModel.a_entityUrl];
        self.view.backgroundColor=[UIColor whiteColor];
        [self initNavi];
        [self initMyTableView];
        [self getActivesView];
    }
}

-(void)myTableViewReloadData{
    if (self.productModel) {
        [self getProductView];
    }else{
        [self getActivesView];
    }
    [self.myTableView reloadData];
}

-(void)getTableViewContents{
    for (int i=0; i<self.commentModels.count; i++) {
        ProductCommentView* view;
        if (self.productModel) {
            ProjectCommentModel* model=self.commentModels[i];
            view=[[ProductCommentView alloc]initWithCommentImageUrl:model.a_imageUrl userName:model.a_name commentContent:model.a_content];
        }else{
            ContactCommentModel* model=self.commentModels[i];
            view=[[ProductCommentView alloc]initWithCommentImageUrl:model.a_avatarUrl userName:model.a_userName commentContent:model.a_commentContents];
        }
        [self.commentViews addObject:view];
    }
}

-(void)getActivesView{
    self.productView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIView* forCornerView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.productView addSubview:forCornerView];
    forCornerView.layer.cornerRadius=2;
    forCornerView.layer.masksToBounds=YES;
    
    CGFloat height=0;

    EGOImageView *imageView;
    //动态图像
    if(![self.activesModel.a_imageUrl isEqualToString:@""]){
        imageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001.png"]];
        imageView.frame = CGRectMake(0, 0, 310,[self.activesModel.a_imageHeight floatValue]/[self.activesModel.a_imageWidth floatValue]*310);
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,self.activesModel.a_imageUrl]];
        [forCornerView addSubview:imageView];
        height+=imageView.frame.size.height;
    }
    
    UIView* contentTotalView;
    //动态描述
    if (![self.activesModel.a_content isEqualToString:@""]) {
        UILabel* contentTextView = [[UILabel alloc] init];
        contentTextView.numberOfLines =0;
        UIFont * tfont = [UIFont systemFontOfSize:15];
        contentTextView.font = tfont;
        contentTextView.textColor = [UIColor blackColor];
        contentTextView.lineBreakMode =NSLineBreakByCharWrapping ;
        
        //用户名颜色
        NSString * text = [NSString stringWithFormat:@"%@:%@",self.activesModel.a_userName,self.activesModel.a_content];
        NSMutableAttributedString* attributedText=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange range=NSMakeRange(0, self.activesModel.a_userName.length+1);
        [attributedText addAttributes:@{NSForegroundColorAttributeName:BlueColor} range:range];
        [attributedText addAttributes:@{NSFontAttributeName:tfont} range:NSMakeRange(0, text.length)];
        
        //动态文字内容
        contentTextView.attributedText=attributedText;
        
        BOOL imageUrlExist=![self.activesModel.a_imageUrl isEqualToString:@""];
        //给一个比较大的高度，宽度不变
        CGSize size =CGSizeMake(imageUrlExist?300:250,CGFLOAT_MAX);
        // 获取当前文本的属性
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
        //ios7方法，获取文本需要的size，限制宽度
        CGSize actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        contentTextView.frame =CGRectMake(imageUrlExist?10:60,10, actualsize.width, actualsize.height);
        
        contentTotalView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 310, imageView?contentTextView.frame.size.height+20:contentTextView.frame.size.height+20+40)];
        contentTotalView.backgroundColor=[UIColor whiteColor];
        [contentTotalView addSubview:contentTextView];
        [forCornerView addSubview:contentTotalView];
        height+=contentTotalView.frame.size.height;
    }
    
    //评论图标
    CGFloat tempHeight=imageView?imageView.frame.origin.y+imageView.frame.size.height:height;
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(265, tempHeight-40, 37, 37);
    [commentBtn setImage:[GetImagePath getImagePath:@"人脉_66a"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(chooseComment:) forControlEvents:UIControlEventTouchUpInside];
    [forCornerView addSubview:commentBtn];
    
    //用户头像
    tempHeight=imageView?imageView.frame.origin.y:contentTotalView.frame.origin.y;
    EGOImageView* userImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001.png"]];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 3;
    userImageView.frame=CGRectMake(5,tempHeight+5,37,37);
    [forCornerView addSubview:userImageView];
    
    userImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,self.activesModel.a_avatarUrl]];
    [forCornerView addSubview:userImageView];
    
    //设置总的view的frame
    forCornerView.frame=CGRectMake(5, 5, 310, height-5);
    
    //与下方tableView的分割部分
    if (self.commentViews.count) {
        UIImage* separatorImage=[GetImagePath getImagePath:@"动态详情_14a"];
        CGRect frame=CGRectMake(0, height, separatorImage.size.width, separatorImage.size.height);
        UIImageView* separatorImageView=[[UIImageView alloc]initWithFrame:frame];
        separatorImageView.image=separatorImage;
        [self.productView addSubview:separatorImageView];
        
        height+=frame.size.height;
    }

    //设置总的frame
    self.productView.frame = CGRectMake(0, 0, 320, height);
    [self.productView setBackgroundColor:RGBCOLOR(235, 235, 235)];
}

-(void)getProductView{
    self.productView=[[UIView alloc]initWithFrame:CGRectZero];
    CGFloat tempHeight=0;
    
    //imageView部分
    CGFloat scale=320.0/[self.productModel.a_imageWidth floatValue]*2;
    CGFloat height=[self.productModel.a_imageHeight floatValue]*.5*scale;

    EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"产品－产品详情_03a"]];
    if (![self.productModel.a_imageUrl isEqualToString:@""]) {
        imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,self.productModel.a_imageUrl]];
    }else{
        height=202;
    }
    imageView.frame=CGRectMake(0, 0, 320, height);

    //imageView右下角评论图标
    UIImage* image=[GetImagePath getImagePath:@"人脉_66a"];
    CGRect frame=CGRectMake(0, 0, image.size.width, image.size.height);
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
    if (![self.productModel.a_content isEqualToString:@""]) {
        UIFont* font=[UIFont systemFontOfSize:15];
        CGRect bounds=[self.productModel.a_content boundingRectWithSize:CGSizeMake(270, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        UILabel* textLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, height+15, 270, bounds.size.height)];
        ;
        textLabel.numberOfLines=0;
        textLabel.font=font;
        textLabel.text=self.productModel.a_content;
        textLabel.textColor=RGBCOLOR(86, 86, 86);
        [self.productView addSubview:textLabel];
        
        tempHeight+=bounds.size.height+30;

    }
    
    //与下方tableView的分割部分
    if (self.commentViews.count) {
        UIImage* separatorImage=[GetImagePath getImagePath:@"产品－产品详情_12a"];
        frame=CGRectMake(0, tempHeight, separatorImage.size.width, separatorImage.size.height);
        UIImageView* separatorImageView=[[UIImageView alloc]initWithFrame:frame];
        separatorImageView.image=separatorImage;
        separatorImageView.backgroundColor=RGBCOLOR(235, 235, 235);
        [self.productView addSubview:separatorImageView];
        
        tempHeight+=frame.size.height;
    }
    self.productView.frame=CGRectMake(0, 0, 320, tempHeight);
    
}

-(void)chooseComment:(UIButton*)button{
    NSString *deviceToken = [LoginSqlite getdata:@"deviceToken" defaultdata:@""];
    
    if ([deviceToken isEqualToString:@""]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[AppDelegate instance] window].rootViewController = naVC;
        [[[AppDelegate instance] window] makeKeyAndVisible];
        return;
    }
    
    self.vc=[[AddCommentViewController alloc]init];
    self.vc.delegate=self;
    [self.navigationController presentPopupViewController:self.vc animationType:MJPopupViewAnimationFade flag:2];
}

//=========================================================================
//AddCommentDelegate
//=========================================================================
//点击添加评论并点取消的回调方法
-(void)cancelFromAddComment{
    NSLog(@"cancelFromAddComment");
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

// "EntityId": ":entity ID", （项目，产品，公司，动态等）
// "entityType": ":”entityType", Personal,Company,Project,Product 之一
// "CommentContents": "评论内容",
// "CreatedBy": ":“评论人"
// }
//点击添加评论并点确认的回调方法
-(void)sureFromAddCommentWithComment:(NSString *)comment{
    NSLog(@"sureFromAddCommentWithCommentModel:");
    if (self.productModel) {
        [self addProductComment:comment];
    }else{
        [self addActivesComment:comment];
    }
}

//post完成之后的操作
-(void)finishAddComment:(NSString*)comment{
    [self addTableViewContentWithContent:comment];
    [self myTableViewReloadData];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

//添加动态详情的评论
-(void)addActivesComment:(NSString*)comment{
    ActivesModel *model = self.activesModel;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:model.a_id forKey:@"EntityId"];
    [dic setValue:[NSString stringWithFormat:@"%@",comment] forKey:@"CommentContents"];
    [dic setValue:model.a_category forKey:@"EntityType"];
    [dic setValue:@"13756154-7db5-4516-bcc6-6b7842504c81" forKey:@"CreatedBy"];
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self finishAddComment:comment];
            [self.navigationController.viewControllers.firstObject _refreshing];
        }
    } dic:dic];
}

//添加产品详情的评论
-(void)addProductComment:(NSString*)comment{
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self finishAddComment:comment];
        }
    } dic:[@{@"EntityId":self.productModel.a_id,@"entityType":@"Product",@"CommentContents":comment,@"CreatedBy":@"f483bcfc-3726-445a-97ff-ac7f207dd888"} mutableCopy]];
}

//给tableView添加数据
-(void)addTableViewContentWithContent:(NSString*)content{
    ProductCommentView* view=[[ProductCommentView alloc]initWithCommentImageUrl:@"" userName:@"" commentContent:content];
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
            [cell.contentView.subviews.lastObject layer].cornerRadius=3;
            if (indexPath.row!=self.commentViews.count) {
                UIView* view=[self getCellSpaceView];
                view.center=CGPointMake(160, height-5);
                [cell.contentView insertSubview:view atIndex:0];
            }
            
        //最后一个cell,添加上方长方形区域,遮盖圆角
        }else if (indexPath.row==self.commentViews.count){
            [cell.contentView.subviews.lastObject layer].cornerRadius=3;
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
            UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 310, 1)];
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
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 310, 10)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}

//=========================================================================
//=========================================================================
//=========================================================================
-(void)initMyTableView{
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor=RGBCOLOR(235, 235, 235);
    self.myTableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.myTableView];
}

-(void)initNavi{
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=self.productModel?@"产品详情":@"";
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
