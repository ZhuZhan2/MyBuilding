//
//  PanViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import <UIKit/UIKit.h>


@protocol showControllerDelegate <NSObject>

-(void)jumpToGoToDetail;
-(void)jumpToGotoConcern;
-(void)jumpToGetRecommend:(NSDictionary *)dic;

@end

@interface ShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,showControllerDelegate>

@property (nonatomic,strong) UITableView *conFriendTableView;
@property (nonatomic,strong) id<showControllerDelegate>  delegate;

@end
