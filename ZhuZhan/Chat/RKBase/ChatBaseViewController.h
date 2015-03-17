//
//  ChatBaseViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>
#import "RKBaseTableView.h"

@protocol SearchBarTableViewDelegate <NSObject>
-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ChatBaseViewController : UIViewController<UITableViewDataSource,RKBaseTableViewDelegate,UISearchBarDelegate,SearchBarTableViewDelegate>
@property(nonatomic)BOOL needAnimaiton;

@property(nonatomic)BOOL leftBtnIsBack;
-(void)setLeftBtnWithImage:(UIImage*)image;
-(void)setLeftBtnWithText:(NSString*)text;
-(void)leftBtnClicked;

-(void)setRightBtnWithImage:(UIImage*)image;
-(void)setRightBtnWithText:(NSString*)text;
-(void)rightBtnClicked;

@property(nonatomic,strong)RKBaseTableView* tableView;
-(void)initTableView;

@property(nonatomic,strong)UISearchBar* searchBar;
-(void)setUpSearchBarWithNeedTableView:(BOOL)needTableView;

@property(nonatomic,strong)NSMutableArray* sectionSelectedArray;
-(BOOL)sectionSelectedArrayContainsSection:(NSInteger)section;
-(BOOL)sectionViewClickedWithSection:(NSInteger)section;

-(void)addKeybordNotification;
-(void)keybordWillChangeFrame:(NSNotification*)noti;
@end