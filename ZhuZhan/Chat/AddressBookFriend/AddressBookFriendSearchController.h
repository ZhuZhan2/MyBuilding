//
//  AddressBookFriendSearchController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/14.
//
//

#import "SearchBarTableViewController.h"

@interface AddressBookFriendSearchController : SearchBarTableViewController
-(void)loadListWithKeyWords:(NSString*)keyWords;
@property (nonatomic, weak)NSArray* sqliteModels;
@end
