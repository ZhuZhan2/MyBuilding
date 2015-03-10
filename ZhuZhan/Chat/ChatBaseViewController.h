//
//  ChatBaseViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>

@protocol SearchBarTableViewDelegate <NSObject>
-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ChatBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SearchBarTableViewDelegate>
-(void)setRightBtnWithImage:(UIImage*)image;
-(void)rightBtnClicked;
-(void)setLeftBtnWithImage:(UIImage*)image;
-(void)leftBtnClicked;

-(void)setRightBtnWithText:(NSString*)text;
-(void)setLeftBtnWithText:(NSString*)text;

@property(nonatomic)BOOL leftBtnIsBack;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;

@property(nonatomic)BOOL isUsingSearchBar;
@property(nonatomic)BOOL needAnimaiton;

-(void)initTableView;

-(void)setUpSearchBarWithNeedTableView:(BOOL)needTableView;

-(void)reloadSearchBarTableViewData;

-(void)searchBarTableViewAppear;
-(void)searchBarTableViewDisppear;
@end
