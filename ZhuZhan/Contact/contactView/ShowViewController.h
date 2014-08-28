//
//  PanViewController.h
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import <UIKit/UIKit.h>
#import "Pan.h"

@protocol showControllerDelegate <NSObject>

-(void)jumpToGoToDetail;
-(void)jumpToGotoConcern;
-(void)jumpToGetRecommend:(int)num;

@end

@interface ShowViewController : UIViewController<PanDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) Pan *pan;
@property (nonatomic,strong) UIView *transparent;
@property (nonatomic,strong) UITableView *conFriendTableView;
@property (nonatomic,strong) id<showControllerDelegate>  delegate;

@end
