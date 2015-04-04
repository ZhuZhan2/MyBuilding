//
//  DemandDetailProvidePriceController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemanDetailViewController.h"

@protocol DemandDetailProvidePriceDelegate <NSObject>
-(void)backAndLoad;
@end

@interface DemandDetailProvidePriceController : DemanDetailViewController
@property(nonatomic,weak)id<DemandDetailProvidePriceDelegate>delegate;
@property(nonatomic)BOOL isFirstQuote;
@end
