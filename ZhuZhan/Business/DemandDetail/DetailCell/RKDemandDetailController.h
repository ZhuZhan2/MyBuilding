//
//  RKDemandDetailController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import "ChatBaseViewController.h"
#import "DemandDetailViewCell.h"

@interface RKDemandDetailController : ChatBaseViewController<DemandDetailViewCellDelegate>
@property(nonatomic,strong)NSMutableArray* detailModels;
@property(nonatomic,weak)UIViewController* superViewController;
@end
