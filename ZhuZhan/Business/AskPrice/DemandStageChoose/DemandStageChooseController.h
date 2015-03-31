//
//  DemandStageChooseController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/23.
//
//

#import "ChatBaseViewController.h"

@protocol DemandStageChooseControllerDelegate <NSObject>
-(void)finishSelectedWithStageName:(NSString*)stageName index:(int)index;
@end

@interface DemandStageChooseController : ChatBaseViewController
@property(nonatomic,weak)id<DemandStageChooseControllerDelegate>delegate;
-(instancetype)initWithIndex:(NSInteger)index;
@end
