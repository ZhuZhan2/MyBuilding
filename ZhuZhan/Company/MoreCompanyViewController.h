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
@property(nonatomic)BOOL isCompanyIdentify;
@end
