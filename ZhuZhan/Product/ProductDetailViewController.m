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
#import "ACTimeScroller.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "ContactCommentModel.h"
#import "ACTimeScroller.h"
#import "LoginSqlite.h"
#import "MBProgressHUD.h"
#import "PersonalDetailViewController.h"
#import "CompanyDetailViewController.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "ProductModel.h"
#import "LoginViewController.h"
#import "IsFocusedApi.h"
#import "LoadingView.h"
@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,AddCommentDelegate,ACTimeScrollerDelegate,LoginViewDelegate>
@property(nonatomic,strong)UITableView* tableView;

//所有model的a_id均为产品或动态自身的id,a_entityId是自身所属的id
@property(nonatomic,strong)ProductModel* productModel;//产品详情模型
@property(nonatomic,strong)ActivesModel* activesModel;//动态详情模型
@property(nonatomic,strong)PersonalCenterModel* personalModel;//个人中心评论

//@property(nonatomic,strong)NSString* activesEntityUrl;//动态详情模型url

@property(nonatomic,strong)UIView* mainView;//产品图片和产品介绍文字的superView

@property(nonatomic,strong)NSMutableArray* commentModels;//评论数组，元素为评论实体类
@property(nonatomic,strong)NSMutableArray* commentViews;//cell中的内容视图

@property(nonatomic,strong)AddCommentViewController* vc;

@property(nonatomic,strong)ACTimeScroller* timeScroller;

//mainView部分
@property(nonatomic,copy)NSString* imageWidth;
@property(nonatomic,copy)NSString* imageHeight;
@property(nonatomic,copy)NSString* imageUrl;
@property(nonatomic,copy)NSString* userImageUrl;
@property(nonatomic,copy)NSString* content;
@property(nonatomic,copy)NSString* entityID;//动态或者产品自身的id
@property(nonatomic,copy)NSString* entityUrl;//获取动态时可能会用
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,copy)NSString* category;//产品或动态的分类
@property(nonatomic,copy)NSString* createdBy;
@property(nonatomic,copy)NSString* userType;//产品或动态的

@property(nonatomic,copy)NSString* myName;//登录用户的用户昵称
@property(nonatomic,copy)NSString* myImageUrl;//登录用户的用户头像
@property(nonatomic,copy)NSString* isFocused;

@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation ProductDetailViewController
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";

-(NSString*)myName{
    if (!_myName) {
        _myName=[LoginSqlite getdata:@"userName"];
    }
    return _myName;
}

-(NSString*)myImageUrl{
    if (!_myImageUrl) {
        _myImageUrl=[LoginSqlite getdata:@"userImage"];
    }
    return _myImageUrl;
}

-(void)loadMyPropertyWithImgW:(NSString*)imgW imgH:(NSString*)imgH imgUrl:(NSString*)imgUrl userImgUrl:(NSString*)userImgUrl content:(NSString*)content entityID:(NSString*)entityID entityUrl:(NSString*)entityUrl userName:(NSString*)userName category:(NSString*)category createdBy:(NSString*)createdBy userType:(NSString*)userType{
    self.imageWidth=imgW;
    self.imageHeight=imgH;
    self.imageUrl=imgUrl;
    self.userImageUrl=userImgUrl;
    self.content=content;
    self.entityID=entityID;
    self.entityUrl=entityUrl;
    self.userName=userName;
    self.category=category;
    self.createdBy=createdBy;
    self.userType=userType;
    self.commentViews=[[NSMutableArray alloc]init];
}

-(instancetype)initWithProductModel:(ProductModel*)productModel{
    self=[super init];
    if (self) {
        self.productModel=productModel;
        [self loadMyPropertyWithImgW:productModel.a_imageWidth imgH:productModel.a_imageHeight imgUrl:productModel.a_imageUrl userImgUrl:productModel.a_avatarUrl content:productModel.a_content entityID:productModel.a_id entityUrl:@"" userName:productModel.a_userName category:@"Product" createdBy:productModel.a_createdBy userType:productModel.a_userType];
    }
    return self;
}

-(instancetype)initWithActivesModel:(ActivesModel*)activesModel{
    self=[super init];
    if (self) {
        self.activesModel=activesModel;
        [self loadMyPropertyWithImgW:activesModel.a_imageWidth imgH:activesModel.a_imageHeight imgUrl:activesModel.a_imageUrl userImgUrl:activesModel.a_avatarUrl content:activesModel.a_content entityID:[activesModel.a_category isEqualToString:@"Product"]?activesModel.a_entityId:activesModel.a_id entityUrl:activesModel.a_entityUrl userName:activesModel.a_userName category:activesModel.a_category createdBy:activesModel.a_createdBy userType:activesModel.a_userType];
    }
    return self;
}

-(instancetype)initWithPersonalCenterModel:(PersonalCenterModel *)personalModel{
    self=[super init];
    if (self) {
        self.personalModel=personalModel;
        [self loadMyPropertyWithImgW:personalModel.a_imageWidth imgH:personalModel.a_imageHeight imgUrl:personalModel.a_imageUrl userImgUrl:self.myImageUrl content:personalModel.a_content entityID:personalModel.a_entityId entityUrl:personalModel.a_entityUrl userName:self.myName category:personalModel.a_category createdBy:[LoginSqlite getdata:@"userId"] userType:personalModel.a_userType];
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
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];

    [self initMyTableView];
    self.loadingView=[LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, 568) superView:self.view];

    //因为动态详情进来的产品model.content是评论而不是产品描述内容，所以先不出mainView，加载后会更新
    if (!(self.activesModel&&[self.category isEqualToString:@"Product"])) {
        [self getMainView];
    }
    [self loadTimeScroller];
    [self firstNetWork];
}

//初始化竖直滚动导航的时间标示
-(void)loadTimeScroller{
    self.timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
}

-(void)firstNetWork{
    [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.isFocused=[NSString stringWithFormat:@"%@",posts[0][@"isFocused"]];
            [self getNetWorkData];
        }
    } userId:[LoginSqlite getdata:@"userId"] targetId:self.entityID EntityCategory:self.category noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView=nil;
}

//获取网络数据
-(void)getNetWorkData{
    //产品详情的评论 或者个人中心的产品详情
    if (self.productModel||(self.personalModel&&[self.category isEqualToString:@"Product"])) {
        [CommentApi GetEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
            [self removeMyLoadingView];
            if (!error) {
                self.commentModels=posts;
                [self getTableViewContents];
                [self myTableViewReloadData];
            }
        } entityId:self.entityID entityType:@"Product" noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
                [self getNetWorkData];
            }];
        }];
        
    //动态详情的评论 或者个人中心的个人动态
    }else if (self.activesModel||(self.personalModel||!([self.category isEqualToString:@"Product"]))){
        [CommentApi CommentUrlWithBlock:^(NSMutableArray *posts, NSError *error) {
            [self removeMyLoadingView];
            if (!error) {
                if(posts.count !=0){
                    self.activesModel=posts[0];
                    NSLog(@"====>%@",self.activesModel.a_content);
                    if (!self.commentModels) self.commentModels=[[NSMutableArray alloc]init];
                    for (int i=0; i<self.activesModel.a_commentsArr.count; i++) {
                        //因为数组被处理过，当评论超过3条时会有一个字符串的元素，所以需要排除
                        if ([self.activesModel.a_commentsArr[i] isKindOfClass:[ContactCommentModel class]] ) {
                            [self.commentModels addObject:self.activesModel.a_commentsArr[i]];
                        }
                    }
                    if (self.activesModel&&[self.category isEqualToString:@"Product"]) {
                        self.content=self.activesModel.a_content;
                        self.imageUrl=self.activesModel.a_imageUrl;
                        self.imageWidth=self.activesModel.a_imageWidth;
                        self.imageHeight=self.activesModel.a_imageHeight;
                    }
                    [self getTableViewContents];
                    [self myTableViewReloadData];
                }
            }
        } url:self.entityUrl noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
                [self getNetWorkData];
            }];
        }];
    }
}

//获得上方主要显示的图文内容
-(void)getMainView{
    self.mainView = [[UIView alloc] initWithFrame:CGRectZero];

    UIView* forCornerView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.mainView addSubview:forCornerView];
    forCornerView.layer.cornerRadius=2;
    forCornerView.layer.masksToBounds=YES;
    
    CGFloat height=0;
    
    EGOImageView *imageView;
    //动态图像
    if(![self.imageUrl isEqualToString:@""]){
        imageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"bg001"]];
        imageView.frame = CGRectMake(0, 0, 310,[self.imageHeight floatValue]/[self.imageWidth floatValue]*310);
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.imageUrl]];
        [forCornerView addSubview:imageView];
        height+=imageView.frame.size.height;
    }
    
    UIView* contentTotalView;
    //动态描述
    if (![self.content isEqualToString:@""]) {
        UILabel* contentTextView = [[UILabel alloc] init];
        contentTextView.numberOfLines =0;
        UIFont * tfont = [UIFont systemFontOfSize:14];
        contentTextView.font = tfont;
        contentTextView.textColor = [UIColor blackColor];
        contentTextView.lineBreakMode =NSLineBreakByCharWrapping ;
        
        //用户名颜色
        NSString * text = [NSString stringWithFormat:@"%@:%@",self.userName,self.content];
        NSMutableAttributedString* attributedText=[[NSMutableAttributedString alloc]initWithString:text];
        NSRange range=NSMakeRange(0, self.userName.length+1);
        [attributedText addAttributes:@{NSForegroundColorAttributeName:BlueColor} range:range];
        [attributedText addAttributes:@{NSFontAttributeName:tfont} range:NSMakeRange(0, text.length)];
        
        //动态文字内容
        contentTextView.attributedText=attributedText;
        
        BOOL imageUrlExist=![self.imageUrl isEqualToString:@""];
        //给一个比较大的高度，宽度不变
        CGSize size =CGSizeMake(imageUrlExist?290:250,CGFLOAT_MAX);
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
    EGOImageView* userImageView = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"公司认证员工_05a"]];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 3;
    userImageView.frame=CGRectMake(5,tempHeight+5,37,37);
    [forCornerView addSubview:userImageView];
    
    UIButton* btn=[[UIButton alloc]initWithFrame:userImageView.frame];
    btn.tag=0;
    [btn addTarget:self action:@selector(chooseUserImage:) forControlEvents:UIControlEventTouchUpInside];
    [forCornerView addSubview:btn];
    
    userImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.userImageUrl]];
    [forCornerView addSubview:userImageView];
    
    //设置总的view的frame
    forCornerView.frame=CGRectMake(5, 5, 310, height-5);
    
    //与下方tableView的分割部分
    if (self.commentViews.count) {
        UIImage* separatorImage=[GetImagePath getImagePath:@"动态详情_14a"];
        CGRect frame=CGRectMake(0, height, separatorImage.size.width, separatorImage.size.height);
        UIImageView* separatorImageView=[[UIImageView alloc]initWithFrame:frame];
        separatorImageView.image=separatorImage;
        [self.mainView addSubview:separatorImageView];
        
        height+=frame.size.height;
    }
    
    //设置总的frame
    self.mainView.frame = CGRectMake(0, 0, 320, height);
    [self.mainView setBackgroundColor:RGBCOLOR(235, 235, 235)];
}

-(void)myTableViewReloadData{
    [self getMainView];
    [self.tableView reloadData];
}

-(void)getTableViewContents{
    for (int i=0; i<self.commentModels.count; i++) {
        ContactCommentModel* model=self.commentModels[i];
        ProductCommentView* view=[[ProductCommentView alloc]initWithCommentImageUrl:model.a_avatarUrl userName:model.a_userName commentContent:model.a_commentContents];
        [self.commentViews addObject:view];
    }
}

-(void)chooseComment:(UIButton*)button{
    NSString *deviceToken = [LoginSqlite getdata:@"deviceToken"];
    //判断是否有deviceToken,没有则进登录界面
    if ([deviceToken isEqualToString:@""]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        self.vc=[[AddCommentViewController alloc]init];
        self.vc.delegate=self;
        [self presentPopupViewController:self.vc animationType:MJPopupViewAnimationFade flag:2];
    }
}
//=============================================================
//ACTimeScrollerDelegate
//=============================================================
- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller{
    return self.tableView;
}
- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
   // NSLog(@"index==%@,%d",cell.contentView.subviews,indexPath.row);
    if (!indexPath.row) {
        timeScroller.hidden=YES;
        return [NSDate date];
    }else{
        timeScroller.hidden=NO;
        return [self.commentModels[indexPath.row-1] a_time];
    }
}

//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_timeScroller scrollViewDidEndDecelerating];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timeScroller scrollViewWillBeginDragging];
}
//=============================================================
//AddCommentDelegate
//=============================================================
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
    if ([self.category isEqualToString:@"Product"]) {
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
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        [self.vc finishNetWork];
        if(!error){
            [self finishAddComment:comment];
            if ([self.delegate respondsToSelector:@selector(finishAddCommentFromDetailWithPosts:)]) {
                [self.delegate finishAddCommentFromDetailWithPosts:posts];
            }
        }
    } dic:[@{@"EntityId":self.entityID,@"CommentContents":comment,@"EntityType":self.category,@"CreatedBy":[LoginSqlite getdata:@"userId"]} mutableCopy] noNetWork:nil];
}

//添加产品详情的评论
-(void)addProductComment:(NSString*)comment{
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        [self.vc finishNetWork];
        if (!error) {
            [self finishAddComment:comment];
        }
    } dic:[@{@"EntityId":self.entityID,@"entityType":@"Product",@"CommentContents":comment,@"CreatedBy":[LoginSqlite getdata:@"userId"]} mutableCopy] noNetWork:nil];
}

//给tableView添加数据
-(void)addTableViewContentWithContent:(NSString*)content{
    ProductCommentView* view=[[ProductCommentView alloc]initWithCommentImageUrl:self.myImageUrl userName:self.myName commentContent:content];

    ContactCommentModel* model=[[ContactCommentModel alloc]initWithID:nil entityID:nil createdBy:[LoginSqlite getdata:@"userId"] userName:self.myName commentContents:content avatarUrl:self.myImageUrl time:[NSDate date]];
    
    [self.commentModels insertObject:model atIndex:0];
    [self.commentViews insertObject:view atIndex:0];
}
//=============================================================
//UITableViewDataSource,UITableViewDelegate
//=============================================================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentViews.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row?[self.commentViews[indexPath.row-1] frame].size.height:self.mainView.frame.size.height;
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
        [cell.contentView addSubview:self.mainView];
        
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
        
        //使头像可以被点击
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(15, 20, 50, 50)];
        btn.tag=indexPath.row;
        [btn addTarget:self action:@selector(chooseUserImage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
       
        return cell;
    }
}
/**
 if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
 CompanyCenterViewController *companyVC = [[CompanyCenterViewController alloc] init];
 [self.navigationController pushViewController:companyVC animated:YES];
 }else{
 AccountViewController *accountVC = [[AccountViewController alloc] init];
 [self.navigationController pushViewController:accountVC animated:YES];
 }
 */
-(void)chooseUserImage:(UIButton*)btn{
    if([btn.tag?[self.commentModels[btn.tag-1] a_createdBy]:self.createdBy isEqualToString:[LoginSqlite getdata:@"userId"]]){
        return;
    }
    
    if ([btn.tag?[self.commentModels[btn.tag-1] a_userType]:self.userType isEqualToString:@"Personal"]) {
        PersonalDetailViewController* vc=[[PersonalDetailViewController alloc]init];
        vc.contactId=btn.tag?[self.commentModels[btn.tag-1] a_createdBy]:self.createdBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CompanyDetailViewController* vc=[[CompanyDetailViewController alloc]init];
        vc.companyId=btn.tag?[self.commentModels[btn.tag-1] a_createdBy]:self.createdBy;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView*)getCellSpaceView{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 310, 10)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}

//=============================================================
//=============================================================
//=============================================================
-(void)initMyTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=RGBCOLOR(235, 235, 235);
    [self.view addSubview:self.tableView];
}

-(void)initNavi{
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,29,28.5)];
    [button setImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=self.productModel?@"产品详情":@"";
    
    NSLog(@"===>%@",self.type);
    if([self.type isEqualToString:@"Product"]){
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setFrame:CGRectMake(0, 0, 25, 22)];
        [rightButton setBackgroundImage:[GetImagePath getImagePath:@"019"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
}

-(void)back{
    self.tableView.delegate=nil;
    self.tableView.dataSource=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)rightBtnClick{
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        NSString *string = nil;
        if([self.isFocused isEqualToString:@"0"]){
            string = @"添加关注";
        }else{
            string = @"取消关注";
        }
        UIActionSheet* actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:string, nil];
        [actionSheet showInView:self.view];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if (buttonIndex==0) {
        if([self.isFocused isEqualToString:@"0"]){
            NSLog(@"关注");
            [ProductModel AddProductFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                }
            } dic:[@{@"userId":[LoginSqlite getdata:@"userId"],@"productId":self.productModel.a_id} mutableCopy] noNetWork:nil];
        }else{
            [ProductModel DeleteProductionUserFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"0";
                }
            } dic:[@{@"userId":[LoginSqlite getdata:@"userId"],@"productId":self.productModel.a_id} mutableCopy] noNetWork:nil];
        }
    }else{
        NSLog(@"取消");
    }
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.isFocused = [NSString stringWithFormat:@"%@",posts[0][@"isFocused"]];
            if (block) {
                block();
            }
        }
    } userId:[LoginSqlite getdata:@"userId"] targetId:self.entityID EntityCategory:self.category noNetWork:nil];
}
//-(void)getProductView{
//    self.productView=[[UIView alloc]initWithFrame:CGRectZero];
//    CGFloat tempHeight=0;
//
//    //imageView部分
//    CGFloat scale=320.0/[self.productModel.a_imageWidth floatValue]*2;
//    CGFloat height=[self.productModel.a_imageHeight floatValue]*.5*scale;
//
//    EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:@"产品－产品详情_03a"]];
//    if (![self.productModel.a_imageUrl isEqualToString:@""]) {
//        imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",serverAddress,self.productModel.a_imageUrl]];
//    }else{
//        height=202;
//    }
//    imageView.frame=CGRectMake(0, 0, 320, height);
//
//    //imageView右下角评论图标
//    UIImage* image=[GetImagePath getImagePath:@"人脉_66a"];
//    CGRect frame=CGRectMake(0, 0, image.size.width, image.size.height);
//    UIImageView* tempImageView=[[UIImageView alloc]initWithFrame:frame];
//    tempImageView.image=image;
//    tempImageView.center=CGPointMake(320-30, height-30);
//    [imageView addSubview:tempImageView];
//
//    UIButton* button=[[UIButton alloc]initWithFrame:tempImageView.frame];
//    [button addTarget:self action:@selector(chooseComment:) forControlEvents:UIControlEventTouchUpInside];
//    [self.productView addSubview:button];
//
//    [self.productView addSubview:imageView];
//    tempHeight+=imageView.frame.size.height;
//
//    //文字label部分
//    if (![self.productModel.a_content isEqualToString:@""]) {
//        UIFont* font=[UIFont systemFontOfSize:15];
//        CGRect bounds=[self.productModel.a_content boundingRectWithSize:CGSizeMake(270, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
//        UILabel* textLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, height+15, 270, bounds.size.height)];
//        ;
//        textLabel.numberOfLines=0;
//        textLabel.font=font;
//        textLabel.text=self.productModel.a_content;
//        textLabel.textColor=RGBCOLOR(86, 86, 86);
//        [self.productView addSubview:textLabel];
//
//        tempHeight+=bounds.size.height+30;
//
//    }
//
//    //与下方tableView的分割部分
//    if (self.commentViews.count) {
//        UIImage* separatorImage=[GetImagePath getImagePath:@"产品－产品详情_12a"];
//        frame=CGRectMake(0, tempHeight, separatorImage.size.width, separatorImage.size.height);
//        UIImageView* separatorImageView=[[UIImageView alloc]initWithFrame:frame];
//        separatorImageView.image=separatorImage;
//        separatorImageView.backgroundColor=RGBCOLOR(235, 235, 235);
//        [self.productView addSubview:separatorImageView];
//
//        tempHeight+=frame.size.height;
//    }
//    self.productView.frame=CGRectMake(0, 0, 320, tempHeight);
//
//}
@end
