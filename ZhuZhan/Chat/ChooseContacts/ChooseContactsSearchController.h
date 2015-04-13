//
//  ChooseContactsSearchController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/13.
//
//

#import "SearchBarTableViewController.h"

@interface ChooseContactsSearchController : SearchBarTableViewController
@property (nonatomic, strong)NSMutableArray* selectedUserIds;
-(void)loadListWithKeyWords:(NSString*)keyWords;
@end
