//
//  ChatBaseViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "RKBaseTableView.h"
#import "RKStageChooseView.h"
#import "ChatToolBar.h"
#import "ChatMoreSelectView.h"
#import "RKCamera.h"

@protocol SearchBarTableViewDelegate <NSObject>
-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(UIView *)searchBarTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
-(void)searchBarTableViewWillBeginDragging:(UITableView*)tableView;
- (void)touchesBeganInSearchBarTableView;

@end

@class SearchBarTableViewController;

@interface ChatBaseViewController : UIViewController<UITableViewDataSource,RKBaseTableViewDelegate,UISearchBarDelegate,SearchBarTableViewDelegate,RKStageChooseViewDelegate,ChatToolBarDelegate,ChatMoreSelectViewDelegate,RKCameraDelegate>

@property(nonatomic)BOOL needAnimaiton;

@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)UIButton* leftBtn;


@property(nonatomic)BOOL leftBtnIsBack;
-(void)setLeftBtnWithImage:(UIImage*)image;
-(void)setLeftBtnWithText:(NSString*)text;
-(void)leftBtnClicked;

-(void)setRightBtnWithImage:(UIImage*)image;
-(void)setRightBtnWithText:(NSString*)text;
-(void)rightBtnClicked;

@property(nonatomic,strong)RKBaseTableView* tableView;
@property(nonatomic,strong)UIView* tableViewNoDataView;
@property(nonatomic)CGFloat tableViewOriginYFromNavi;
-(void)initTableView;

@property(nonatomic,strong)UISearchBar* searchBar;
@property(nonatomic,weak)UIView* searchBarAnimationBackView;
-(void)setUpSearchBarWithNeedTableView:(BOOL)needTableView isTableViewHeader:(BOOL)isTableViewHeader;
-(void)appearAnimation:(UISearchBar *)searchBar;
-(void)disappearAnimation:(UISearchBar *)searchBar;
@property(nonatomic,weak)UIView* searchBarBackBtn;

@property(nonatomic,strong)SearchBarTableViewController* searchBarTableViewController;
@property(nonatomic,strong)RKBaseTableView* searchBarTableView;
@property(nonatomic,strong)UIView* searchBarTableViewNoDataView;
-(void)searchBarTableViewAppear;
-(void)setSearchBarTableViewBackColor:(UIColor*)color;

@property(nonatomic,strong)NSMutableArray* sectionSelectedArray;
-(BOOL)sectionSelectedArrayContainsSection:(NSInteger)section;
-(BOOL)sectionViewClickedWithSection:(NSInteger)section;

@property(nonatomic,strong)ChatToolBar* chatToolBar;
-(void)initChatToolBar;
-(void)initChatToolBarWithNeedAddBtn:(BOOL)needAddBtn;
@property(nonatomic,strong)UIView* chatMoreSelectView;
@property (nonatomic, strong)RKCamera* camera;

@property(nonatomic,strong)RKStageChooseView* stageChooseView;
-(void)initStageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor;

- (void)setUpRefreshWithNeedHeaderRefresh:(BOOL)needHeaderRefresh needFooterRefresh:(BOOL)needFooterRefresh;
- (void)headerRereshing;
- (void)footerRereshing;
- (void)endHeaderRefreshing;
- (void)endFooterRefreshing;


//0为白背景，1为黑透明背景
-(void)startLoadingViewWithOption:(NSInteger)option;
-(void)stopLoadingView;

-(void)addKeybordNotification;
-(void)keybordWillChangeFrame:(NSNotification*)noti;
-(void)reloadSearchBarTableViewData;
-(void)ClickedSearchBarSearchButton:(UISearchBar *)searchBar;
@end
