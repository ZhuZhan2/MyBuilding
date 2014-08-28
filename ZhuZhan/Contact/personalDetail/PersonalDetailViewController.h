//
//  PersonalDetailViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import <UIKit/UIKit.h>

@interface PersonalDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSArray *KindIndex;
@property (nonatomic,strong) NSArray *kImgArr;
@end
