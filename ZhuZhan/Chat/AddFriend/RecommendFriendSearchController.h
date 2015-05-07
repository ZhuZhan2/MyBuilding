//
//  RecommendFriendSearchController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/10.
//
//

#import "SearchBarTableViewController.h"

@class FriendModel;
@protocol RecommendFriendSearchControllerDelegate <NSObject>
- (void)headClickWithModel:(FriendModel*)model;
@end

@interface RecommendFriendSearchController : SearchBarTableViewController
-(void)loadListWithKeyWords:(NSString*)keyWords;
@property (nonatomic, strong)UIViewController* nowViewController;
@property (nonatomic, weak)id<RecommendFriendSearchControllerDelegate> headImageDelegate;
@property (nonatomic)BOOL isUsedFor;
@end
