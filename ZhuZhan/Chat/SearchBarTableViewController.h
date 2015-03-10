//
//  SearchBarTableViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/10.
//
//

#import "ChatBaseViewController.h"

@interface SearchBarTableViewController : ChatBaseViewController
@property(nonatomic,weak)id<SearchBarTableViewDelegate>delegate;
@end
