//
//  ChatBaseViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/5.
//
//

#import <UIKit/UIKit.h>

@interface ChatBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
-(void)setRightBtnWithImage:(UIImage*)image;
-(void)rightBtnClicked;
-(void)setLeftBtnWithImage:(UIImage*)image;
-(void)leftBtnClicked;

-(void)setRightBtnWithText:(NSString*)text;

@property(nonatomic)BOOL leftBtnIsBack;
@property(nonatomic,strong)UITableView* tableView;
-(void)initTableView;

-(void)initSearchBar;
@end
