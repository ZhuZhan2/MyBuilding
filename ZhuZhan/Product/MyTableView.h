//
//  MyTableView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14/12/3.
//
//

#import <UIKit/UIKit.h>

@interface MyTableView : UITableView
@property(nonatomic,strong)NSString *className;
+(void)reloadDataWithTableView:(UITableView*)tableView;
+(void)hasData:(UITableView*)tableView;
+(void)noSearchData:(UITableView*)tableView;
+(void)removeFootView:(UITableView*)tableView;
@end
