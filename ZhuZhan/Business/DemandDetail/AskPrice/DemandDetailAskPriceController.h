//
//  DemandDetailAskPriceController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemanDetailViewController.h"
@protocol DemandDetailAskPriceDelegate <NSObject>
-(void)backAndLoad;
@end
@interface DemandDetailAskPriceController : DemanDetailViewController
@property(nonatomic,weak)id<DemandDetailAskPriceDelegate>delegate;
@property(nonatomic,strong)NSArray* invitedUserArr;
@end
