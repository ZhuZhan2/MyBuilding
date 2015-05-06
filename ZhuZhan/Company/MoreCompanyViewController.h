//
//  MoreCompanyViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-4.
//
//

#import <UIKit/UIKit.h>

@interface MoreCompanyViewController : UIViewController{
    int startIndex;
}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic)BOOL isCompanyIdentify;
@property (nonatomic, strong)UIViewController* nowViewController;
@end
