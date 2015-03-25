//
//  ChooseProductBigStage.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChatBaseViewController.h"

@protocol ChooseProductBigStageDelegate <NSObject>
-(void)chooseProductBigStage:(NSString *)str catroyId:(NSString *)catroyId;
@end

@interface ChooseProductBigStage : ChatBaseViewController
@property(nonatomic,weak)id<ChooseProductBigStageDelegate>delegate;
@end
