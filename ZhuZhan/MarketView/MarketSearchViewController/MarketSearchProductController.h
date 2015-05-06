//
//  MarketSearchProductController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/5.
//
//

#import <UIKit/UIKit.h>

@interface MarketSearchProductController : UIViewController{
    NSMutableArray *showArr;
    int startIndex;
}
@property (nonatomic, weak)UIViewController* superViewController;
@property (nonatomic, strong)UITableView* tableView;
@property(nonatomic,strong)NSString *keyWords;
@property (nonatomic, strong)UIViewController* nowViewController;
@end
