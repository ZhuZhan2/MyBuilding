//
//  ChooseProductSmallStage.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/17.
//
//

#import "ChatBaseViewController.h"
@protocol ChooseProductSmallStageDelegate <NSObject>
-(void)chooseProductSmallStage:(NSArray *)arr;
@end
@interface ChooseProductSmallStage : ChatBaseViewController
@property(nonatomic,weak)id<ChooseProductSmallStageDelegate>delegate;
@property(nonatomic,strong)NSString *categoryId;
@end
