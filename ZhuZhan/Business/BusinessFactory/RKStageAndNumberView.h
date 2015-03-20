//
//  RKStageAndNumberView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/19.
//
//

#import <UIKit/UIKit.h>

@interface RKStageAndNumberView : UIView
+(RKStageAndNumberView*)stageAndNumberViewWithStage:(NSString*)stage number:(NSInteger)number;
+(RKStageAndNumberView*)stageAndNumberViewWithStage:(NSString*)stage;
-(void)changeColor:(UIColor*)color;
-(void)changeNumber:(NSInteger)number;
-(CGFloat)stageLabelOriginX;
-(CGFloat)stageLabelWidth;
@end
