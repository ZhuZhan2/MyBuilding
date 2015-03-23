//
//  RKStageChooseView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/16.
//
//

#import <UIKit/UIKit.h>

@protocol RKStageChooseViewDelegate <NSObject>
-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber;
@end

@interface RKStageChooseView : UIView
+(RKStageChooseView*)stageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers delegate:(id<RKStageChooseViewDelegate>)delegate;
-(void)changeNumbers:(NSArray*)numbers;
@end
