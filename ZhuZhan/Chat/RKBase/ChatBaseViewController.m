//
//  ChatBaseViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import "ChatBaseViewController.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "SearchBarTableViewController.h"
#import "MJRefresh.h"
@interface ChatBaseViewController()
@property(nonatomic)BOOL searchBarIsTableViewHeader;

@property(nonatomic)BOOL searchBarIsAnimating;

@property (nonatomic, strong)UIActivityIndicatorView* indicatorView;
@end

@implementation ChatBaseViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.leftBtnIsBack=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=RGBCOLOR(223, 223, 223);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
}

//Navi相关
-(void)setRightBtnWithImage:(UIImage*)image{
    _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    [_rightBtn setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)setRightBtnWithText:(NSString*)text{
    if (text) {
        UIFont* font=[UIFont systemFontOfSize:15];
        _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [text boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width, 20)];
        [_rightBtn setTitle:text forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font=font;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    }else{
        _rightBtn=nil;
        self.navigationItem.rightBarButtonItem=nil;
    }
}

-(void)rightBtnClicked{
    
}

-(void)setLeftBtnWithImage:(UIImage*)image{
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_leftBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    }
}

-(void)setLeftBtnWithText:(NSString*)text{
    if (!_leftBtn) {
        UIFont* font=[UIFont systemFontOfSize:15];
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, [text boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width, 20)];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font=font;
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    }
    [_leftBtn setTitle:text forState:UIControlStateNormal];
}

-(void)leftBtnClicked{
    if (self.leftBtnIsBack) {
        if (self.needAnimaiton) {
            [self addAnimation];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)initTableView{
    CGFloat y=64;
    if (self.stageChooseView){
        y+=CGRectGetHeight(self.stageChooseView.frame);
    }
    if (self.searchBar&&!self.searchBarIsTableViewHeader) {
        y+=CGRectGetHeight(self.searchBar.frame);
    }
    
    CGFloat height=kScreenHeight-y;
    self.tableView=[[RKBaseTableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.noDataView = self.tableViewNoDataView;
    if (self.searchBar&&!self.searchBarIsTableViewHeader) {
        [self.view insertSubview:self.tableView belowSubview:self.searchBar];
    }else if (self.stageChooseView){
        [self.view insertSubview:self.tableView belowSubview:self.stageChooseView];
    }else{
        [self.view addSubview:self.tableView];
    }
}

-(void)setUpSearchBarWithNeedTableView:(BOOL)needTableView isTableViewHeader:(BOOL)isTableViewHeader{
    self.searchBarIsTableViewHeader=isTableViewHeader;
    
    CGFloat y=64+(self.stageChooseView?CGRectGetHeight(self.stageChooseView.frame):0);
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, y, 320, 43)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
    
    if (!isTableViewHeader) {
        if (self.stageChooseView) {
            [self.view insertSubview:self.searchBar belowSubview:self.stageChooseView];
        }else{
            [self.view addSubview:self.searchBar];
        }
    }
    
    if (needTableView) {
        [self setUpSearchBarTableView];
    }
}

-(RKBaseTableView*)searchBarTableView{
    return self.searchBarTableViewController.tableView;
}

-(void)setUpSearchBarTableView{
    self.searchBarTableViewController=[[SearchBarTableViewController alloc]initWithTableViewBounds:CGRectMake(0, 0, kScreenWidth, kScreenHeight-CGRectGetMinY(self.searchBar.frame))];
    self.searchBarTableViewController.delegate=self;
    self.searchBarTableViewController.noDataView = self.searchBarTableViewNoDataView;
}

-(void)setSearchBarTableViewBackColor:(UIColor*)color{
    self.searchBarTableViewController.view.backgroundColor=color;
    self.searchBarTableViewController.tableView.backgroundColor=color;
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)addAnimation{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
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

//搜索框tableView
-(void)reloadSearchBarTableViewData{
    [self.searchBarTableViewController reloadSearchBarTableViewData];
}

//搜索框动画
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if (!self.searchBarIsAnimating) {
        [self appearAnimation:searchBar];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (self.searchBarIsAnimating) {
        [self disappearAnimation:searchBar];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (!self.searchBarTableViewController.view.superview) {
        [self searchBarTableViewAppear];
    }
    [searchBar resignFirstResponder];
}

-(void)ClickedSearchBarSearchButton:(UISearchBar *)searchBar{
    if (!self.searchBarTableViewController.view.superview) {
        [self searchBarTableViewAppear];
    }
    [searchBar resignFirstResponder];
}

-(void)appearAnimation:(UISearchBar *)searchBar{
    [self appearAndDisappearAnimation:searchBar isAppear:YES];
}

-(void)disappearAnimation:(UISearchBar *)searchBar{
    searchBar.text=@"";
    [self searchBarTableViewDisppear];
    [self appearAndDisappearAnimation:searchBar isAppear:NO];
    [searchBar resignFirstResponder];
}

-(void)appearAndDisappearAnimation:(UISearchBar*)searchBar isAppear:(BOOL)isAppear{
    self.searchBarIsAnimating=isAppear;
    isAppear?[self getSearchBarBackBtn]:[self removeSearchBarBackBtn];
    self.searchBar.showsCancelButton=isAppear;
    [[UIApplication sharedApplication] setStatusBarStyle:isAppear?UIStatusBarStyleDefault:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden=isAppear;
    CGFloat height=65+CGRectGetHeight(self.stageChooseView.frame)-20;
    height*=isAppear?-1:1;
    [self subviewsDoAnimationWithSubviews:self.view.subviews ty:height];
}

-(void)subviewsDoAnimationWithSubviews:(NSArray*)subviews ty:(CGFloat)ty{
    [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView* view=obj;
        CGRect frame=view.frame;
        frame.origin.y+=ty;
        [UIView animateWithDuration:0.3 animations:^{
            view.frame=frame;
        }];
    }];
}

-(void)getSearchBarBackBtn{
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.searchBar.frame)+64+CGRectGetHeight(self.stageChooseView.frame), kScreenWidth, CGRectGetHeight(self.view.frame))];
    button.backgroundColor=[UIColor blackColor];
    [button addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    button.alpha=0.5;
    self.searchBarBackBtn=button;
    [self.view addSubview:self.searchBarBackBtn];
}

-(void)backBtnClicked{
    [self searchBarCancelButtonClicked:self.searchBar];
}

-(void)removeSearchBarBackBtn{
    [self.searchBarBackBtn removeFromSuperview];
}

-(void)searchBarTableViewAppear{
    self.searchBarTableViewController.view.transform=CGAffineTransformMakeTranslation(0, 20+self.searchBar.frame.size.height-1);
    
    [self.view addSubview:self.searchBarTableViewController.view];
}

-(void)searchBarTableViewDisppear{
    [self.searchBarTableViewController.view removeFromSuperview];
}

-(NSMutableArray *)sectionSelectedArray{
    if (!_sectionSelectedArray) {
        _sectionSelectedArray=[NSMutableArray array];
    }
    return _sectionSelectedArray;
}

-(BOOL)sectionSelectedArrayContainsSection:(NSInteger)section{
    NSString* sectionStr=[NSString stringWithFormat:@"%d",(int)section];
    return  [self.sectionSelectedArray containsObject:sectionStr];
}

-(BOOL)sectionViewClickedWithSection:(NSInteger)section{
    NSString* sectionStr=[NSString stringWithFormat:@"%d",(int)section];
    BOOL isContainsSection=[self.sectionSelectedArray containsObject:sectionStr];
    SEL action=isContainsSection?@selector(removeObject:):@selector(addObject:);
    [self.sectionSelectedArray performSelector:action withObject:sectionStr];
    return isContainsSection;
}

-(void)addKeybordNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keybordWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keybordWillChangeFrame:(NSNotification *)noti{
    CGRect endFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    BOOL willBeFirstResponder = endFrame.origin.y < kScreenHeight;
    
    if (willBeFirstResponder) [self.chatMoreSelectView removeFromSuperview];
    if (self.chatMoreSelectView.superview&&!willBeFirstResponder) return;
    
    NSNumber* duration=noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect keybordBounds=endFrame;
    CGFloat upHeight=kScreenHeight-keybordBounds.origin.y;
    [self changeFrameWithUpHeight:upHeight duration:[duration floatValue]];
}

-(void)chatToolBarAddBtnClicked{
    CGFloat upHeight = 0;
    NSTimeInterval const duration = 0.25;
    if (self.chatToolBar.textView.isFirstResponder) {
        if (!self.chatMoreSelectView.superview) {
            [self.view addSubview:self.chatMoreSelectView];
            
            CGRect frame = self.chatMoreSelectView.frame;
            frame.origin.y = CGRectGetMaxY(self.chatToolBar.frame);
            self.chatMoreSelectView.frame = frame;
            
            upHeight = CGRectGetHeight(self.chatMoreSelectView.frame);
            [self changeFrameWithUpHeight:upHeight duration:duration];
        }
        [self.chatToolBar.textView resignFirstResponder];
    }else{
        if (!self.chatMoreSelectView.superview) {
            [self.view addSubview:self.chatMoreSelectView];
            
            CGRect frame = self.chatMoreSelectView.frame;
            frame.origin.y = CGRectGetMaxY(self.chatToolBar.frame);
            self.chatMoreSelectView.frame = frame;
            
            upHeight = CGRectGetHeight(self.chatMoreSelectView.frame);
            [self changeFrameWithUpHeight:upHeight duration:duration];
        }else{
            [self.chatMoreSelectView removeFromSuperview];
            [self.chatToolBar.textView becomeFirstResponder];
        }
    }
    
    if (!self.chatMoreSelectView.superview) return;
    CGRect frame = self.chatMoreSelectView.frame;
    frame.origin.y = CGRectGetMaxY(self.chatToolBar.frame);
    [UIView animateWithDuration:duration animations:^{
        self.chatMoreSelectView.frame = frame;
    }];
}

//聊天内容tableView和聊天工具条chatToolBar,键盘出来和moreSelectView出来时调的方法
//upHeight为离底部的距离
-(void)changeFrameWithUpHeight:(CGFloat)upHeight duration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration  animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.y = kScreenHeight-upHeight-CGRectGetHeight(self.chatToolBar.frame)-CGRectGetHeight(self.tableView.frame);
        self.tableView.frame = frame;
        
        frame = self.chatToolBar.frame;
        frame.origin.y = CGRectGetMaxY(self.tableView.frame);
        self.chatToolBar.frame = frame;
    }];
}

- (UIView *)chatMoreSelectView{
    if (!_chatMoreSelectView) {
        UIImageView* photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 59, 78)];
        photoImgView.userInteractionEnabled = YES;
        photoImgView.image = [GetImagePath getImagePath:@"会话－照片"];
        
        UIImageView* cameraImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 59, 78)];
        cameraImgView.userInteractionEnabled = YES;
        cameraImgView.image = [GetImagePath getImagePath:@"会话－拍摄"];
        
        _chatMoreSelectView = [ChatMoreSelectView chatMoreSelectViewWithViews:@[photoImgView,cameraImgView] delegate:self];
        _chatMoreSelectView.backgroundColor = AllBackLightGratColor;
    }
    return _chatMoreSelectView;
}

- (void)chatMoreSelectViewClickedWithIndex:(NSInteger)index{
    self.camera = [RKCamera cameraWithType:index allowEdit:YES deleate:self presentViewController:self.view.window.rootViewController demandSize:CGSizeZero needFullImage:YES];
}

- (void)cameraWillFinishWithLowQualityImage:(UIImage *)lowQualityimage originQualityImage:(UIImage *)originQualityImage isCancel:(BOOL)isCancel{
    NSLog(@"Base cameraWillFinishWithLowQualityImage");
}

//所有复原
-(void)touchesBeganInRKBaseTableView{
    
    BOOL chatToolBarIsFirstResponder = self.chatToolBar.textView.isFirstResponder;
    [self.view endEditing:YES];
    
    if (!self.chatToolBar) return;

    if (!chatToolBarIsFirstResponder&&!self.chatMoreSelectView.superview) return;

    CGRect frame = self.tableView.frame;
    CGFloat changeHeight = CGRectGetHeight(self.chatToolBar.frame)-[ChatToolBar orginChatToolBarHeight];
    frame.size.height = kScreenHeight-CGRectGetHeight(self.chatToolBar.frame)-64-self.tableViewOriginYFromNavi;
    frame.origin.y = CGRectGetMinY(self.chatToolBar.frame)-CGRectGetHeight(frame);
    self.tableView.frame = frame;
    
    CGPoint point = self.tableView.contentOffset;
    point.y += changeHeight;
    self.tableView.contentOffset = point;
    
    if (chatToolBarIsFirstResponder) return;
    //用于收moreSelectView
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.y = 64;
        
        self.tableView.frame = frame;
        
        frame = self.chatToolBar.frame;
        frame.origin.y = CGRectGetMaxY(self.tableView.frame);
        self.chatToolBar.frame = frame;
        
        frame = self.chatMoreSelectView.frame;
        frame.origin.y = kScreenHeight;
        self.chatMoreSelectView.frame = frame;
    } completion:^(BOOL finished) {
        [self.chatMoreSelectView removeFromSuperview];
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self touchesBeganInRKBaseTableView];
}

- (void)searchBarTableViewWillBeginDragging:(UITableView *)tableView{
    [self touchesBeganInSearchBarTableView];
}

- (void)touchesBeganInSearchBarTableView{
    [self.searchBar resignFirstResponder];
}

-(void)initStageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor{
    self.stageChooseView=[RKStageChooseView stageChooseViewWithStages:
                          stages numbers:numbers delegate:self underLineIsWhole:underLineIsWhole normalColor:normalColor highlightColor:highlightColor];
    CGRect frame=self.stageChooseView.frame;
    frame.origin=CGPointMake(0, 64);
    self.stageChooseView.frame=frame;
    
    [self.view addSubview:self.stageChooseView];
}

-(void)initChatToolBar{
    [self initChatToolBarWithNeedAddBtn:NO];
}

-(void)initChatToolBarWithNeedAddBtn:(BOOL)needAddBtn{
    self.chatToolBar=[ChatToolBar chatToolBarWithNeedAddBtn:needAddBtn];
    self.chatToolBar.delegate=self;
    self.chatToolBar.center=CGPointMake(kScreenWidth*0.5, kScreenHeight-CGRectGetHeight(self.chatToolBar.frame)*.5);
    [self.view addSubview:self.chatToolBar];
    
    if (self.tableView) {
        CGRect frame=self.tableView.frame;
        frame.size.height-=CGRectGetHeight(self.chatToolBar.frame);
        self.tableView.frame=frame;
    }
}

-(void)chatToolBarSizeChangeWithHeight:(CGFloat)height{
    NSLog(@"height=%f",height);
    CGRect frame = self.tableView.frame;
    frame.origin.y = CGRectGetMinY(self.chatToolBar.frame)-CGRectGetHeight(self.tableView.frame);
    self.tableView.frame = frame;
}

-(void)startLoadingViewWithOption:(NSInteger)option{
    UIView* backgroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    backgroundView.backgroundColor=option==0?[UIColor whiteColor]:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:.5];
    [self.view addSubview:backgroundView];
    
    self.indicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:option==0?UIActivityIndicatorViewStyleGray:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.center=backgroundView.center;
    [self.indicatorView startAnimating];
    [backgroundView addSubview:self.indicatorView];
}

-(void)stopLoadingView{
    [self.indicatorView stopAnimating];
    [self.indicatorView.superview removeFromSuperview];
    [self.indicatorView removeFromSuperview];
}

-(void)dealloc{
    self.tableView.delegate=nil;
    self.tableView.dataSource=nil;
    self.searchBar.delegate=nil;
    self.searchBarTableViewController.delegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpRefreshWithNeedHeaderRefresh:(BOOL)needHeaderRefresh needFooterRefresh:(BOOL)needFooterRefresh{
    if (needHeaderRefresh) [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    if (needFooterRefresh) [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)headerRereshing{

}

- (void)footerRereshing{
    
}

- (void)endHeaderRefreshing{
    [self.tableView headerEndRefreshing];
}

- (void)endFooterRefreshing{
    [self.tableView footerEndRefreshing];
}
@end
